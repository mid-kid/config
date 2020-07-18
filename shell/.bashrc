if [[ $- != *i* ]] ; then
    return
fi

color_reset=$(tput sgr0)
color_green=$(tput setaf 2)
color_yellow=$(tput setaf 3)
color_cyan=$(tput setaf 6)
export PS1="\[$color_green\]\u\[$color_reset\]@\[$color_yellow\]\h\[$color_reset\] :: \[$color_cyan\]\W\[$color_reset\] $ "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source ~/.shellrc
