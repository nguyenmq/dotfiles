#!/bin/bash

#-----------------------------------------------------------
# Starts tmux when launching my terminal emulator
#-----------------------------------------------------------

# primary tmux session name
SESSION=$(echo "$HOSTNAME" | cut -d '.' -f 1)
WINDOW_NAMES="${HOME}/.tmux_windows"

create_sessions() {
    if [[ -e "$WINDOW_NAMES" ]]; then
        tmux new-session -d -s "$SESSION" -n "$(head -n 1 "$WINDOW_NAMES")"

        while read -r name; do
            tmux new-window -t "$SESSION" -n "$name"
        done < <(tail -n +2 "$WINDOW_NAMES")
    else
        # create a new session with default windows
        tmux new-session -d -s "$SESSION" -n one
        tmux new-window -t "$SESSION" -n two
    fi

    # focus window 1
    tmux select-window -t "$SESSION":1

    # attach to the session
    exec tmux attach -t "$SESSION"
}


if tmux has-session -t "$SESSION" > /dev/null; then
    # if session already exists, then attach to it
    exec tmux attach -t "$SESSION"
else
    create_sessions
fi
