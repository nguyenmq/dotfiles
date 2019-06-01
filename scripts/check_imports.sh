#!/bin/bash

set -u

if [[ "$#" -lt 1 ]]; then
    echo "Need to supply a file to validate"
    exit 1
fi

FILE="$1"

if [[ ! -e "$FILE" ]]; then
    echo "\"$FILE\" does not exist"
    exit 1
fi

declare -a IMPORTS
readarray -t IMPORTS < <(ag --all-text --no-color --vimgrep '^import ' "$FILE")

for imp in "${IMPORTS[@]}"; do
    class=$(echo "$imp" | awk -F '.' '{gsub(";", "", $NF); print $NF}')
    count=$(grep -c "$class" "$FILE")

    if [[ "$count" -eq 1 ]]; then
        echo "$imp"
    fi
done
