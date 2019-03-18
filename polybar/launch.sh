#!/usr/bin/env bash

if [[ $# -lt 2 ]]; then
    echo "Need to specify a polybar config and network device"
    exit 1
fi

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch polybar on each active output
for m in $(xrandr --query | awk '/\<connected\> (primary )?[0-9]/ {print $1}' | sort --reverse); do
    MONITOR=$m NETWORK="$2" polybar "$1" &
    sleep 0.2s
done
