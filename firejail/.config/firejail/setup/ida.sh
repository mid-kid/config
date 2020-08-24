#!/bin/sh
set -e

# This was mostly taken from the osu AUR package

prefix="${prefix:-$HOME/.local/opt/ida}"

export WINEARCH=win64
export WINEPREFIX="$prefix"

fetch() {
    echo "ERROR: Please copy the IDA installer to '$prefix/setup.exe' and run this again"
    exit 1
}

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    mv "$prefix/setup.exe" .
    winecfg
    exec wine setup.exe
}

run() {
    cd "$WINEPREFIX/dosdevices/c:/Program Files/IDA 7.0"
    exec wine "C:\\windows\\command\\start.exe" /Unix "$WINEPREFIX/dosdevices/c:/ProgramData/Microsoft/Windows/Start Menu/Programs/IDA Pro/IDA Pro (${1:-32}-bit).lnk"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -d "$prefix/drive_c" ]; then
    if [ ! -f "$prefix/setup.exe" ]; then
        fetch
    fi
    setup
else
    run "$@"
fi
