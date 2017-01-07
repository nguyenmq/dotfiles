#!/bin/bash

utf8_to_xml_encoding() {
    echo "$1" | recode utf8..xml
}

if [ $(playerctl -p mpd status) == "Playing" ]; then
    echo "<span foreground='#e3e2f3'>  </span>  $(utf8_to_xml_encoding "$(mpc current)")"
elif [ $(playerctl -p spotify status) == "Playing" ]; then
    echo "<span foreground='#e3e2f3'>  </span>  $(utf8_to_xml_encoding "$(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)")"
elif [ $(playerctl -p mpd status) == "Paused" ]; then
    echo "<span foreground='#e3e2f3'>  </span>  $(utf8_to_xml_encoding "$(mpc current)")"
elif [ $(playerctl -p spotify status) == "Paused" ]; then
    echo "<span foreground='#e3e2f3'>  </span>  $(utf8_to_xml_encoding "$(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)")"
else
    echo "  stopped"
fi
