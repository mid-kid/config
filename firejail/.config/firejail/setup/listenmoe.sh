#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/listenmoe}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://github.com/LISTEN-moe/desktop-app/releases/download/0.3.0/LISTEN.moe-0.3.0.AppImage'
    mkdir -p "$prefix"
    mv 'LISTEN.moe-0.3.0.AppImage' "$prefix/LISTEN.moe.AppImage"
    chmod +x "$prefix/LISTEN.moe.AppImage"
}

run() {
    cd "$prefix"
    ./LISTEN.moe.AppImage "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/LISTEN.moe.AppImage" ]; then
    fetch
fi
run "$@"
