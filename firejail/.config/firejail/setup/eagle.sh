#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/eagle}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://eagle-updates.circuits.io/downloads/9_3_2/Autodesk_EAGLE_9.3.2_English_Linux_64bit.tar.gz'
    tar xf 'Autodesk_EAGLE_9.3.2_English_Linux_64bit.tar.gz'
    mkdir -p "$prefix"
    mv eagle-9.3.2/* "$prefix"
}

run() {
    cd "$prefix"
    exec ./eagle "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/eagle" ]; then
    fetch
fi
run "$@"
