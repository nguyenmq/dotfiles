#-----------------------------------------------------------
# Starts tmux when launching Gnome shell.
#-----------------------------------------------------------

# primary tmux session name
SESSION=$HOSTNAME

tmux has-session -t $SESSION > /dev/null
if [ $? -eq 0 ]; then
    # if session already exists, then attach to it
    tmux attach -t $SESSION
else
    # else create a new session
    tmux new-session -d -s $SESSION
    tmux split-window -v -t $SESSION:0
    tmux rename-window -t $SESSION:0 hsplit
    tmux new-window -t $SESSION -n fullscreen
    tmux attach -t $SESSION
fi
