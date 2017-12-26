#!/bin/sh
readonly SESSION_NAME='dashboard'

if ! tmux has-session -t $SESSION_NAME &>/dev/null
then
    tmux new-session -d -s $SESSION_NAME -n logs "journalctl --follow"
    tmux new-window -n htop    -t $SESSION_NAME htop
    tmux set-window-option -t $SESSION_NAME:htop    monitor-activity off
    tmux new-window -n openconnect -t $SESSION_NAME "~/.tmux/go-vpn.sh"
fi

tmux attach -t $SESSION_NAME
