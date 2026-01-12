#!/bin/bash

#-----------------------------------------------------------
# Starts tmux with a configured set of windows
#-----------------------------------------------------------

# primary tmux session name
SESSION="default"
WINDOW_NAMES_CONFIG="${HOME}/.config/tmux_windows"
WINDOW_NAME=""
STARTING_DIRECTORY=""

set_window_name() {
    WINDOW_NAME="$(echo "$1" | awk '{print $1}')"
}

set_starting_directory() {
    STARTING_DIRECTORY="$(echo "$1" | awk '{print $2}')"

    if [[ -z $STARTING_DIRECTORY ]]; then
        STARTING_DIRECTORY="${HOME}"
    else
        STARTING_DIRECTORY="$(echo "$STARTING_DIRECTORY" | envsubst)"
    fi
}

create_sessions() {
    local config

    if [[ -e "$WINDOW_NAMES_CONFIG" ]]; then
        config="$(head -n 1 "$WINDOW_NAMES_CONFIG")"
        set_window_name "$config"
        set_starting_directory "$config"
        tmux new-session -d -s "$SESSION" -n "$WINDOW_NAME" -c "$STARTING_DIRECTORY"

        while read -r config; do
            set_window_name "$config"
            set_starting_directory "$config"
            tmux new-window -t "$SESSION" -n "$WINDOW_NAME" -c "$STARTING_DIRECTORY"
        done < <(tail -n +2 "$WINDOW_NAMES_CONFIG")
    else
        # create a new session with default windows
        tmux new-session -d -s "$SESSION" -n one
        tmux new-window -t "$SESSION" -n two
    fi

    # focus window 1
    tmux select-window -t "$SESSION":1

    # attach to the session
    exec tmux attach -t "$SESSION" -c "$HOME"
}


if tmux has-session -t "$SESSION" > /dev/null; then
    # if session already exists, then attach to it
    exec tmux attach -t "$SESSION" -c "$HOME"
else
    create_sessions
fi
