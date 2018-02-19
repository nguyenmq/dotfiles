#!/bin/bash

# Sets which monitor output to use on the laptop

INTERNAL_DISPLAY=eDP1
EXTERNAL_DISPLAY=HDMI1

function print_help() {
    echo "Switch monitor output"
    echo "-b    Both internal and external monitor"
    echo "-e    External monitor only"
    echo "-f    4k external monitor"
    echo "-i    Internal monitor only"
    echo "-h    Print script usage"
    echo "-m    Mirror displays"
    echo "-r    Rotate the internal display 180 degrees"
}

function toggle_rotation() {
    if [[ "$(grep "$INTERNAL_DISPLAY" <(xrandr -q) | awk '{print $5}')" = "inverted" ]]; then
        xrandr --output "$INTERNAL_DISPLAY" --rotate normal
    else
        xrandr --output "$INTERNAL_DISPLAY" --rotate inverted
    fi
}

if [[ $# -eq 0 ]]; then
    print_help
    exit 0
fi

while getopts "befmihr" opt; do
    case $opt in
        b)
            xrandr --output "$EXTERNAL_DISPLAY" --auto --output "$INTERNAL_DISPLAY" --auto
            ;;
        e)
            xrandr --output "$INTERNAL_DISPLAY" --off --output "$EXTERNAL_DISPLAY" --auto --scale-from 1920x1080
            ;;
        f)
            xrandr --output "$INTERNAL_DISPLAY" --off --output "$EXTERNAL_DISPLAY" --auto --scale-from 3840x2160
            ;;
        i)
            xrandr --output "$EXTERNAL_DISPLAY" --off --output "$INTERNAL_DISPLAY" --auto
            ;;
        r)
            toggle_rotation
            ;;
        h | *)
            print_help
            exit 0
            ;;
    esac
done

# reset the background
"${HOME}/.fehbg"
