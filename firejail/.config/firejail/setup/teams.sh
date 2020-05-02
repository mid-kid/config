#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/teams}"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://packages.microsoft.com/yumrepos/ms-teams/teams-1.3.00.5153-1.x86_64.rpm'
    rpm2tar 'teams-1.3.00.5153-1.x86_64.rpm'
    tar xf 'teams-1.3.00.5153-1.x86_64.tar'
    mkdir -p "$prefix"
    mv usr "$prefix"
}

run() {
    cd "$prefix"
    LD_LIBRARY_PATH="$PWD/libsecret/lib:$LD_LIBRARY_PATH" exec ./usr/bin/teams "$@"
}

case "$1" in
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/usr/bin/teams" ]; then
    setup
fi
run "$@"
