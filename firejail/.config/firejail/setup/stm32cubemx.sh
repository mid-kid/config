#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/stm32cubemx}"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://www.st.com/resource/en/library2/stm32cube_mx_v550.zip'
    mkdir -p "$prefix"
    unzip 'stm32cube_mx_v550.zip' -d "$prefix"
    mv "$prefix/STM32CubeMX.exe" "$prefix/STM32CubeMX"
}

run() {
    cd "$prefix"
    java -jar STM32CubeMX "$@"
}

case "$1" in
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/STM32CubeMX" ]; then
    setup
fi
run "$@"
