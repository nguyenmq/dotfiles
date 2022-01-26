#!/bin/bash

if ! which autorandr &> /dev/null; then
    echo "# WARNING: autorandr not detected"
    exit 0
fi

declare -A monitor_outputs

while read -r output; do
    shortcut="${output:0:1}"
    label="${output}"
    monitor_outputs["$shortcut"]="$label"
done < <(autorandr --list)

# Build the label prompt
prompt=""
for shortcut in "${!monitor_outputs[@]}"; do
    label="${monitor_outputs[$shortcut]}"
    prompt="$prompt ($shortcut) $label"
done
echo "set \$monitor_output $prompt"
echo 'mode --pango_markup "$monitor_output" {'

# Build the individual bindings
for shortcut in "${!monitor_outputs[@]}"; do
    label="${monitor_outputs[$shortcut]}"
    printf '    bindsym %s exec --no-startup-id "autorandr --load %s", mode "default"\n' "$shortcut" "$label"
done

echo '    bindsym Return mode "default"'
echo '    bindsym Escape mode "default"'
echo '}'
echo 'bindsym $mod+d mode "$monitor_output"'
