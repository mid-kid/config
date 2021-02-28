#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/arduino}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://downloads.arduino.cc/arduino-1.8.13-linux64.tar.xz'
    tar xf 'arduino-1.8.13-linux64.tar.xz'
    mkdir -p "$prefix"
    mv arduino-1.8.13/* "$prefix"
}

run() {
    # XDG Base Directory specification
    XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
    mkdir -p "$XDG_DATA_HOME/arduino"
    ln -sf "$XDG_DATA_HOME/arduino" "$HOME/.arduino15"

    cd "$prefix"
    exec ./arduino "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/arduino" ]; then
    fetch
fi
run "$@"
