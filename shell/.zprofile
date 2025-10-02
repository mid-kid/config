# Run keychain as part of the session
if [ -t 0 ] && command -v keychain > /dev/null 2> /dev/null; then
    if [ -n "$XDG_RUNTIME_DIR" -a -d "$XDG_RUNTIME_DIR" ]; then
        eval $(keychain --quiet --eval --timeout 5 --absolute --dir "$XDG_RUNTIME_DIR/keychain")
    fi
fi

# Force some applications to use the XDG spec
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export URXVT_PERL_LIB="$XDG_CONFIG_HOME/urxvt/ext"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export W3M_DIR="$XDG_DATA_HOME/w3m"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export DVDCSS_CACHE="$XDG_CACHE_HOME/dvdcss"
export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvtd"
export UNCRUSTIFY_CONFIG="$XDG_CONFIG_HOME/uncrustify/uncrustify.cfg"

# Some XDG config paths relevant to shell applications (see .shellrc)
export PYTHONSTARTUP="$XDG_CONFIG_HOME/pythonrc"
export QUILTRC="$XDG_CONFIG_HOME/quilt/quiltrc"

unset VIMINIT
if [ -f "$XDG_CONFIG_HOME/vim/vimrc" ]; then
    export VIMINIT="if !has('nvim') | source $XDG_CONFIG_HOME/vim/vimrc | endif"
fi

# Path management
addpath() {
    local _path="$(realpath -mq "${1:-$PWD}")"
    test -n "$_path" && \
        eval export ${2:-PATH}=\"\${${2:-PATH}}\${${2:-PATH}:+:}\$_path\"
}
addpath "$HOME/.local/bin"

# Additional path configurations
test -f "$HOME/.local/opt/pathrc" && . "$HOME/.local/opt/pathrc"

# Clean up paths I don't want to keep, that I can't change the location of
rm -f "$HOME/.ash_history"
rm -f "$HOME/.bash_history"
rm -rf "$HOME/.audacity-data"
rm -rf "$HOME/.designer"
rm -rf "$HOME/.fastboot"
rm -rf "$HOME/.fltk"
rm -rf "$HOME/.mupdf.history"
rm -rf "$HOME/.net"
rm -rf "$HOME/.npm"
rm -rf "$HOME/.openjfx"
rm -rf "$HOME/.putty"
rm -rf "$HOME/.vcpkg"
