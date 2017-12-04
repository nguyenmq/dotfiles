#!/bin/bash

INTERFACE="${BLOCK_INSTANCE:-wlan0}"

#------------------------------------------------------------------------

# As per #36 -- It is transparent: e.g. if the machine has no battery or wireless
# connection (think desktop), the corresponding block should not be displayed.
if [[ ! -d /sys/class/net/${INTERFACE}/wireless ]] || [[ "$(cat /sys/class/net/$INTERFACE/operstate)" = 'down' ]]; then
    echo ":("
else
    QUALITY=$(grep $INTERFACE /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')
    echo $QUALITY% # full text
fi
