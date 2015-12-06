#-----------------------------------------------------------
# Starts tmux when launching my terminal emulator
#-----------------------------------------------------------

# primary tmux session name
SESSION=$HOSTNAME

tmux has-session -t $SESSION > /dev/null
if [ $? -eq 0 ]; then
    # if session already exists, then attach to it
    exec tmux attach -t $SESSION
else
    # else create a new session
    tmux new-session -d -s $SESSION -n one

    # add a second window
    tmux new-window -t $SESSION -n two
    tmux select-window -t $SESSION:2

    # attach to the session
    exec tmux attach -t $SESSION
fi
