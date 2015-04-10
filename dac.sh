#!/bin/bash

DAC="alsa_output.usb-Burr-Brown_from_TI_USB_Audio_DAC-00-DAC.analog-stereo"

if pactl list short sinks | grep $DAC >> /dev/null; then
    pactl set-default-sink $DAC
    if [ $? -eq 0 ]; then
        notify-send -i audio-card "Success" "Set sink to DAC"
    else
        SINK=$(pactl info | grep "Default Sink" | awk '{ print $3 }' | cut -d '.' -f 2)
        notify-send -i audio-card "Failed. Sink is" "$SINK"
    fi
else
    notify-send -i audio-card "No such device" "$DAC"
fi
