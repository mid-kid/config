#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/discord}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT
    cd "$tmp"

    wget 'https://dl.discordapp.net/apps/linux/0.0.13/discord-0.0.13.tar.gz'
    tar xf 'discord-0.0.13.tar.gz'
    mkdir -p "$prefix"
    mv Discord/* "$prefix"
    chmod +x "$prefix/Discord"
}

better() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT
    cd "$tmp"

    wget 'https://raw.githubusercontent.com/bb010g/betterdiscordctl/master/betterdiscordctl'
    chmod +x 'betterdiscordctl'
    ./betterdiscordctl -d "$prefix" -m "${XDG_CONFIG_HOME:-$HOME/.config}/discord/0.0.10/modules/" "$@"
}

run() {
    cd "$prefix"
    if command -v apulse > /dev/null 2> /dev/null; then
        exec apulse ./Discord "$@"
    else
        exec ./Discord "$@"
    fi
}

case "$1" in
    fetch) shift; fetch; exit ;;
    better) shift; better "$@"; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/Discord" ]; then
    fetch
fi
run "$@"
