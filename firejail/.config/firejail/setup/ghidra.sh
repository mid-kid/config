#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ghidra}"

fetch() {
    tmp=$(mktemp -d -p /var/tmp)  # This package is huge
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://ghidra-sre.org/ghidra_9.2.2_PUBLIC_20201229.zip'
    unzip 'ghidra_9.2.2_PUBLIC_20201229.zip'
    mkdir -p "$prefix"
    mv ghidra_9.2.2_PUBLIC/* "$prefix"
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
