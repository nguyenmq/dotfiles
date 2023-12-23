#!/usr/bin/env bash

# Controls the volume of the active pulseaudio sink

INCREMENT="2"
MAX_VOLUME="100"

IS_MUTED=0
ACTIVE_SINK=""
CURRENT_VOLUME=""

function print_help() {
    echo "Controls volume of the active pulseaudio sink. If used in listening"
    echo "mode, then the script will listen for events from pulseaudio to"
    echo "update the volume status. Without any flags, the script will output a"
    echo "formatted string of the current volume."
    echo ""
    echo "Usage:"
    echo "--help    Prints usage."
    echo "--up      Increase volume by ${INCREMENT}%."
    echo "--down    Decrease volume by ${INCREMENT}%."
    echo "--toggle  Toggle mute state."
    echo "--mute    Mute the active sink."
    echo "--unmute  Unmute the active sink."
    echo "--listen  Listen for pulseaudio events."
}

function get_active_sink() {
    ACTIVE_SINK="$(pacmd list-sinks | awk '/* index:/ {print $3}')"
}

function increase_volume() {
    local volume

    get_active_sink
    get_current_volume

    volume=$(( CURRENT_VOLUME + INCREMENT ))

    if [[ "$volume" -gt "$MAX_VOLUME" ]]; then
        volume="$MAX_VOLUME"
    fi

    pactl set-sink-volume "$ACTIVE_SINK" "${volume}%"
}

function decrease_volume() {
    get_active_sink
    pactl set-sink-volume "$ACTIVE_SINK" "-${INCREMENT}%"
}

function get_current_volume() {
    CURRENT_VOLUME=$(pacmd list-sinks | grep -A 15 "index: $ACTIVE_SINK$" | awk '/^\s*volume:/ {gsub("%", "", $5); print $5}')
}

function set_mute {
    get_active_sink
    case "$1" in
        "mute")
            pactl set-sink-mute "$ACTIVE_SINK" 1
            ;;
        "unmute")
            pactl set-sink-mute "$ACTIVE_SINK" 0
            ;;
    esac
}

function get_mute_status {
    get_active_sink

    if [[ $(pacmd list-sinks | grep -A 15 "index: $ACTIVE_SINK" | awk '/muted/{ print $2}') == "yes" ]]; then
        IS_MUTED=1
    else
        IS_MUTED=0
    fi
}

# Listens for pulseaudio events
function listen() {
    local firstrun=0

    get_active_sink

    pactl subscribe 2>/dev/null | {
        while true; do
            {
                # If this is the first time just continue
                # and print the current state
                # Otherwise wait for events
                # This is to prevent the module being empty until
                # an event occurs
                if [ $firstrun -eq 0 ]
                then
                    firstrun=1
                else
                    read -r event || break
                    if ! echo "$event" | grep -e "on card" -e "on sink"; then
                        # Avoid double events
                        continue
                    fi
                fi
            } &>/dev/null

            print_volume
        done
    }
}

function print_volume() {
    local volume_percentage

    get_active_sink
    get_current_volume
    get_mute_status

    if [[ "$IS_MUTED" -eq 1 ]]; then
        echo " mute"
    else
        volume_percentage="$(printf '%0.0f%%' "$CURRENT_VOLUME")"
        printf ' %-4s\n' "$volume_percentage"
    fi
}

case "$1" in
    --help)
        print_help
        ;;
    --up)
        increase_volume
        ;;
    --down)
        decrease_volume
        ;;
    --toggle)
        get_mute_status
        if [[ "$IS_MUTED" -eq 1 ]]; then
            set_mute "unmute"
        else
            set_mute "mute"
        fi
        ;;
    --mute)
        set_mute "mute"
        ;;
    --unmute)
        set_mute "unmute"
        ;;
    --listen)
        listen
        ;;
    *)
        print_volume
        ;;
esac
