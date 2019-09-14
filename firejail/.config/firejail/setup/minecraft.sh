#!/bin/sh
set -e

prefix="${prefix:-$HOME/.local/opt/minecraft}"

setup() {
    tmp=$(mktemp -d)
    trap "rm -rf '$tmp'" EXIT

    cd "$tmp"
    wget 'https://launcher.mojang.com/download/Minecraft.tar.gz'
    tar xf Minecraft.tar.gz
    mv minecraft-launcher/* "$prefix"
}

run() {
    if [ ! -f /usr/lib64/libgconf-2.so ]; then
        echo "TIP: You might have to install gconf"
    fi

    cd "$prefix"
    if [ "$1" = "ftb" ]; then
        shift
        $JAVA_HOME/bin/java -jar ./FTB_Launcher.jar "$@"
    else
        ./minecraft-launcher "$@"
    fi
}

case "$1" in
    setup) shift; setup; exit ;;
    run) shift; run "$@"; exit ;;
esac

if [ ! -f "$prefix/minecraft-launcher" ]; then
    setup
fi
run "$@"
