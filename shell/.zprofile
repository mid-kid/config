# Run keychain as part of the session
if command -v keychain > /dev/null 2> /dev/null; then
    if [ -n "$XDG_RUNTIME_DIR" -a -d "$XDG_RUNTIME_DIR" ]; then
        eval $(keychain --eval --timeout 5 --absolute --dir "$XDG_RUNTIME_DIR/keychain")
    fi
fi

# Force some applications to use the XDG spec
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export VIMINIT="if !has('nvim') | source $XDG_CONFIG_HOME/vim/vimrc | endif"
export QUILTRC="$XDG_CONFIG_HOME/quilt/quiltrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export URXVT_PERL_LIB="$XDG_CONFIG_HOME/urxvt/ext"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvtd"

# Disable caches of some applications that don't follow the XDG spec
export LESSHISTFILE=-
export DVDCSS_CACHE=off

# Path management
addpath() {
    local _path="$(realpath -mq "${1:-$PWD}")"
    [ "$_path" ] && eval export ${2:-PATH}=\"\$${2:-PATH}:$_path\"
}
addpath "$HOME/.local/bin"

# Additional path configurations
test -f "$HOME/.local/opt/pathrc" && . "$HOME/.local/opt/pathrc"
