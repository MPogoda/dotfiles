#!/bin/sh
readonly SESSION_NAME='dashboard'

if ! tmux has-session -t $SESSION_NAME &>/dev/null
then
    readonly LOG_NAMES="/var/log/auth.log \
                        /var/log/daemon.log \
                        /var/log/emerge.log \
                        /var/log/emerge-fetch.log \
                        /var/log/messages \
                        /var/log/Xorg.0.log"
    if which multitail &>/dev/null
    then
        tmux new-session -d -s $SESSION_NAME -n logs "sudo multitail $LOG_NAMES"
    else
        tmux new-session -d -s $SESSION_NAME -n logs "sudo tail --follow=name $LOG_NAMES"
    fi
    tmux split-window -h -t $SESSION_NAME:logs "dmesg -w"
    tmux new-window -n update  -t $SESSION_NAME
    tmux new-window -n htop    -t $SESSION_NAME htop
    tmux set-window-option -t $SESSION_NAME:update  allow-rename     off
    tmux set-window-option -t $SESSION_NAME:update  monitor-activity off
    tmux set-window-option -t $SESSION_NAME:update  monitor-silence  30
    tmux set-window-option -t $SESSION_NAME:htop    monitor-activity off
fi

tmux attach -t $SESSION_NAME
