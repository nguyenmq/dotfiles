#!/bin/bash

INTERFACE="${BLOCK_INSTANCE:-wlan0}"

if [[ ! -d /sys/class/net/${INTERFACE}/wireless ]] || [[ "$(cat /sys/class/net/$INTERFACE/operstate)" = 'down' ]]; then
    echo "No Connection"
else
    SSID=$(iwgetid | grep $BLOCK_INSTANCE | cut -d':' -f2 | tr -d '"')
    echo "  $SSID"
fi

