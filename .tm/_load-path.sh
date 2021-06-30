#!/bin/sh

export PATH="$PATH$(

add_path() {
    printf ":%s" "$@"
}

DIRPATH=`dirname $0`

add_path "$DIRPATH/bin"

)"
