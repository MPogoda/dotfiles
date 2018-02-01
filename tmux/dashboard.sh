#!/bin/sh
readonly SESSION_NAME='dashboard'

if ! tmux has-session -t $SESSION_NAME
then
    tmux new-session -d -s $SESSION_NAME -n logs "journalctl --follow"
    tmux new-window -n htop    -t $SESSION_NAME htop
    tmux set-window-option -t $SESSION_NAME:htop    monitor-activity off
fi

tmux attach -t $SESSION_NAME
