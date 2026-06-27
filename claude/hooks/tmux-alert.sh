#!/bin/bash
[ -z "$TMUX" ] && exit 0
PANE="$TMUX_PANE"
[ -z "$PANE" ] && exit 0

# Check if alert mode is enabled (defaults to on if preference file absent)
PREF_FILE="$HOME/.tmux-claude-alert"
if [ -f "$PREF_FILE" ] && grep -q "^off$" "$PREF_FILE"; then
    exit 0
fi

SAFE_PANE="${PANE//[^a-zA-Z0-9]/_}"
PID_FILE="/tmp/tmux-claude-blink-${SAFE_PANE}.pid"
ALERT_FILE="/tmp/tmux-claude-alert-${SAFE_PANE}"

# Get the window this pane belongs to
WINDOW=$(tmux display-message -p -t "$PANE" '#{window_id}' 2>/dev/null)
[ -z "$WINDOW" ] && exit 0

# Kill any existing blink loop for this pane
if [ -f "$PID_FILE" ]; then
    kill "$(cat "$PID_FILE")" 2>/dev/null
    rm -f "$PID_FILE"
fi

# Store alert state so the reset hook knows which window to un-highlight
echo "$WINDOW" > "$ALERT_FILE"

# Highlight the window tab red in the status bar — visible from any window
tmux set-window-option -t "$WINDOW" window-status-style 'bg=red,fg=white,bold'
tmux set-window-option -t "$WINDOW" window-status-current-style 'bg=red,fg=white,bold'

# Blink the pane background only if the pane is not currently focused
# (if the user is already looking at it, the response text is notification enough)
ACTIVE=$(tmux display-message -p -t "$PANE" '#{pane_active}')
if [ "$ACTIVE" != "1" ]; then
    bash ~/.claude/hooks/tmux-blink.sh "$PANE" &
    echo $! > "$PID_FILE"
    disown
fi
