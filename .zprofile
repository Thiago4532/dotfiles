export EDITOR=nvim

export QT_QPA_PLATFORMTHEME=qt5ct
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

## XDG Base Directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# go configuration folder
export GOPATH=$XDG_DATA_HOME/go

# Firefox disable RDD sandbox
export MOZ_DISABLE_RDD_SANDBOX=1

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
fi
