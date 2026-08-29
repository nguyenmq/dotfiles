# Wrap `nt cd` so it changes the current shell's directory
# (a subprocess can't chdir its parent, so cd into the path the script prints)
nt() {
    if [[ "$1" == "cd" ]]; then
        local dir
        dir=$(command nt "$@") || return
        [[ -n "$dir" ]] && cd "$dir"
    else
        command nt "$@"
    fi
}

_notes_sh() {
    local cur prev
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    case "$COMP_CWORD" in
        1)
            COMPREPLY=($(compgen -W "new list open cd review" -- "$cur"))
            ;;
        2)
            case "$prev" in
                new|list|open|cd)
                    COMPREPLY=($(compgen -W "project domain resource" -- "$cur"))
                    ;;
            esac
            ;;
    esac
}

complete -F _notes_sh nt
