#!/bin/bash

MODE=$(synclient | grep TouchpadOff | awk '{ print $3 }')
if [ $MODE -eq 0 ]; then
    synclient TouchpadOff=1
else
    synclient TouchpadOff=0
fi
