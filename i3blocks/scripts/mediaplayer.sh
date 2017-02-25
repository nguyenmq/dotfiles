#!/bin/bash

PLAYER_ICON=""
STATUS_ICON=""
NOW_PLAYING=""
PLAYING=""

utf8_to_xml_encoding() {
    echo "$1" | recode utf8..xml
}

get_mpd_status() {
    local PID_MPD=$(pidof mpd)

    if [ ! -z "$PID_MPD" ]; then
        STS_MPD=$(playerctl -p mpd status)
        local MPD_ICON=""

        if [ "$STS_MPD" == "Playing" ]; then
            local MPD_STATUS=""
            PLAYING="true"
        elif [ "$STS_MPD" == "Paused" ]; then
            local MPD_STATUS=""
        fi

        if [ ! -z "$MPD_STATUS" ]; then
            if [ $(mpc | awk -F "random:" '{if(match($0, "random:") > 0) { split($2, tokens, " "); print tokens[1] }}') == "on" ]; then
                local MPD_STATUS="${MPD_STATUS}  "
            fi

            PLAYER_ICON="$MPD_ICON"
            STATUS_ICON="$MPD_STATUS"
            NOW_PLAYING="$(mpc current)"
        fi
    fi
}

get_spotify_status() {
    local PID_SPT=$(pidof spotify)

    if [ ! -z "$PID_SPT" ]; then
        STS_SPT=$(playerctl -p spotify status)
        SPOT_ICON=""

        if [ "$STS_SPT" == "Playing" ]; then
            SPOT_STATUS=""
            PLAYING="true"
        elif [ "$STS_SPT" == "Paused" ]; then
            SPOT_STATUS=""
        fi

        if [ ! -z "$SPOT_STATUS" ]; then
            PLAYER_ICON="$SPOT_ICON"
            STATUS_ICON="$SPOT_STATUS"
            NOW_PLAYING="$(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)"
        fi
    fi
}

sleep "0.2"
get_spotify_status

if [ -z "$PLAYING" ]; then
    # MPD status takes precedence when nothing else is playing
    get_mpd_status
fi

if [ -z "$NOW_PLAYING" ]; then
    NOW_PLAYING="  stopped"
fi

utf8_to_xml_encoding "$PLAYER_ICON  $STATUS_ICON  ${NOW_PLAYING:0:90}"
