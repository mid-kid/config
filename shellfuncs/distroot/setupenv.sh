. "$1/proot.sh"

arch="$2"
tmpdir="$3"
destdir="$4"

chrootcmd() {
    proot_root "$destdir" /usr/bin/env "$@"
}
