#!/bin/sh
set -e

prog="$1"; shift

tmp="$(mktemp -d --tmpdir "firejail-$prog.XXXXXX")"
trap "rm -rf '$tmp'" EXIT

setup="$(realpath "$(dirname "$0")/setup")"
export prefix="$HOME/.firejail/$prog"

if [ "$1" = 'shell' ]; then
    shift
    firejail --ignore='shell none' --profile="~/.config/firejail/$prog.profile" --join-or-start="$prog" "$@"
    exit
fi

mkdir -p "$prefix"
if [ "$prog" = ripcord ]; then
    if [ -z "$1" ] ; then
        firejail --profile="~/.config/firejail/$prog.profile" --join-or-start="$prog" --appimage "$prefix/Ripcord.AppImage" "$@"
    fi
fi

cp "$setup/$prog.sh" "$tmp"

firejail --whitelist="$tmp" --profile="~/.config/firejail/$prog.profile" --join-or-start="$prog" sh "$tmp/$prog.sh" "$@"
