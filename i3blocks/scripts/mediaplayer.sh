#!/bin/bash

if [ $(playerctl -p mpd status) == "Playing" ]; then
    echo "<span foreground='#e3e2f3'>  </span>  $(mpc current)"
elif [ $(playerctl -p spotify status) == "Playing" ]; then
    echo "<span foreground='#e3e2f3'>  </span>  $(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)"
elif [ $(playerctl -p mpd status) == "Paused" ]; then
    echo "<span foreground='#e3e2f3'>  </span>  $(mpc current)"
elif [ $(playerctl -p spotify status) == "Paused" ]; then
    echo "<span foreground='#e3e2f3'>  </span>  $(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)"
else
    echo "  stopped"
fi
