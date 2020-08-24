#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/telegram}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://updates.tdesktop.com/tlinux/tsetup.1.6.7.tar.xz'
    tar xf 'tsetup.1.6.7.tar.xz'
    mkdir -p "$prefix"
    mv Telegram/* "$prefix"
}

run() {
    cd "$prefix"
    exec ./Telegram "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/Telegram" ]; then
    fetch
fi
run "$@"
