#!/bin/sh
set -e

prog="$1"; shift

if [ "$1" = 'shell' ]; then
    shift
    firejail --ignore='shell none' --profile="~/.config/firejail/$prog.profile" --join-or-start="$prog" "$@"
    exit
fi

setup="$(realpath "$(dirname "$0")/setup")"
export prefix="$HOME/.firejail/$prog"

mkdir -p "$prefix"
if [ -z "$1" -a "$prog" = ripcord ]; then
    firejail --profile="~/.config/firejail/$prog.profile" --join-or-start="$prog" --appimage "$prefix/Ripcord.AppImage" "$@"
    exit
fi

tmp="$(mktemp -d --tmpdir "firejail-$prog.XXXXXX")"
trap "rm -rf '$tmp'" EXIT

cp "$setup/$prog.sh" "$tmp"

firejail --whitelist="$tmp" --profile="~/.config/firejail/$prog.profile" --join-or-start="$prog" sh "$tmp/$prog.sh" "$@"
