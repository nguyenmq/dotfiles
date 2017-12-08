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
}

while getopts "befmih" opt; do
    case "$1" in
        -b)
            xrandr --output "$EXTERNAL_DISPLAY" --auto --output "$INTERNAL_DISPLAY" --auto
            shift
            break
            ;;
        -e)
            xrandr --output "$INTERNAL_DISPLAY" --off --output "$EXTERNAL_DISPLAY" --auto --scale-from 1920x1080
            shift
            break
            ;;
        -f)
            xrandr --output "$INTERNAL_DISPLAY" --off --output "$EXTERNAL_DISPLAY" --auto --scale-from 3840x2160
            shift
            break
            ;;
        -i)
            xrandr --output "$EXTERNAL_DISPLAY" --off --output "$INTERNAL_DISPLAY" --auto
            shift
            break
            ;;
        -h)
            print_help;
            shift
            break
            ;;
        --)
            shift;
            break
            ;;
    esac
done

# reset the background
${HOME}/.fehbg
