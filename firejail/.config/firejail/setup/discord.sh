#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/discord}"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://dl.discordapp.net/apps/linux/0.0.9/discord-0.0.9.tar.gz'
    tar xf 'discord-0.0.9.tar.gz'
    mkdir -p "$prefix"
    mv Discord/* "$prefix"
    chmod +x "$prefix/Discord"
}

run() {
    cd "$prefix"
    if command -v apulse 2> /dev/null; then
        exec apulse ./Discord "$@"
    else
        exec ./Discord "$@"
    fi
}

case "$1" in
    setup) shift; setup ;;
    run) shift; run ;;
esac

if [ ! -f "$prefix/Discord" ]; then
    setup
fi
run "$@"
