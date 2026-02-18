#!/bin/sh
set -eu

# "Compress" files into mozlz4 format.
# Yes, I wrote a non-compressor in posix shell for this

len=$(wc -c < "$1")
buf=$(test $len -lt 15 && printf \\%03o $(( len * 16 )) ||
    rep=$(( (len - 15) / 255 ))
    rem=$(( (len - 15) % 255 ))
    printf \\%03o 0xf0
    test $rep -gt 0 && printf \\377%.0s $(seq $rep)
    printf \\%03o $rem
)
len=$(( len + $(printf $buf | wc -c) ))
lendat=$(printf \\%03o $(printf %08x $len | sed 's/../0x&\n/g' | tac))
printf mozLz40\\0$lendat$buf
cat "$1"
