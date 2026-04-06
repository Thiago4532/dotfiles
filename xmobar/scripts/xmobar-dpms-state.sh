#!/bin/bash

SCRIPT_PATH=$(readlink -f "$0")
cd "${SCRIPT_PATH%/*}/xmobar-dpms-state" || exit $?

[ "./xmobar-dpms-state.c" -nt "./xmobar-dpms-state-bin" ] && {
    echo "Recompiling..."
    gcc -o xmobar-dpms-state-bin xmobar-dpms-state.c -O2 -lX11 -lXext >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Failed to compile"
        exit 1
    fi
}

if [ ! -x "./xmobar-dpms-state-bin" ]; then
    echo "Executable xmobar-dpms-state-bin not found or not executable"
    exit 1
fi

exec ./xmobar-dpms-state-bin
