#!/usr/bin/env bash

if [[ $# -lt 2 ]]; then
    echo "Need to specify a polybar config name and network device"
    exit 1
fi

function launch_polybar() {
    local monitor=$1
    local network=$2
    local config_name=$3

    MONITOR="$monitor" NETWORK="$network" polybar "$config_name" &
    sleep 0.2s
}

CONFIG_NAME="$1"
NETWORK="$2"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar on the primary monitor first. This is where the application tray will appear.
PRIMARY=$(xrandr --query | awk '/\<connected primary/ {print $1}')
launch_polybar "$PRIMARY" "$NETWORK" "$CONFIG_NAME"

# Launch polybar on the remaining active monitors
for m in $(xrandr --query | awk '/\<connected\> [0-9]/ {print $1}'); do
    launch_polybar "$m" "$NETWORK" "$CONFIG_NAME"
done
