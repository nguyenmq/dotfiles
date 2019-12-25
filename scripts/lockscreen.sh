#!/bin/bash

# to create a dim image:
# convert 20170604_0110.png -fill black -colorize 40% .xlock/lock_dim.png

NORMAL_DPI=96

current_dpi=$(xrdb -query | awk '/Xft.dpi/ {print $2}')

if [[ -n "$current_dpi" ]] && [[ "$current_dpi" -gt "$NORMAL_DPI" ]]; then
    indpos=$(xrandr | awk '/connected primary/ {split($4, res, "x|+"); printf "%d:%d", res[1]*0.035, res[2]*0.43}')
    timepos=$(xrandr | awk '/connected primary/ {split($4, res, "x|+"); printf "%d:%d", res[1]*0.06, res[2]*0.43}')
    datepos=$(xrandr | awk '/connected primary/ {split($4, res, "x|+"); printf "%d:%d", res[1]*0.06, res[2]*0.45}')
else
    indpos=$(xrandr | awk '/connected primary/ {split($4, res, "x|+"); printf "%d:%d", res[1]*0.05, res[2]*0.8}')
    timepos=$(xrandr | awk '/connected primary/ {split($4, res, "x|+"); printf "%d:%d", res[1]*0.085, res[2]*0.8}')
    datepos=$(xrandr | awk '/connected primary/ {split($4, res, "x|+"); printf "%d:%d", res[1]*0.085, res[2]*0.82}')
fi


/usr/bin/i3lock \
    --tiling --image="${HOME}/.xlock/lock_dim.png" \
    --ignore-empty-password \
    --force-clock \
    --indicator --indpos="$indpos" --radius=40 \
    --date-align=1 --datestr="%A  %Y/%m/%d" --datepos="$datepos" --date-font="Ubuntu" --datesize=20 --datecolor=ffffffff \
    --time-align=1 --timestr="%I:%M %p" --timepos="$timepos" --time-font="Ubuntu" --timesize=38 --timecolor=ffffffff \
    --insidecolor=00000000 \
    --insidevercolor=00000000 \
    --insidewrongcolor=00000000 \
    --line-uses-inside \
    --ringcolor=2bb24cff \
    --ringvercolor=ffffffff \
    --ringwrongcolor=ff4646ff \
    --keyhlcolor=ffffffff \
    --bshlcolor=ff4646ff \
    --veriftext="" --verif-font="Ubuntu" --verifsize=30 --verifcolor=2bb24cff \
    --wrongtext="" --wrong-font="Ubuntu" --wrongsize=30 --wrongcolor=ff4646ff \
    --noinputtext="" \
    --nofork

exit 0
