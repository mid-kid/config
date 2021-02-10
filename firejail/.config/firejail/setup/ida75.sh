#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/ida75}"

export WINEARCH=win64
export WINEPREFIX="$prefix"

version_python=3.9.1

download() {
    url="$1"
    fname="${2:-$(basename "$url")}"
    if [ ! -e "$fname" ]; then
        wget -O "$fname" "$url"
    fi
}

fetch() {
    mkdir -p "$prefix"
    cd "$prefix"

    # Upgrade files for python 3.9 because why not
    #download https://www.hex-rays.com/wp-content/uploads/2020/12/ida75sp3_python39_win.zip
    #download https://www.python.org/ftp/python/$version_python/python-$version_python-amd64.exe
}

setup() {
    if [ ! -d "$prefix/IDA Pro 7.5" ]; then
        echo "ERROR: Please copy the IDA files to '$prefix/IDA Pro 7.5' and run this again"
        exit 1
    fi

    #echo "IMPORTANT: Set windows version to windows 10!"
    winecfg
    #echo "IMPORTANT: Customize installation -> Install for all users!!!"
    #wine "$prefix/python-$version_python-amd64.exe"
    #rm "$prefix/python-$version_python-amd64.exe"

    mkdir -p "$WINEPREFIX/drive_c/Program Files"
    mv -v "$prefix/IDA Pro 7.5" "$WINEPREFIX/drive_c/Program Files"
    #unzip -o -d "$WINEPREFIX/drive_c/Program Files/IDA Pro 7.5" "$prefix/ida75sp3_python39_win.zip"
    #rm "$prefix/ida75sp3_python39_win.zip"
    #wine "$WINEPREFIX/drive_c/Program Files/IDA Pro 7.5/idapyswitch.exe" -a
}

run() {
    cd "$WINEPREFIX/drive_c/Program Files/IDA Pro 7.5"
    exec wine "ida${1:-}.exe"
}

case "$1" in
    fetch) shift; fetch; exit ;;
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -d "$prefix/drive_c/Program Files/IDA Pro 7.5" ]; then
    fetch
    setup
fi
run "$@"
