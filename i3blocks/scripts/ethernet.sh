#!/bin/bash

if  [[ $(cat /sys/class/net/$BLOCK_INSTANCE/dormant) -ne 0 ]]; then
    echo "No Connection"
else
    echo "  $(hostname -i)"
fi
