#!/bin/bash

MODE=$(synclient | grep TouchpadOff | awk '{ print $3 }')
if [ $MODE -eq 0 ]; then
    synclient TouchpadOff=1
    notify-send -i input-touchpad "Touchpad Off"
else
    synclient TouchpadOff=0
    notify-send -i input-touchpad "Touchpad On"
fi
