#!/bin/bash

function set_audio_sink() {
    local sink_name=$1

    if ! pactl list sinks short | grep "$sink_name" > /dev/null; then
        echo "$sink_name not connected"
    else
        # set the default sink
        pactl set-default-sink "$sink_name"

        # move all active streams to the default sink
        for stream in $(pactl list sink-inputs short | awk '{print $1}'); do
            pactl move-sink-input "$stream" "$sink_name"
        done
    fi
}

function list_audio_sinks() {
    for sink in $(pactl list sinks short | awk '{print $2}'); do
        echo "$sink"
    done
}

if [[ "$@" ]]; then
    set_audio_sink "$@"
else
    echo -en "\x00prompt\x1fChoose audio sink\n"

    list_audio_sinks
fi
