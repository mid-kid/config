ZSH_CACHE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
test ! -d $ZSH_CACHE && mkdir -p $ZSH_CACHE
# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'Specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=long-list select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-cache 1

autoload -Uz compinit
compinit -d $ZSH_CACHE/zcompdump-$ZSH_VERSION
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob notify beep prompt_subst
bindkey -e
# End of lines configured by zsh-newuser-install

# Keybinds
# http://www.linuxfromscratch.org/lfs/view/stable/chapter09/inputrc.html
# https://git.archlinux.org/svntogit/packages.git/tree/trunk/inputrc?h=packages/readline
bindkey '\eOc' emacs-forward-word  # CTRL+right
bindkey '\eOd' emacs-backward-word  # CTRL+left
bindkey '\e[5C' emacs-forward-word  # CTRL+right
bindkey '\e[5D' emacs-backward-word  # CTRL+left
bindkey '\e\e[C' emacs-forward-word  # CTRL+right
bindkey '\e\e[D' emacs-backward-word  # CTRL+left
bindkey '\e[1;5C' emacs-forward-word  # CTRL+right
bindkey '\e[1;5D' emacs-backward-word  # CTRL+left

bindkey '\eOH' beginning-of-line  # Home
bindkey '\eOF' end-of-line  # End
bindkey '\e[H' beginning-of-line  # Home
bindkey '\e[F' end-of-line  # End
bindkey '\e[1~' beginning-of-line  # Home
bindkey '\e[4~' end-of-line  # End
bindkey '\e[7~' beginning-of-line  # Home
bindkey '\e[8~' end-of-line  # End

bindkey '\e[5~' history-search-backward  # PgUp
bindkey '\e[6~' history-search-forward  # PgDown
bindkey '\e[3~' delete-char  # Delete
bindkey '\e[2~' quoted-insert

# Additional zsh configuration
REPORTTIME=10
autoload -Uz colors
colors
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

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
