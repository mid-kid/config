#!/bin/sh
set -eu

profile="$1"
userjs_ver="115.1"

if [ ! -d "$profile/userjs" ]; then
    git clone -b "$userjs_ver" --depth=1 https://github.com/arkenfox/user.js/ "$profile/userjs"
fi
git -C "$profile/userjs" checkout "$userjs_ver"

if [ ! -d "$profile/chrome" ]; then
    git clone -b photon-style --depth=1 https://github.com/black7375/Firefox-UI-Fix/ "$profile/chrome"
fi
git -C "$profile/chrome" pull --depth=1 || true

newline="$profile/user.js-newline"
trap 'rm -f "$newline"' EXIT
echo > "$newline"

cat "$profile/userjs/user.js" "$newline" \
    "$profile/chrome/user.js" "$newline" \
    user.js > "$profile/user.js"

if [ "$(uname -o)" = "Msys" ]; then
    cat user_win.js >> "$profile/user.js"
fi

( cd "$profile"
    rm -vrf prefsjs_backups
    ./userjs/prefsCleaner.sh -s -d
    diff -u prefsjs_backups/prefs.js.backup.* prefs.js || true
    rm -vrf prefsjs_backups
)

# Remove binaries
rm -rf "$profile/gmp-gmpopenh264"
