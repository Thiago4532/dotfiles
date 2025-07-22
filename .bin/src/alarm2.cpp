#include <csignal>
#include <cstring>
#include <iostream>
#include <memory>
#include <xmm/print.hpp>
#include <X11/Xlib.h>
#include <X11/extensions/scrnsaver.h>
#include <spawn.h>
#include <unistd.h>
#include <sys/wait.h>
#include <unordered_map>

using namespace xmm::literals;

template<typename... Args> requires xmm::Printable<Args...>
[[noreturn]] void panic(Args&&... args) {
    xmm::print("alarm2: ");
    xmm::println(std::forward<Args>(args)...);
    std::exit(1);
}

class SimpleProcess;

class IdleDetector {
public:
    IdleDetector() {
        dpy = XOpenDisplay(NULL);
        if (!dpy)
            panic("Failed to open display");

        info = XScreenSaverAllocInfo();
        if (!info)
            panic("XScreenSaverAllocInfo failed");
    }

    auto idle() {
        if (!XScreenSaverQueryInfo(dpy, DefaultRootWindow(dpy), info))
            panic("XScreenSaverQueryInfo failed");
        return info->idle;
    }

    ~IdleDetector() {
        if (info)
            XFree(info);
        if (dpy)
            XCloseDisplay(dpy);
    }
private:
    Display *dpy;
    XScreenSaverInfo *info;
};

class zstring_view {
public:
    zstring_view(const char* str) : view_(str) { }

    operator const char*() const { return view_.data(); }
    operator std::string_view() const { return view_; }
    operator std::string() const { return std::string(view_); }

    bool empty() const { return view_.empty(); }
    size_t size() const { return view_.size(); }
    const char* data() const { return view_.data(); }

    const char back() const {
        return view_.back();
    }

    const char& operator[](size_t index) const {
        return view_[index];
    }
private:
    std::string_view view_;
};

long current_time() {
    struct timespec ts;
    if (clock_gettime(CLOCK_MONOTONIC, &ts) == -1) {
        panic("clock_gettime failed: {}"_f, strerror(errno));
    }
    return ts.tv_sec * 1000 + ts.tv_nsec / 1000000; // Convert to milliseconds
}

decltype(auto) msleep(long milliseconds) {
    struct timespec ts;
    ts.tv_sec = milliseconds / 1000;
    ts.tv_nsec = (milliseconds % 1000) * 1000000;
    return nanosleep(&ts, nullptr);
}

struct SigChldBlocker {
    SigChldBlocker() {
        sigemptyset(&mask);
        sigaddset(&mask, SIGCHLD);
        if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
            panic("sigprocmask failed: {}"_f, strerror(errno));
    }

    ~SigChldBlocker() {
        if (sigprocmask(SIG_UNBLOCK, &mask, NULL) == -1)
            panic("sigprocmask failed: {}"_f, strerror(errno));
    }

    sigset_t mask;
};

class SimpleProcess {
public:
    SimpleProcess() = default;
    SimpleProcess(const SimpleProcess&) = delete;
    SimpleProcess& operator=(const SimpleProcess&) = delete;
    SimpleProcess(SimpleProcess&& other) noexcept
        : pid_(other.pid_), running_(other.running_), spawned_(other.spawned_) {
        other.pid_ = -1;
        other.running_ = false;
        other.spawned_ = false;
    }
    SimpleProcess& operator=(SimpleProcess&& other) noexcept {
        if (this != &other) {
            pid_ = other.pid_;
            running_ = other.running_;
            spawned_ = other.spawned_;
            other.pid_ = -1;
            other.running_ = false;
            other.spawned_ = false;
        }
        return *this;
    }

    ~SimpleProcess() {
        if (running_)
            kill();
    }

    void spawn(std::initializer_list<zstring_view> args) {
        auto argv = std::make_unique<const char*[]>(args.size() + 1);

        size_t len = 0;
        for (const auto& arg : args) {
            argv[len++] = arg;
        }
        argv[len] = nullptr;
        return _spawn(argv.get());
    }

