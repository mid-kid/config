#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ripcord}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://cancel.fm/dl/Ripcord-0.4.26-x86_64.AppImage'
    mkdir -p "$prefix"
    mv 'Ripcord-0.4.26-x86_64.AppImage' "$prefix/Ripcord.AppImage"
    chmod +x "$prefix/Ripcord.AppImage"
}

run() {
    cd "$prefix"
    ./Ripcord.AppImage "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/Ripcord.AppImage" ]; then
    fetch
fi
run "$@"
