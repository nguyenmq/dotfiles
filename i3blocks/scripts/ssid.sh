#!/bin/bash

SSID=$(iwgetid | grep $BLOCK_INSTANCE | cut -d':' -f2 | tr -d '"')
echo "  $SSID"
