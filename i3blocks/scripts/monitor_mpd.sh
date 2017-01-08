#!/bin/bash

PID_FILE="/tmp/monitor_mpd_pid"

quit() {
    rm "$PID_FILE"
    pkill mpc
    exit 0
}

trap quit SIGINT SIGTERM

if [ -e "$PID_FILE" ]; then
    kill $(cat "$PID_FILE")
fi

echo "$BASHPID" > /tmp/monitor_mpd_pid

while read line
do
    pkill -RTMIN+11 i3blocks
done < <(mpc idleloop playlist player)
