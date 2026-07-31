#!/bin/bash
# choose-audio-sink.sh
# Rofi script mode for switching audio sinks using native PipeWire.
#
# Usage:
#   rofi -show audio -modi "audio:/path/to/choose-audio-sink.sh"

list_audio_sinks() {
    pw-dump | jq -r '
        # Find the default sink node.name from metadata
        (
            [.[] | select(.type == "PipeWire:Interface:Metadata")
                 | .metadata[]?
                 | select(.key == "default.audio.sink")]
            | first | .value.name
        ) as $default_name |

        # List sinks, marking the default
        [.[] | select(.info.props["media.class"] == "Audio/Sink")
             | { description: .info.props["node.description"],
                 is_default: (.info.props["node.name"] == $default_name) }]
        | sort_by(.description)
        | sort_by(if .is_default then 0 else 1 end)
        | .[].description
    '
}

set_audio_sink() {
    local description="$1"

    local node_id
    node_id=$(pw-dump | jq -r --arg desc "$description" \
        '.[] | select(.info.props["media.class"] == "Audio/Sink" and .info.props["node.description"] == $desc) | .id')

    if [[ -z "$node_id" ]]; then
        echo -en "\x00message\x1f${description} not connected\n"
        return
    fi

    wpctl set-default "$node_id"
}

if [[ -n "$1" ]]; then
    set_audio_sink "$1"
else
    echo -en "\x00prompt\x1f󰓃\n"
    list_audio_sinks
fi
