#!/bin/bash

SCRIPT_PATH=`readlink -f $0`
cd "${SCRIPT_PATH%/*}/xmobar-message" || exit $?

[ "./xmobar-message.cpp" -nt "./xmobar-message-bin" ] && {
    echo "Recompiling..."
    g++ -o xmobar-message-bin xmobar-message.cpp -std=c++23 -O2 -lxmm >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Failed to compile"
        exit 1
    fi
}

if [ ! -x "./xmobar-message-bin" ]; then
    echo "Executable xmobar-message-bin not found or not executable"
    exit 1
fi

echo ''
exec ./xmobar-message-bin
