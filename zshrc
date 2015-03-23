#
# Executes commands at the start of an interactive session.
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

alias lh='ls -hAl --color=auto'

insert_sudo() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line
}
zle -N insert-sudo insert_sudo

bindkey "^[[2~" quoted-insert                     # Insert
bindkey "^[[3~" delete-char                       # Delete
bindkey "^[[Z"  reverse-menu-complete             # Shift+Tab
bindkey "^[[7~" beginning-of-line                 # Home
bindkey "^[[8~" end-of-line                       # End
bindkey "^[[5~" history-beginning-search-backward # PgUp
bindkey "^[[6~" history-beginning-search-forward  # PgDown
bindkey "^[z"   insert-sudo                       # Alt+Z

bindkey "^r"    history-incremental-search-backward # C-r

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^f'   edit-command-line

fortune vimtips | cowsay
