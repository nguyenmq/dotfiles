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

function check_unused_imports() {
    local class
    local count
    declare -a imports
    local imports

    readarray -t imports < <(ag --all-text --no-color --vimgrep '^import ' "$FILE")

    for import in "${imports[@]}"; do
        class=$(echo "$import" | awk -F '.' '{gsub(";", "", $NF); print $NF}')
        count=$(ag --count --word-regexp "$class" "$FILE")

        if [[ "$count" -eq 1 ]]; then
            echo "$import"
        fi
    done
}

check_unused_imports
