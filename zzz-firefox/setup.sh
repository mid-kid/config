#!/bin/sh
set -eu

profile="$1"
userjs_ver="102.1"

if [ ! -d "$profile/userjs" ]; then
    git clone -b "$userjs_ver" --depth=1 https://github.com/arkenfox/user.js/ "$profile/userjs"
fi
git -C "$profile/userjs" checkout "$userjs_ver"

if [ ! -d "$profile/chrome" ]; then
    git clone -b photon-style --depth=1 https://github.com/black7375/Firefox-UI-Fix/ "$profile/chrome"
fi
git -C "$profile/chrome" pull --depth=1

newline="$profile/user.js-newline"
trap 'rm -f "$newline"' EXIT
echo > "$newline"

cat "$profile/userjs/user.js" "$newline" \
    "$profile/chrome/user.js" "$newline" \
    user.js > "$profile/user.js"

if [ "$(uname -o)" = "Msys" ]; then
    cat user_win.js >> "$profile/user.js"
fi

cp "$profile/userjs/prefsCleaner.sh" "$profile/prefsCleaner.sh"
chmod +x "$profile/prefsCleaner.sh"
( cd "$profile"
    ./prefsCleaner.sh -s
    diff -u prefs.js.backup.* prefs.js || true
    rm -vf prefs.js.backup.*
)
