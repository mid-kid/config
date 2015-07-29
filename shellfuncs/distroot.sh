distroot() {
    local arch="x86_64"
    local dir="$HOME/.distroot"
    local bindir="$dir/bin"
    local tmpdir="$dir/tmp"
    local scriptdir="$HOME/.shellfuncs/distroot"
    local distdir="$scriptdir/dists"

    # Args
    if [ "$1" = "user" ]; then
        shift
        local user=true
    fi
    local dist="$1"; shift

    if [ ! -f "$bindir/proot" ]; then
        echo "Installing proot"
        mkdir -p "$bindir"
        curl -L "http://portable.proot.me/proot-$arch" -o "$bindir/proot"
        chmod +x "$bindir/proot"
    fi

    if [ ! -f "$dir/.$dist" ]; then
        # Exit if we don't have a script for this distro
        if [ ! -f "$distdir/$dist" ]; then
            echo "Don't know about a distribution called $dist"
            return
        fi

        # Make sure we can use that dir.
        [ -d "$dir/$dist" ] && sudo rm -rf "$dir/$dist"

        mkdir -p "$dir/$dist"
        mkdir -p "$tmpdir/$dist"

        echo "Creating chroot for distribution: $dist"
        if PATH="$bindir:$PATH" "$distdir/$dist" "$scriptdir" "$arch" "$tmpdir/$dist" "$dir/$dist"; then
            if [ -f "$tmpdir/$dist/shell" ]; then
                cp "$tmpdir/$dist/shell" "$dir/.$dist"
            else
                touch "$dir/.$dist"
            fi
        fi
    fi

    # Set up the command
    if [ "$*" ]; then
        local command="$*"
    elif [ "$(cat "$dir/.$dist")" ]; then
        local command="$(cat "$dir/.$dist")"
    fi

    if [ -f "$dir/.$dist" ]; then
        if [ "$user" ]; then
            PATH="$bindir:$PATH" sh -c ". '$scriptdir/proot.sh' && proot_user '$dir/$dist' $command"
        else
            PATH="$bindir:$PATH" sh -c ". '$scriptdir/proot.sh' && proot_root '$dir/$dist' $command"
        fi
    fi
}
