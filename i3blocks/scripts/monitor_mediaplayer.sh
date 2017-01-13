#!/bin/bash

PID_FILE="/tmp/monitor_mediaplayer_pid"

quit() {
    rm "$PID_FILE"
    pkill dbus-monitor
    exit 0
}

trap quit SIGINT SIGTERM

if [ -e "$PID_FILE" ]; then
    kill $(cat "$PID_FILE")
fi

echo "$BASHPID" > "$PID_FILE"

while read line
do
    pkill -RTMIN+11 i3blocks
done < <(dbus-monitor --session "path=/org/mpris/MediaPlayer2,member=PropertiesChanged" --profile)
