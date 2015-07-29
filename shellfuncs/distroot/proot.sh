proot_base() {
    # Some terminfos are usually not installed in chroots,
    #   and are mostly compatible with other, installed terminfos.
    if [ "$TERM" = "rxvt-unicode-256color" ]; then
        local TERM="linux"
    fi

    env -i TERM=$TERM $(which proot) -b /dev -b /run -b /sys -b /proc -b /tmp -b /etc/resolv.conf "$@"
}

proot_root() {
    proot_base -0 -w /root -r "$@"
}

proot_user() {
    proot_base -b "$HOME" -b /etc/passwd -b /etc/group -r "$@"
}
