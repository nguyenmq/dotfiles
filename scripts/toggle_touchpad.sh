#!/bin/bash

DEVICE_ID=$(xinput list | awk -F '=' '/Synaptics TouchPad/ {split($2, a, "\\s+"); print a[1]}')
MODE=$(xinput --list-props $DEVICE_ID | awk '/Device Enabled/ {print $NF}')

if [ $MODE -eq 0 ]; then
    xinput --enable $DEVICE_ID
else
    xinput --disable $DEVICE_ID
fi
