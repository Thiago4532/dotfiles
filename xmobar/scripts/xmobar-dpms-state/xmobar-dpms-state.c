#include <stdio.h>
#include <stdlib.h>

#include <X11/Xlib.h>
#include <X11/extensions/dpms.h>

int main(void) {
    Display *display = XOpenDisplay(NULL);
    if (display == NULL) {
        fprintf(stderr, "failed to open X display\n");
        return 2;
    }

    int event_base = 0;
    int error_base = 0;
    if (!DPMSQueryExtension(display, &event_base, &error_base)) {
        fprintf(stderr, "DPMS extension is not available\n");
        XCloseDisplay(display);
        return 2;
    }

    if (!DPMSCapable(display)) {
        fprintf(stderr, "DPMS is not supported on this display\n");
        XCloseDisplay(display);
        return 2;
    }

    CARD16 power_level = 0;
    BOOL state = False;
    if (!DPMSInfo(display, &power_level, &state)) {
        fprintf(stderr, "failed to query DPMS state\n");
        XCloseDisplay(display);
        return 2;
    }

    (void)power_level;

    if (state) {
        puts("true");
        XCloseDisplay(display);
        return 0;
    }

    puts("false");
    XCloseDisplay(display);
    return 0;
}
