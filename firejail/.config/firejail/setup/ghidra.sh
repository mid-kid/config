#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ghidra}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://ghidra-sre.org/ghidra_9.1.2_PUBLIC_20200212.zip'
    unzip 'ghidra_9.1.2_PUBLIC_20200212.zip'
    mkdir -p "$prefix"
    mv ghidra_9.1.2_PUBLIC/* "$prefix"
}

run() {
    cd "$prefix"
    exec ./ghidraRun "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -e "$prefix/ghidraRun" ]; then
    fetch
fi
run "$@"