    template<typename... Args>
    void spawn(Args&&... args) {
        const char* argv[] = { std::forward<Args>(args)..., nullptr };
        return _spawn(argv);
    }

    bool running() const {
        if (!spawned_ || !running_)
            return false;

        int status;
        pid_t result = waitpid(pid_, &status, WNOHANG);
        if (result == -1) {
            panic("waitpid failed: {}"_f, strerror(errno));
        } else if (result == 0) {
            return true;
        } else {
            running_ = false;
            return false;
        }
    }
    
    void wait() {
        if (!spawned_)
            panic("Process has not been spawned yet");
        if (!running_)
            return;

        int status;
        for (;;) {
            int ret = waitpid(pid_, &status, 0);
            if (ret == -1) {
                if (errno == EINTR) {
                    std::cout << "waitpid interrupted, retrying..." << std::endl;
                    continue;
                }
                else
                    panic("waitpid failed: {}"_f, strerror(errno));
            } 
            break;
        }
        running_ = false;
    }

    bool wait(long timeout) {
        if (!spawned_)
            panic("Process has not been spawned yet");

        SigChldBlocker b;
        auto& mask = b.mask;

        struct timespec ts = { timeout / 1000, (timeout % 1000) * 1000000 };

        int status;
        if (!running())
            return true;

        long start_time = current_time();
        while(true) {
            siginfo_t info;
            if (sigtimedwait(&mask, &info, &ts) == -1 && !(errno == EAGAIN || errno == EINTR))
                panic("sigtimedwait failed: {}"_f, strerror(errno));
            if (!running())
                return true;

            long time = current_time();
            long elapsed = time - start_time;
            if (elapsed >= timeout)
                return false;
            start_time = time;
            timeout -= elapsed;
            ts.tv_sec = timeout / 1000;
            ts.tv_nsec = (timeout % 1000) * 1000000;
        }
    }

    void kill(long timeout = 5000) {
        if (!spawned_)
            panic("Process has not been spawned yet");
        if (!running_)
            return;

        if (timeout > 0) {
            ::kill(pid_, SIGTERM); 
            if (wait(timeout))
                return;
        }

        ::kill(pid_, SIGKILL);
        wait();
    }

private:
    pid_t pid_ = -1;
    mutable bool running_ = false;
    bool spawned_ = false;

    void _spawn(const char* args[]) {
        if (running_)
            panic("Process {} is already running"_f, pid_);
        pid_ = -1;
        spawned_ = false;
        running_ = false;

        auto argv = const_cast<char**>(args);

        posix_spawnattr_t attr;
        posix_spawnattr_init(&attr);
        posix_spawnattr_setflags(&attr, POSIX_SPAWN_SETSIGDEF);

        if (posix_spawnp(&pid_, argv[0], nullptr, &attr, argv, environ) != 0)
            panic("Failed to spawn process: {}"_f, strerror(errno));
        running_ = true;
        spawned_ = true;
    }
};

int main(int argc, char* argv[]) {
    if (argc < 2) {
        xmm::eprintln("Usage: alarm2 <title> [description]");
        return 1;
    }
    const char* title = argv[1];
    const char* description = (argc > 2) ? argv[2] : nullptr;

    // {
    //     static constexpr auto noop = [](int) {
    //     };
    //     struct sigaction sa {0};
    //     sa.sa_handler = noop;
    //     sigaction(SIGCHLD, &sa, nullptr);
    // }

    IdleDetector idleDetector;
    SimpleProcess process;

    if (description) {
        process.spawn("alarm", title, description);
    } else {
        process.spawn("alarm", title);
    }

    while (true) {
        if (process.wait(1000))
            break;
        long idle_time = idleDetector.idle();
        if (idle_time < 1500)
            break;
    }

    return 0;
}
