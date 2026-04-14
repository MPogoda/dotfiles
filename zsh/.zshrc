#
# Interactive shell configuration.
#

# --- Zinit bootstrap ---
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  print -P "%F{33}Installing zinit...%f"
  command mkdir -p "$(dirname $ZINIT_HOME)"
  command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# --- Plugins (turbo: deferred load after prompt) ---
zinit wait lucid light-mode for \
  atload"zicompinit; zicdreplay" zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-syntax-highlighting \
  atload"bindkey '^[[A' history-substring-search-up; bindkey '^[[B' history-substring-search-down" \
    zsh-users/zsh-history-substring-search

# --- Git aliases ---
source "${ZDOTDIR:-$HOME}/git.zsh"

# --- History ---
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# --- Directory ---
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# --- Editor (vi mode) ---
bindkey -v
export KEYTIMEOUT=1

# --- Syntax highlighting ---
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern line cursor root)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

# --- Custom aliases ---
if (( $+commands[eza] )); then
  alias ls='eza'
  alias lh='eza -hAl'
else
  alias ls='ls -G'
  alias lh='ls -hAlG'
fi

# --- Custom functions ---
insert_sudo() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line
}
zle -N insert-sudo insert_sudo

# --- Keybindings ---
bindkey "^[[2~" quoted-insert                     # Insert
bindkey "^[[3~" delete-char                       # Delete
bindkey "^[[Z"  reverse-menu-complete             # Shift+Tab
bindkey "^[[7~" beginning-of-line                 # Home
bindkey "^[[8~" end-of-line                       # End
bindkey "^[[5~" history-beginning-search-backward # PgUp
bindkey "^[[6~" history-beginning-search-forward  # PgDown
bindkey "^[z"   insert-sudo                       # Alt+Z

bindkey "^r" history-incremental-search-backward  # Ctrl+R

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^f' edit-command-line                    # Ctrl+F


# --- FZF ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- Starship prompt ---
eval "$(starship init zsh)"

# --- Work-specific ---
export BOLT_SERVER_DISABLE_COMPLETION=false
export BOLT_SERVER_ROOT=/Users/mykhailopohoda/repos/taxify/server
[[ "$BOLT_SERVER_DISABLE_COMPLETION" != "true" ]] && source /Users/mykhailopohoda/repos/taxify/server/tooling_scripts/completions/server_autocomplete_zsh.sh

# pnpm
export PNPM_HOME="/Users/mykhailopohoda/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# pipx
export PATH="$PATH:/Users/mykhailopohoda/.local/bin"
