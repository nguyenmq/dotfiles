#!/bin/bash

DOMAIN_DIRECTORY="{{kms_path}}/domains"
PROJECT_DIRECTORY="{{kms_path}}/projects"
BASE_DIRECTORY="$PROJECT_DIRECTORY"

NEW_DIRECTORY_NAME=""
PROJECT_FULL_PATH=""
TASK_ID=""

print_help() {
    echo "./$(basename "${0}") [-t <task_id>] [-d] <project_or_domain_name> "
    echo ""
    echo "Creates a new project or domain directory and main file. Defaults to project."
    echo ""
    echo "-d    Create a new domain instead of project."
    echo "-h    Print this help."
    echo "-t    Optional task ID. This will prefix the project name."
    exit 0;
}

check_inputs() {
    if [[ -z "$NEW_DIRECTORY_NAME" ]]; then
        echo "Must provide a project or domain name."
        exit 1
    fi

    if [[ -d "$PROJECT_FULL_PATH" ]]; then
        echo "${NEW_DIRECTORY_NAME} already exists. Nothing to do."
        exit 0
    fi
}

create_project_or_domain() {
    mkdir -p "$PROJECT_FULL_PATH"
    touch "${PROJECT_FULL_PATH}/main.md"
    echo "Created new project/domain at: ${PROJECT_FULL_PATH}"
}

arg_parse_error() {
    print_help
    exit 1
}

PARSED_OPTIONS=$(getopt --options "dht:" -- "$@") || arg_parse_error
eval set -- "$PARSED_OPTIONS"

while true; do
    case "$1" in
        -d)
            BASE_DIRECTORY="$DOMAIN_DIRECTORY"
            shift
            ;;
        -h)
            print_help
            shift
            ;;
        -t)
            TASK_ID="${2,,}"
            TASK_ID="${TASK_ID// /_}"
            shift 2
            ;;
        --)
            NEW_DIRECTORY_NAME="${2,,}"
            NEW_DIRECTORY_NAME=$(echo "$NEW_DIRECTORY_NAME" | tr -d "[:punct:]")
            NEW_DIRECTORY_NAME="${NEW_DIRECTORY_NAME// /_}"
            shift
            break
            ;;
    esac
done

if [[ -n "$TASK_ID" ]]; then
    PROJECT_FULL_PATH="${BASE_DIRECTORY}/${TASK_ID}__${NEW_DIRECTORY_NAME}"
else
    PROJECT_FULL_PATH="${BASE_DIRECTORY}/${NEW_DIRECTORY_NAME}"
fi

check_inputs
create_project_or_domain
