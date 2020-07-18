#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/arduino}"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://downloads.arduino.cc/arduino-1.8.13-linux64.tar.xz'
    tar xf 'arduino-1.8.13-linux64.tar.xz'
    mkdir -p "$prefix"
    mv arduino-1.8.13/* "$prefix"
}

run() {
    cd "$prefix"
    ./arduino "$@"
}

case "$1" in
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/arduino" ]; then
    setup
fi
run "$@"
