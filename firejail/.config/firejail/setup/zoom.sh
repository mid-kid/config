#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/zoom}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://zoom.us/client/latest/zoom_x86_64.tar.xz'
    tar xf 'zoom_x86_64.tar.xz'
    mkdir -p "$prefix"
    mv zoom/* "$prefix"
}

run() {
    cd "$prefix"
    LD_LIBRARY_PATH="$PWD" exec ./ZoomLauncher "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/ZoomLauncher" ]; then
    fetch
fi
run "$@"
