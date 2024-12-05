#!/bin/bash

INBOX_PATH="{{kms_path}}/inbox"

new_note_file="${INBOX_PATH}/$(date +"%Y-%m-%dT%H-%M").md"
exec nvim --cmd 'startinsert' "$new_note_file"
