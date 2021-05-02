#!/bin/sh
readonly SESSION_NAME='dashboard'

if ! tmux has-session -t $SESSION_NAME
then
    tmux new-session -d -s $SESSION_NAME -n htop htop
    tmux set-window-option -t $SESSION_NAME:htop    monitor-activity off

    tmux new-window -n logs    -t $SESSION_NAME "journalctl --follow"
fi

tmux attach -t $SESSION_NAME
