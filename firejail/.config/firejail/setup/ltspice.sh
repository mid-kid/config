#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ltspice}"

export WINEARCH=win64
export WINEPREFIX="$prefix"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'http://ltspice.analog.com/software/LTspiceXVII.exe'
    winecfg
    exec wine "$tmp/LTspiceXVII.exe"
}

run() {
    exec wine "C:\\windows\\command\\start.exe" /Unix "$WINEPREFIX/dosdevices/c:/users/$USER/Start Menu/LTspice XVII.lnk"
}

case "$1" in
    fetch) exit ;;  # Installation requires download
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -d "$prefix/drive_c" ]; then
    setup
else
    run "$@"
fi
