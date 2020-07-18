#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ripcord}"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://cancel.fm/dl/Ripcord-0.4.26-x86_64.AppImage'
    mv 'Ripcord-0.4.26-x86_64.AppImage' "$prefix/Ripcord.AppImage"
    chmod +x "$prefix/Ripcord.AppImage"
}

run() {
    cd "$prefix"
    ./Ripcord.AppImage "$@"
}

case "$1" in
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/Ripcord.AppImage" ]; then
    setup
fi
run "$@"
