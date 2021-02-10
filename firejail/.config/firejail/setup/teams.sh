#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/teams}"

fetch() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://packages.microsoft.com/yumrepos/ms-teams/teams-1.3.00.16851-1.x86_64.rpm'
    rpm2tar 'teams-1.3.00.16851-1.x86_64.rpm'
    tar xf 'teams-1.3.00.16851-1.x86_64.tar'
    mkdir -p "$prefix"
    mv usr "$prefix"
}

run() {
    cd "$prefix"
    LD_LIBRARY_PATH="$PWD/libsecret:$LD_LIBRARY_PATH" exec sh -x ./usr/bin/teams "$@"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/usr/bin/teams" ]; then
    fetch
fi
run "$@"
