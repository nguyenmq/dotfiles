#!/bin/bash
# notes.sh - Create, list, open, and cd into notes and collections
#            (projects, domains, resources)

NOTES_ROOT="{{kms_path}}"
CAPTURE_DIR="$NOTES_ROOT/inbox"
PROJECTS_DIR="$NOTES_ROOT/projects"
DOMAINS_DIR="$NOTES_ROOT/domains"
RESOURCES_DIR="$NOTES_ROOT/resources"

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
    local filename
    local filepath
    slug=$(prompt_name "Note name")
    filename="$(date +%Y-%m-%d)__${slug}.md"
    filepath="${CAPTURE_DIR}/${filename}"

    mkdir -p "$CAPTURE_DIR"
    echo "$filepath"
    exec nvim --cmd "startinsert; cd ${CAPTURE_DIR}" "$filepath"
}

# Create a brand new collection entry (project/domain/resource) with a main.md.
create_collection_entry() {
    local base
    local label
    local slug
    local entry_path
    base="$1"
    label="$2"
    slug=$(prompt_name "${label} name")
    entry_path="${base}/${slug}"

    if [[ -d "$entry_path" ]]; then
        echo "${slug} already exists." >&2
        exit 0
    fi

    mkdir -p "$entry_path"
    touch "${entry_path}/main.md"
    echo "Created: ${entry_path}"
    exec nvim --cmd "cd ${entry_path}" "${entry_path}/main.md"
}

# fzf over the entries in a collection, plus a "Create new <label>" option.
# Selecting an existing entry prompts for a new file to add to it; the "create
# new" option makes a brand new entry.
cmd_new_collection() {
    local base
    local label
    local create_sentinel
    local selection
    base="$1"
    label="$2"
    create_sentinel="Create new ${label,,}"
    selection=$( { echo "$create_sentinel"; list_collection "$base"; } | fzf --tac --cycle) || exit 0

    if [[ "$selection" == "$create_sentinel" ]]; then
        create_collection_entry "$base" "$label"
    else
        local slug
        slug=$(prompt_name "File name")
        local filepath="${base}/${selection}/${slug}.md"
        echo "$filepath"
        exec nvim --cmd "cd ${base}/${selection}" "$filepath"
    fi
}

cmd_list_notes() {
    find "$CAPTURE_DIR" -maxdepth 1 -name "*.md" -printf '%T@ %f\n' \
        | sort -n \
        | cut -d' ' -f2-
}

# List the immediate subdirectories of a collection dir, oldest-modified first.
list_collection() {
    local base
    base="$1"

    for dir in "$base"/*/; do
        [[ -d "$dir" ]] || continue
        newest=$(find "$dir" -type f -printf '%T@\n' | sort -rn | head -1)
        echo "${newest:-0} $(basename "$dir")"
    done | sort -n | cut -d' ' -f2-
}

# List every file under a directory (recursively), oldest-modified first,
# as paths relative to that directory.
list_files() {
    local dir="$1"
    find "$dir" -type f -printf '%T@ %P\n' | sort -n | cut -d' ' -f2-
}

cmd_open_note() {
    local selection

    selection=$(cmd_list_notes | fzf --tac --cycle) || exit 0
    exec nvim --cmd "cd ${CAPTURE_DIR}" "${CAPTURE_DIR}/${selection}"
}

# Pick an entry in a collection, then pick a file within it, and open it.
cmd_open_collection() {
    local base
    local entry
    local file
    base="$1"
    entry=$(list_collection "$base" | fzf --tac --cycle) || exit 0
    file=$(list_files "${base}/${entry}" | fzf --tac --cycle) || exit 0
    exec nvim --cmd "cd ${base}/${entry}" "${base}/${entry}/${file}"
}

cmd_cd_inbox() {
    echo "$CAPTURE_DIR"
}

# Pick an entry in a collection and print its path (the shell wrapper cd's into it).
cmd_cd_collection() {
    local base
    local selection
    base="$1"
    selection=$(list_collection "$base" | fzf --tac --cycle) || exit 0
    echo "${base}/${selection}"
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
            project|projects)   cmd_new_collection "$PROJECTS_DIR"  "Project" ;;
            domain|domains)     cmd_new_collection "$DOMAINS_DIR"   "Domain" ;;
            resource|resources) cmd_new_collection "$RESOURCES_DIR" "Resource" ;;
            "")                 cmd_new_note ;;
            *)                  echo "Unknown: notes.sh new ${2}" >&2; exit 1 ;;
        esac
        ;;
    list)
        case "${2:-}" in
            project|projects)   list_collection "$PROJECTS_DIR" ;;
            domain|domains)     list_collection "$DOMAINS_DIR" ;;
            resource|resources) list_collection "$RESOURCES_DIR" ;;
            "")                 cmd_list_notes ;;
            *)                  echo "Unknown: notes.sh list ${2}" >&2; exit 1 ;;
        esac
        ;;
    open)
        case "${2:-}" in
            project|projects)   cmd_open_collection "$PROJECTS_DIR" ;;
            domain|domains)     cmd_open_collection "$DOMAINS_DIR" ;;
            resource|resources) cmd_open_collection "$RESOURCES_DIR" ;;
            "")                 cmd_open_note ;;
            *)                  echo "Unknown: notes.sh open ${2}" >&2; exit 1 ;;
        esac
        ;;
    cd)
        case "${2:-}" in
            project|projects)   cmd_cd_collection "$PROJECTS_DIR" ;;
            domain|domains)     cmd_cd_collection "$DOMAINS_DIR" ;;
            resource|resources) cmd_cd_collection "$RESOURCES_DIR" ;;
            "")                 cmd_cd_inbox ;;
            *)                  echo "Unknown: notes.sh cd ${2}" >&2; exit 1 ;;
        esac
        ;;
    review)
        cmd_review
        ;;
    *)
        echo "Usage: notes.sh {new|list|open|cd} [project|domain|resource] | notes.sh review"
        exit 1
        ;;
esac
