#!/usr/bin/env bash

# Controls the volume of the default audio sink using PipeWire/WirePlumber.

INCREMENT="2"
MAX_VOLUME="1.0"

function print_help() {
    echo "Controls volume of the default audio sink via WirePlumber."
    echo "In listening mode, monitors PipeWire events to update volume status."
    echo ""
    echo "Usage:"
    echo "--help    Prints usage."
    echo "--up      Increase volume by ${INCREMENT}%."
    echo "--down    Decrease volume by ${INCREMENT}%."
    echo "--toggle  Toggle mute state."
    echo "--mute    Mute the default sink."
    echo "--unmute  Unmute the default sink."
    echo "--listen  Listen for PipeWire events."
    echo "--set N   Set volume to N%."
}

function increase_volume() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "${INCREMENT}%+" --limit "${MAX_VOLUME}"
}

function decrease_volume() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "${INCREMENT}%-"
}

function set_volume() {
    local target_volume="$1"

    if [[ "$target_volume" -gt "$MAX_VOLUME" ]]; then
        target_volume="$MAX_VOLUME"
    fi

    wpctl set-volume @DEFAULT_AUDIO_SINK@ "${target_volume}%"
}

function get_current_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d", $2 * 100}'
}

function is_muted() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED
}

function set_mute() {
    case "$1" in
        mute)   wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 ;;
        unmute) wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 ;;
    esac
}

function listen() {
    # Print initial state
    print_volume

    # Monitor PipeWire object changes and reprint on sink events
    pw-mon --no-colors 2>/dev/null | while read -r line; do
        if echo "$line" | grep -qE "changed.*Audio/Sink|default"; then
            print_volume
        fi
    done
}

function print_volume() {
    if is_muted; then
        echo "  mute"
    else
        local vol
        vol=$(get_current_volume)
        printf ' %-4s\n' "${vol}%"
    fi
}

case "$1" in
    --help)   print_help ;;
    --up)     increase_volume ;;
    --down)   decrease_volume ;;
    --toggle) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
    --mute)   set_mute "mute" ;;
    --unmute) set_mute "unmute" ;;
    --listen) listen ;;
    --set)    set_volume "$2" ;;
    *)        print_volume ;;
esac
