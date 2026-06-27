#!/bin/bash
PANE="${1:-$TMUX_PANE}"
[ -z "$PANE" ] && exit 0

SAFE_PANE="${PANE//[^a-zA-Z0-9]/_}"
PID_FILE="/tmp/tmux-claude-blink-${SAFE_PANE}.pid"
ALERT_FILE="/tmp/tmux-claude-alert-${SAFE_PANE}"

if [ -f "$PID_FILE" ]; then
    kill "$(cat "$PID_FILE")" 2>/dev/null
    rm -f "$PID_FILE"
fi

tmux set-option -p -t "$PANE" window-style 'default' 2>/dev/null

if [ -f "$ALERT_FILE" ]; then
    WINDOW=$(cat "$ALERT_FILE")
    rm -f "$ALERT_FILE"
    if [ -n "$WINDOW" ]; then
        tmux set-window-option -u -t "$WINDOW" window-status-style 2>/dev/null
        tmux set-window-option -u -t "$WINDOW" window-status-current-style 2>/dev/null
    fi
fi
