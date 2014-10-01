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

    # creates window with main horizontal pane and three
    # smaller ones below
    tmux select-window -t $SESSION:0
    tmux split-window -h
    tmux split-window -h
    tmux rename-window hsplit
    tmux select-layout main-horizontal

    # create a window with a single pane
    tmux new-window -t $SESSION -n fullscreen
    tmux attach -t $SESSION
fi
