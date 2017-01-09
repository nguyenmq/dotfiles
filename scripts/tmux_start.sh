#-----------------------------------------------------------
# Starts tmux when launching my terminal emulator
#-----------------------------------------------------------

# primary tmux session name
SESSION=$($HOSTNAME | cut -d '.' -f 1)

tmux has-session -t "$SESSION" > /dev/null
if [ $? -eq 0 ]; then
    # if session already exists, then attach to it
    exec tmux attach -t "$SESSION"
else
    # create a new sessions
    tmux new-session -d -s "$SESSION" -n one
    tmux new-window -t "$SESSION" -n two

    # focus window 1
    tmux select-window -t "$SESSION":1

    # attach to the session
    exec tmux attach -t "$SESSION"
fi
