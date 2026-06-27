#!/bin/bash
PANE="$1"
[ -z "$PANE" ] && exit 0
while true; do
    tmux set-option -p -t "$PANE" window-style 'bg=colour160' 2>/dev/null || exit 0
    sleep 0.4
    tmux set-option -p -t "$PANE" window-style 'default' 2>/dev/null || exit 0
    sleep 0.4
done
