#!/bin/sh
set -e

# This was mostly taken from the osu AUR package

prefix="${prefix:-$HOME/.local/opt/ida}"

export WINEARCH=win64
export WINEPREFIX="$prefix"

setup() {
    if [ ! -f "$prefix/setup.exe" ]; then
        echo "ERROR: Please copy the IDA installer to '$prefix/setup.exe' and run this again"
        exit 1
    fi

    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    mv "$prefix/setup.exe" .
    exec wine setup.exe
}

run() {
    cd "$WINEPREFIX/dosdevices/c:/Program Files/IDA 7.0"
    exec wine "C:\\windows\\command\\start.exe" /Unix "$WINEPREFIX/dosdevices/c:/ProgramData/Microsoft/Windows/Start Menu/Programs/IDA Pro/IDA Pro (${1:-32}-bit).lnk"
}

case "$1" in
    setup) shift; setup ;;
    run) shift; run ;;
esac

if [ ! -d "$prefix/drive_c" ]; then
    setup
else
    run
fi
