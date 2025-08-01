#!/bin/sh
set -eu

# "Compress" files into mozlz4 format.
# Yes, I wrote a non-compressor in posix shell for this

len=$(wc -c < "$1")
buf=$(test $len -lt 15 && printf %x0 $len ||
    rep=$(( ($len - 15) / 255 ))
    rem=$(( ($len - 15) % 255 ))
    printf f0
    seq $rep | xargs -r printf ff%.0s
    printf %02x $rem
)
len=$(( $len + $(printf %s $buf | wc -c) / 2 ))
printf mozLz40\\0
{
printf %08x $len | sed 's/../&\n/g' | tac | tr -d \\n
printf %s $buf
} | xxd -r -p
cat "$1"
