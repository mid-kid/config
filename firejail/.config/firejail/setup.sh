#!/bin/bash
set -e

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

extra_args=()

if [ "$1" = '--net' ]; then
    shift
    extra_args+="--ignore=net none"
fi

prog="$1"; shift
setup="$(realpath "$(dirname "$0")/setup")"
export prefix="$XDG_DATA_HOME/firejail/$prog"

if [ "$1" = shell ]; then
    shift
    exec firejail "${extra_args[@]}" --ignore='shell none' --profile="$XDG_CONFIG_HOME/firejail/$prog.profile" --join-or-start="$prog" "$@"
fi

if [ ! -d "$prefix" -o "$1" = fetch ]; then
    "$setup/$prog.sh" fetch
fi

if [ -z "$1" ]; then
    appimage=
    case "$prog" in
        ripcord) appimage=Ripcord.AppImage ;;
        listenmoe) appimage=LISTEN.moe.AppImage ;;
    esac
    if [ ! -z "$appimage" ]; then
        exec firejail --profile="$XDG_CONFIG_HOME/firejail/$prog.profile" --join-or-start="$prog" --appimage "$prefix/$appimage" "$@"
    fi
fi

if [ "$prog" = discord -o "$prog" = osu -o "$prog" = clonehero ]; then
    mkdir -p /tmp/discord-ipc/pulse
    ln -sf "$XDG_RUNTIME_DIR/pulse"/* /tmp/discord-ipc/pulse/
fi

tmp="$(mktemp -d --tmpdir "firejail-$prog.XXXXXX")"
trap "rm -rf '$tmp'" EXIT

cp "$setup/$prog.sh" "$tmp"
firejail "${extra_args[@]}" --whitelist="$tmp" --profile="$XDG_CONFIG_HOME/firejail/$prog.profile" --join-or-start="$prog" sh "$tmp/$prog.sh" "$@"
