#!/usr/bin/env bash

function launch_polybar() {
    local monitor=$1

    MONITOR="$monitor" polybar "base" &
    sleep 0.2s
}

# Terminate already running bar instances
killall -q polybar
pgrep -f "pavolume.sh" | xargs kill

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar on the primary monitor first. This is where the application tray will appear.
PRIMARY=$(xrandr --query | awk '/\<connected primary/ {print $1}')
launch_polybar "$PRIMARY"

# Launch polybar on the remaining active monitors
for m in $(xrandr --query | awk '/\<connected\> [0-9]/ {print $1}'); do
    launch_polybar "$m"
done
