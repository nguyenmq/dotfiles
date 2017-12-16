#!/usr/bin/env bash

if [[ $# -lt 1 ]]; then
    echo "Need to specify an polybar config"
    exit 1
fi

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar "${1}" &
