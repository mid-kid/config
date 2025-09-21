#!/bin/sh
set -eu

profile="$1"
userjs_ver=140.0

# Update userjs
if [ ! -d "$profile/userjs" ]; then
    git clone https://github.com/arkenfox/user.js/ "$profile/userjs"
fi
git -C "$profile/userjs" checkout "$userjs_ver"

# Update userchrome
if [ ! -d "$profile/chrome" ]; then
    git clone -b photon-style --depth=1 https://github.com/black7375/Firefox-UI-Fix/ "$profile/chrome"
fi
git -C "$profile/chrome" pull --depth=1 || true

{
    cat "$profile/userjs/user.js"
    printf \\n
    cat "$profile/chrome/user.js"
    printf \\n
    cat user.js
    if [ "$(uname -o)" = Msys ]; then
        cat user_win.js
    fi
} > "$profile/user.js"

./mozlz4.sh search.json > "$profile/search.json.mozlz4"

( cd "$profile"
    cp userjs/prefsCleaner.sh .
    ./prefsCleaner.sh -s -d
    rm prefsCleaner.sh
    diff -u prefsjs_backups/prefs.js.backup.* prefs.js || true
    rm -vrf prefsjs_backups
)

# Remove binaries
rm -rf "$profile/gmp-gmpopenh264"
