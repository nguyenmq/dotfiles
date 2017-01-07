#!/bin/bash

SSID=$(iwgetid | grep $BLOCK_INSTANCE | cut -d':' -f2 | tr -d '"')
echo "<span foreground='#e3e2f3'></span>  $SSID"
