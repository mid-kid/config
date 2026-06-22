if [[ $- != *i* ]] ; then
    return
fi

color_reset=
color_green=
color_yellow=
color_cyan=
if command -v tput > /dev/null; then
    color_reset=$(tput sgr0)
    color_green=$(tput setaf 2)
    color_yellow=$(tput setaf 3)
    color_cyan=$(tput setaf 6)
fi
export PS1="\[$color_green\]\u\[$color_reset\]@\[$color_yellow\]\h\[$color_reset\] :: \[$color_cyan\]\W\[$color_reset\] $ "

source ~/.shellrc
