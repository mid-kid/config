#!/bin/bash
set -e

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

extra_args=()

if [ "$1" = '--net' ]; then
    shift
    extra_args+="--ignore=net none"
fi

prog="$1"; shift

if [ "$1" = 'shell' ]; then
    shift
    firejail "${extra_args[@]}" --ignore='shell none' --profile="$XDG_CONFIG_HOME/firejail/$prog.profile" --join-or-start="$prog" "$@"
    exit
fi

setup="$(realpath "$(dirname "$0")/setup")"
export prefix="$HOME/.firejail/$prog"

mkdir -p "$prefix"
if [ -z "$1" -a "$prog" = ripcord ]; then
    exec firejail --profile="$XDG_CONFIG_HOME/firejail/$prog.profile" --join-or-start="$prog" --appimage "$prefix/Ripcord.AppImage" "$@"
fi

if [ "$prog" = discord -o "$prog" = osu -o "$prog" = clonehero ]; then
    mkdir -p /tmp/discord-ipc/pulse
    ln -sf "$XDG_RUNTIME_DIR/pulse"/* /tmp/discord-ipc/pulse/
fi

tmp="$(mktemp -d --tmpdir "firejail-$prog.XXXXXX")"
trap "rm -rf '$tmp'" EXIT

cp "$setup/$prog.sh" "$tmp"
firejail "${extra_args[@]}" --whitelist="$tmp" --profile="$XDG_CONFIG_HOME/firejail/$prog.profile" --join-or-start="$prog" sh "$tmp/$prog.sh" "$@"
