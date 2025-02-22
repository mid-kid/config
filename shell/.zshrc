# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob notify
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle ':completion:*' auto-description 'specify %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' squeeze-slashes true
# End of lines added by compinstall
zstyle ':completion:*:functions' ignored-patterns '_*'  # Ignore completion functions for commands you don’t have

# Enable compinit with caching
ZSH_CACHE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
test ! -d $ZSH_CACHE && mkdir -p $ZSH_CACHE
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH_CACHE
autoload -Uz compinit
compinit -d $ZSH_CACHE/zcompdump-$ZSH_VERSION

# Additional zsh configuration
setopt prompt_subst share_history
unsetopt list_beep
REPORTTIME=10
autoload -Uz zsh-newuser-install
autoload -Uz compinstall
autoload -Uz colors
colors
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Keybinds (showkey -a)
# delete-char: Delete
# backward-kill-word: ALT+Backspace (CTRL+Backspace in linux framebuffer)
# backward-word: CTRL+Left
# forward-word: CTRL+Right
# beginning-of-line: Home
# end-of-line: End
# history-search-backward: PgUp
# history-search-forward: PgDn
bindkey '\037' backward-kill-word
bindkey '\eOc' forward-word
bindkey '\eOd' backward-word
bindkey '\e[1;5C' forward-word
bindkey '\e[1;5D' backward-word
bindkey '\e[1~' beginning-of-line
bindkey '\e[3~' delete-char
bindkey '\e[4~' end-of-line
bindkey '\e[5~' history-search-backward
bindkey '\e[6~' history-search-forward
bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line
bindkey '\e[F' end-of-line
bindkey '\e[H' beginning-of-line
bindkey '\e[\b' backward-kill-word

# Prompt
_prompt_git() { :; }
if command -v git > /dev/null; then
    _prompt_git() {
        # Ignore mounted directories which may be slow
        [[ $PWD = /mnt/* || $PWD = /run/media/* ]] && return

        if [ -d .git/objects -o -f .git ] && git rev-parse 2>/dev/null; then
            local branch=$(git symbolic-ref HEAD 2> /dev/null | cut -d '/' -f 3-)
            [ ! $branch ] && branch=$(git rev-parse --short HEAD)
            printf '%s' $branch

            local stashed_changes=$(git stash list | wc -l)
            [ $stashed_changes -gt 0 ] && printf '!%d' $stashed_changes

            local git_status=$(git status --porcelain)

            local staged_files=$(grep '^[^ ][^?U] ' <<< $git_status | wc -l)
            [ $staged_files -gt 0 ] && printf ' ●%d' $staged_files

            local conflicting_files=$(grep '^UU ' <<< $git_status | wc -l)
            [ $conflicting_files -gt 0 ] && printf ' ✖%d' $conflicting_files

            local changed_files=$(grep '^[^?U][^ ] ' <<< $git_status | wc -l)
            [ $changed_files -gt 0 ] && printf ' ✚%d' $changed_files

            local untracked_files=$(grep '^?? ' <<< $git_status | wc -l)
            [ $untracked_files -gt 0 ] && printf ' …%d' $untracked_files
        fi
    }
fi
_prompt_eprefix_fmt="%%{$fg[blue]%%}(%s)%%{$reset_color%%} "
_prompt_eprefix() { :; }
if [[ -n $CONTAINER_ID ]]; then
    _prompt_eprefix() {
        printf $_prompt_eprefix_fmt $CONTAINER_ID
    }
elif [[ $SHELL != zsh && $SHELL != /bin/zsh ]]; then
    _prompt_eprefix() {
        local prefix=${SHELL%/bin/zsh}
        prefix=${prefix##*/}
        prefix=${prefix#.}
        printf $_prompt_eprefix_fmt $prefix
    }
fi

PROMPT="$(_prompt_eprefix)%{$fg[green]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%} :%{$fg[magenta]%}\$(_prompt_git)%{$reset_color%}: %{$fg[cyan]%}%c%{$reset_color%} $ "

# Anonymize the zsh prompt and fastfetch output
anon() {
    export ANON=anon
    exec unshare -ru $SHELL
}
if [[ $ANON = anon ]]; then
    clear
    PROMPT='$ '
    USER=user
    hostname pc
fi

# Run .exe files with wine
alias -s exe=wine

source ~/.shellrc

# Defined in ~/.shellrc:
_dmount() {
    devices=( $(lsblk -rn | awk '{print $1}') )
    _values 'devices' "${devices[@]}"
}
compdef _dmount dmount
_dumount() {
    devices=( $(lsblk -rn | awk '{if($7){print $1}}') )
    _values 'mounted devices' "${devices[@]}"
}
compdef _dumount dumount

live=${XDG_CONFIG_HOME:-$HOME/.config}/live
test -x $live && $live zsh
