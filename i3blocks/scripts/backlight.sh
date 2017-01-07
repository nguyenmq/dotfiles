#!/bin/bash

BRIGHTNESS=$(printf %.0f "$(xbacklight -get)")
echo "<span foreground='#e3e2f3'></span>  $BRIGHTNESS%"
