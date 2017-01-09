#!/bin/bash

utf8_to_xml_encoding() {
    echo "$1" | recode utf8..xml
}

PID_MPD=$(pidof mpd)
PID_SPT=$(pidof spotify)

if [ ! -z "$PID_MPD" ]; then
    STS_MPD=$(playerctl -p mpd status)
fi

if [ ! -z "$PID_SPT" ]; then
    STS_SPT=$(playerctl -p spotify status)
fi

if [ ! -z "$PID_MPD" ] && [ "$STS_MPD" == "Playing" ]; then
    echo "<span foreground='#e3e2f3'>  </span>  $(utf8_to_xml_encoding "$(mpc current)")"
elif [ ! -z "$PID_SPT" ] && [ "$STS_SPT" == "Playing" ]; then
    echo "<span foreground='#e3e2f3'>  </span>  $(utf8_to_xml_encoding "$(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)")"
elif [ ! -z "$PID_MPD" ] && [ "$STS_MPD" == "Paused" ]; then
    echo "<span foreground='#e3e2f3'>  </span>  $(utf8_to_xml_encoding "$(mpc current)")"
elif [ ! -z "$PID_SPT" ] && [ "$STS_SPT" == "Paused" ]; then
    echo "<span foreground='#e3e2f3'>  </span>  $(utf8_to_xml_encoding "$(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)")"
else
    echo "  stopped"
fi
