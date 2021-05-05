#!/bin/bash

SHORT_OPTIONS="lthpc"
LONG_OPTIONS="clear,listen,toggle,help,print"

function bad_options() {
    echo "Incorrect options provided"
    exit 1
}

function print_help() {
    echo "Polybar script for displaying dunst notification count."
    echo "--clear   Clear waiting notifications."
    echo "--help    Prints this help."
    echo "--listen  Listens to dunst for new notifications."
    echo "--print   Print polybar output."
    echo "--toggle  Toggle notification muting."
    exit 0
}

function toggle() {
    dunstctl set-paused toggle
    dunstctl debug > /dev/null
}

function print_notifications() {
    local icon
    local count

    if [[ $(dunstctl is-paused) == "true" ]]; then
        icon=""
    else
        icon=""
    fi

    count=$(dunstctl count waiting)

    printf '%s %02d\n' "$icon" "$count"
}

function listen() {
    #pkill --exact dunst
    dbus-monitor --session "interface='org.freedesktop.Notifications'" | {
        while true; do
            read -r event || break
            print_notifications
        done
    }
}

function clear_notifications() {
    dunstctl close-all
    print_notifications
}

options=$(getopt --name "dunst.sh" --options "$SHORT_OPTIONS" --longoptions "$LONG_OPTIONS" -- "$@") || bad_options

eval set -- "$options"
while true; do
    case "$1" in
        --clear)
            clear_notifications
            shift
            break
            ;;
        --help)
            print_help
            shift
            ;;
        --listen)
            print_notifications
            listen
            exit 0
            ;;
        --print)
            print_notifications
            shift
            break
            ;;
        --toggle)
            toggle
            shift
            break
            ;;
        --)
            shift
            break
            ;;
    esac
done
