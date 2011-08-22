source /etc/zsh/zprofile

insert_sudo () {
  zle beginning-of-line
  zle -U "sudo "
}
zle -N insert-sudo insert_sudo

autoload -U promptinit && promptinit && prompt walters && PROMPT="%F{blue}> %F{white}"

bindkey "^[[2~" quoted-insert                     # Insert
bindkey "^[[3~" delete-char                       # Delete
bindkey "^[[Z"  reverse-menu-complete             # Shift+Tab
bindkey "^[[7~" beginning-of-line                 # Home
bindkey "^[[8~" end-of-line                       # End
bindkey "^[[5~" history-beginning-search-backward # PgUp
bindkey "^[[6~" history-beginning-search-forward  # PgDown
bindkey "^[s"   insert-sudo                       # Alt+S

eval `dircolors -b`

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v

autoload -Uz compinit && compinit

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile
zmodload -i zsh/complist

unsetopt menu_complete
setopt append_history notify auto_menu complete_in_word always_to_end
setopt hist_ignore_space notify correct cdablevars auto_list correct_all
setopt auto_cd recexact long_list_jobs no_beep hist_ignore_dups noclobber
setopt extended_glob share_history

typeset -U path cdpath fpath manpath

WORDCHARS=''

zstyle :compinstall filename '/home/.zshrc'
zstyle ':completion:*' list-colors ''

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.cache/zsh

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs
# ... unless we really want to.
zstyle '*' single-ignored show
zstyle ':completion:*' menu yes select

typeset -g -A key

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

alias -s {avi,mpeg,mpg,mov,mkv}=mplayer2

alias esync="sudo eix-sync"
alias fetch="sudo emerge --update --deep --newuse --fetchonly @world"
alias update="sudo emerge --update --deep --newuse @world"
alias emerge="sudo emerge"
alias vimu="sudo vim /etc/portage/package.use"
alias gvimu="sudo gvim /etc/portage/package.use"
alias hiber="sudo pm-hibernate"
alias halt="sudo halt"
alias reboot="sudo reboot"
alias man='nocorrect man'
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'

export PAGER=most
export LC_CTYPE=$LANG
