# insert sudo infront of command
insert_sudo () {
  [[ -z $BUFFER ]] && zle up-history
  [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
  zle end-of-line
}

zle -N insert-sudo insert_sudo
