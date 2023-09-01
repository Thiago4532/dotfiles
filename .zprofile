export EDITOR=nvim

export QT_QPA_PLATFORMTHEME=qt5ct
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANPAGER="less -s"

## XDG Base Directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# go configuration folder
export GOPATH=$XDG_DATA_HOME/go

# Firefox disable RDD sandbox
export MOZ_DISABLE_RDD_SANDBOX=1

if [ -n "$DESKTOP_SESSION" ]; then
    eval `gnome-keyring-daemon --start`
    export SSH_AUTH_SOCK
fi

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
fi

if mux_status; then
    export __EGL_VENDOR_LIBRARY_FILENAMES="/usr/share/glvnd/egl_vendor.d/10_nvidia.json"
    export __GLX_VENDOR_LIBRARY_NAME="nvidia"
else
    export __EGL_VENDOR_LIBRARY_FILENAMES="/usr/share/glvnd/egl_vendor.d/50_mesa.json"
    export __GLX_VENDOR_LIBRARY_NAME="mesa"
fi
