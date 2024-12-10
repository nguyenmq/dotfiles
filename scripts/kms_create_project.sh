#!/bin/bash

PROJECT_DIRECTORY="{{kms_path}}/projects"
PROJECT_NAME=""
PROJECT_FULL_PATH=""
TASK_ID=""

print_help() {
    echo "./$(basename "${0}") -n <project_name> [-t <task_id>]"
    echo ""
    echo "Creates a new project directory and main file."
    echo ""
    echo "-h    Print this help."
    echo "-n    Name of the project."
    echo "-t    Optional task ID. This will prefix the project name."
    exit 0;
}

check_inputs() {
    if [[ -z "$PROJECT_NAME" ]]; then
        echo "Must provide a project name."
        exit 1
    fi

    if [[ -d "$PROJECT_FULL_PATH" ]]; then
        echo "Project ${PROJECT_NAME} already exists. Nothing to do."
        exit 0
    fi
}

create_project() {
    mkdir -p "$PROJECT_FULL_PATH"
    touch "${PROJECT_FULL_PATH}/main.md"
    echo "Created new project at: ${PROJECT_FULL_PATH}"
}

while getopts "hn:t:" opt; do
    case "$opt" in
        h)
            print_help
            ;;
        n)
            PROJECT_NAME="${OPTARG,,}"
            PROJECT_NAME=$(echo "$PROJECT_NAME" | tr -d "[:punct:]")
            PROJECT_NAME="${PROJECT_NAME// /_}"

            ;;
        t)
            TASK_ID="${OPTARG,,}"
            TASK_ID="${TASK_ID// /_}"
            ;;
        *)
            print_help
            ;;
    esac
done

if [[ -n "$TASK_ID" ]]; then
    PROJECT_FULL_PATH="${PROJECT_DIRECTORY}/${TASK_ID}__${PROJECT_NAME}"
else
    PROJECT_FULL_PATH="${PROJECT_DIRECTORY}/${PROJECT_NAME}"
fi

check_inputs
create_project
