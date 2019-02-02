#!/bin/sh
set -e

prog="$1"; shift

tmp="$(mktemp -d --tmpdir "firejail-$prog.XXXXXX")"
trap "rm -rf '$tmp'" EXIT

setup="$(realpath "$(dirname "$0")/setup")"
prefix="$HOME/.firejail/$prog"

setup() {
    (
        mkdir -p "$prefix"
        export prefix
        cp "$setup/$prog.sh" "$tmp"
        firejail --whitelist="$tmp" --ignore='noexec /tmp' --profile="~/.config/firejail/$prog.profile" sh "$tmp/$prog.sh" setup
    )
}

run() {
    (
        export prefix
        cp "$setup/$prog.sh" "$tmp"
        firejail --join-or-start="$prog" --whitelist="$tmp" --profile="~/.config/firejail/$prog.profile" sh "$tmp/$prog.sh" run
    )
}

shell() {
    firejail --join-or-start="$prog" --ignore='shell none' --profile="~/.config/firejail/osu.profile"
}

case "$1" in
    setup) setup; exit ;;
    shell) shell; exit ;;
esac

if [ ! -d "$prefix" ]; then
    setup
else
    run
fi
