#!/bin/bash
# notes.sh - Create and list notes and projects

NOTES_ROOT="{{kms_path}}"
CAPTURE_DIR="$NOTES_ROOT/inbox"
PROJECTS_DIR="$NOTES_ROOT/projects"

sanitize_name() {
    local input="${1,,}"
    input=$(echo "$input" | tr -dc '[:alnum:] -')
    echo "${input// /-}"
}

prompt_name() {
    local label="$1"
    read -rp "${label}: " name
    if [[ -z "$name" ]]; then
        echo "Name cannot be empty." >&2
        exit 1
    fi
    sanitize_name "$name"
}

cmd_new_note() {
    local slug
    slug=$(prompt_name "Note name")
    local filename="$(date +%Y-%m-%d)__${slug}.md"
    local filepath="${CAPTURE_DIR}/${filename}"
    mkdir -p "$CAPTURE_DIR"
    echo "$filepath"
    exec nvim --cmd 'startinsert' "$filepath"
}

cmd_new_project() {
    local slug
    slug=$(prompt_name "Project name")
    local project_path="${PROJECTS_DIR}/${slug}"

    if [[ -d "$project_path" ]]; then
        echo "${slug} already exists." >&2
        exit 0
    fi

    mkdir -p "$project_path"
    touch "${project_path}/main.md"
    echo "Created: ${project_path}"
    exec nvim "${project_path}/main.md"
}

cmd_list_notes() {
    find "$CAPTURE_DIR" -maxdepth 1 -name "*.md" -printf '%T@ %f\n' \
        | sort -n \
        | cut -d' ' -f2-
}

cmd_list_projects() {
    for dir in "$PROJECTS_DIR"/*/; do
        [[ -d "$dir" ]] || continue
        newest=$(find "$dir" -type f -printf '%T@\n' | sort -rn | head -1)
        echo "${newest:-0} $(basename "$dir")"
    done | sort -n | cut -d' ' -f2-
}

cmd_open_note() {
    local selection
    selection=$(cmd_list_notes | fzf --tac --cycle) || exit 0
    exec nvim --cmd "cd $NOTES_ROOT" "${CAPTURE_DIR}/${selection}"
}

cmd_open_project() {
    local selection
    selection=$(cmd_list_projects | fzf --tac --cycle) || exit 0
    exec nvim --cmd "cd $NOTES_ROOT" "${PROJECTS_DIR}/${selection}/main.md"
}

cmd_review() {
    local files=()
    while IFS= read -r line; do
        files+=("${line#* }")
    done < <(stat -c '%W %n' "$CAPTURE_DIR"/*.md 2>/dev/null | sort -n)

    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No files to review."
        return
    fi

    for i in "${!files[@]}"; do
        local oldest="${files[$i]}"
        [[ -f "$oldest" ]] || continue

        local filename
        filename=$(basename "$oldest")
        echo "Reviewing: $filename"
        nvim --cmd "cd $NOTES_ROOT" "$oldest"

        local action=""
        while [[ "$action" != "d" && "$action" != "m" && "$action" != "s" ]]; do
            read -rp "(d)elete / (m)ove to archive / (s)kip [s]: " action
            action="${action:-s}"
        done

        case "$action" in
            d)
                rm "$oldest"
                echo "Deleted: $filename"
                ;;
            m)
                local year
                year=$(date -d "@$(stat -c '%W' "$oldest")" +%Y)
                local archive_dir="$NOTES_ROOT/archive/captures/${year}"
                mkdir -p "$archive_dir"
                mv "$oldest" "$archive_dir/"
                echo "Moved: $filename -> archive/captures/${year}/"
                ;;
            s)
                echo "Skipped: $filename"
                ;;
        esac

        # Skip continue/quit prompt on the last file
        if [[ $i -lt $((${#files[@]} - 1)) ]]; then
            local next=""
            while [[ "$next" != "c" && "$next" != "q" ]]; do
                echo ""
                read -rp "(c)ontinue / (q)uit [c]: " next
                next="${next:-c}"
            done
            [[ "$next" == "q" ]] && return
        fi
    done
}

case "${1:-}" in
    new)
        case "${2:-}" in
            project|projects) cmd_new_project ;;
            "")               cmd_new_note ;;
            *)                echo "Unknown: notes.sh new ${2}" >&2; exit 1 ;;
        esac
        ;;
    list)
        case "${2:-}" in
            project|projects) cmd_list_projects ;;
            "")               cmd_list_notes ;;
            *)                echo "Unknown: notes.sh list ${2}" >&2; exit 1 ;;
        esac
        ;;
    open)
        case "${2:-}" in
            project|projects) cmd_open_project ;;
            "")               cmd_open_note ;;
            *)                echo "Unknown: notes.sh open ${2}" >&2; exit 1 ;;
        esac
        ;;
    review)
        cmd_review
        ;;
    *)
        echo "Usage: notes.sh {new|list|open|review} [project]"
        exit 1
        ;;
esac
