#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/slack}"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT
    cd "$tmp"

    wget 'https://downloads.slack-edge.com/linux_releases/slack-4.1.1-0.1.fc21.x86_64.rpm'
    rpm2tar 'slack-4.1.1-0.1.fc21.x86_64.rpm'
    tar xf 'slack-4.1.1-0.1.fc21.x86_64.tar'
    mkdir -p "$prefix"
    mv usr etc "$prefix"
}

run() {
    cd "$prefix"
    exec ./usr/bin/slack "$@"
}

case "$1" in
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/usr/bin/slack" ]; then
    setup
fi
run "$@"
