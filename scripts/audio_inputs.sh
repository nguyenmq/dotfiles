#!/bin/bash

function set_audio_sink() {
    local description=$1
    local sink_name

    if ! pactl list sinks | grep "$description" > /dev/null; then
        echo "$description not connected"
    else
        sink_name=$(pactl list sinks | grep -B1 "Description: $description" | awk -F ':' '/Name/ {sub(/^\s+/, "", $2); print $2}')

        # set the default sink
        pactl set-default-sink "$sink_name"

        # move all active streams to the default sink
        for stream in $(pactl list sink-inputs short | awk '{print $1}'); do
            pactl move-sink-input "$stream" "$sink_name"
        done
    fi
}

function list_audio_sinks() {
    for sink in "$(pactl list sinks | awk -F ':' '/^\s+Description:/ {sub(/^\s+/, "", $2); print $2}')"; do
        echo "$sink"
    done
}

if [[ "$@" ]]; then
    set_audio_sink "$@"
else
    echo -en "\x00prompt\x1fChoose audio sink\n"

    list_audio_sinks
fi
