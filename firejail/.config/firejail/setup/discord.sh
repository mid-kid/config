#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/discord}"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://dl.discordapp.net/apps/linux/0.0.8/discord-0.0.8.tar.gz'
    tar xf 'discord-0.0.8.tar.gz'
    mkdir -p "$prefix"
    mv Discord/* "$prefix"
    chmod +x "$prefix/Discord"
}

run() {
    cd "$prefix"
    ./Discord "$@"
}

case "$1" in
    setup) shift; setup ;;
    run) shift; run ;;
esac

if [ ! -f "$prefix/Discord" ]; then
    setup
fi
run "$@"
