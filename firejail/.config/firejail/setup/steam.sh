#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/steam}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://repo.steampowered.com/steam/archive/precise/steam_1.0.0.68.tar.gz'
    tar xf 'steam_1.0.0.68.tar.gz'
    mkdir -p "$prefix"
    mv steam-launcher/* "$prefix"
}

run() {
    cd "$prefix"
    export PROTON_USE_WINED3D=1
    exec ./steam "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -e "$prefix/steam" ]; then
    fetch
fi
run "$@"
