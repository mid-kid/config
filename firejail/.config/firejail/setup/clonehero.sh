#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/clonehero}"

export PULSE_LATENCY_MSEC=22

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'http://dl.clonehero.net/clonehero-v.23.2.2/clonehero-linux.tar.gz'
    tar xf 'clonehero-linux.tar.gz'
    mkdir -p "$prefix"
    mv clonehero-linux/* "$prefix"
    chmod +x "$prefix/clonehero"
}

run() {
    cd "$prefix"
    $exec ./clonehero
    vblank_mode=0
}

# Discord wants a PID higher than 10???
exec=exec
if [ -e $XDG_RUNTIME_DIR/discord-ipc-0 ]; then
    exec=''
    for x in $(seq 1 10); do /bin/true; done
fi

case "$1" in
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/clonehero" ]; then
    setup
fi
run "$@"
