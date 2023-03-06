#!/bin/bash

TMP_ALBUM_ART_PATH="/tmp/mpd_album_art"
MPC_FORMAT='{
"file": "%file%",
"title": "%title%",
"artist": "%artist%",
"album": "%album%",
"date": "%date%",
"totaltime": "%totaltime%",
"currenttime": "%currenttime%"
}'

raw_mpc=$(mpc -f "$MPC_FORMAT")
json_info=$(echo "$raw_mpc" | head -n-2)

file=$(echo "$json_info" | jq --raw-output '.file')
title=$(echo "$json_info" | jq --raw-output '.title')
artist=$(echo "$json_info" | jq --raw-output '.artist')
album=$(echo "$json_info" | jq --raw-output '.album')
date=$(echo "$json_info" | jq --raw-output '.date' | cut -d'-' -f1)
player_stats=$(echo "$raw_mpc" | tail -n-2 | head -n1 | awk '{printf "%s %s %s", $3, $4, $1}')

mpc readpicture "$file" > "$TMP_ALBUM_ART_PATH"
action=$(dunstify --action="default,albumart" --appname="mpd" --replace=32 --icon="$TMP_ALBUM_ART_PATH" --timeout=10000 "$title" "\n$artist\n$album\n$date\n$player_stats")

case "$action" in
    "default")
        feh --image-bg="black" "$TMP_ALBUM_ART_PATH"
        ;;
esac
