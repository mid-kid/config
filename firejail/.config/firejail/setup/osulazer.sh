#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/osulazer}"

export PULSE_LATENCY_MSEC=22

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://github.com/ppy/osu/releases/latest/download/osu.AppImage'
    mkdir -p "$prefix"
    mv 'osu.AppImage' "$prefix/osu.AppImage"
    chmod +x "$prefix/osu.AppImage"
}

run() {
    cd "$prefix"
    ./osu.AppImage "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/osu.AppImage" ]; then
    fetch
fi
run "$@"
