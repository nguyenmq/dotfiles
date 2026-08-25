_notes_sh() {
    local cur prev
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    case "$COMP_CWORD" in
        1)
            COMPREPLY=($(compgen -W "new list open review" -- "$cur"))
            ;;
        2)
            case "$prev" in
                new|list|open)
                    COMPREPLY=($(compgen -W "project" -- "$cur"))
                    ;;
            esac
            ;;
    esac
}

complete -F _notes_sh notes
