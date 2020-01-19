#!/bin/bash

# to create a dim image:
# convert 20170604_0110.png -fill black -colorize 40% .xlock/lock_dim.png

ORIGIN_MM=22 # mm
SPACING=8 # mm
RADIUS=40 # px
DATE_SIZE=20 # px
TIME_SIZE=38 # px
NORMAL_DPI=96

current_dpi=$(xrdb -query | awk '/Xft.dpi/ {print $2}')
if [[ -z "$current_dpi" ]]; then
    current_dpi="$NORMAL_DPI"
fi

scale_factor=$(( current_dpi / NORMAL_DPI ))
px_per_mm=$(xrandr | awk -v "scale=$scale_factor" '/connected primary/ {split($4, resolution, "x|+"); real_width=substr($NF, 0, length($NF) - 2); printf "%d", ((resolution[2] / scale) / real_width)}')

origin=$(( ORIGIN_MM * px_per_mm ))
text_spacing="$RADIUS"
left_text=$(( text_spacing + origin + RADIUS ))
time_ypos=$(( origin - ( RADIUS / 4 ) ))
date_ypos=$(( time_ypos + TIME_SIZE  ))

indpos="${origin}:${origin}"
timepos="${left_text}:${time_ypos}"
datepos="${left_text}:${date_ypos}"

/usr/bin/i3lock \
    --tiling --image="${HOME}/.xlock/lock_dim.png" \
    --ignore-empty-password \
    --force-clock \
    --indicator --indpos="$indpos" --radius="$RADIUS" \
    --date-align=1 --datestr="%A  %Y/%m/%d" --datepos="$datepos" --date-font="Ubuntu" --datesize="$DATE_SIZE" --datecolor=ffffffff \
    --time-align=1 --timestr="%I:%M %p" --timepos="$timepos" --time-font="Ubuntu" --timesize="$TIME_SIZE" --timecolor=ffffffff \
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
