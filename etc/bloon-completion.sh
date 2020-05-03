_bloon_cli_complete()
{
    local cur prev

    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    case ${COMP_CWORD} in
        1)
            COMPREPLY=($(compgen -W "start status account bloon space login logout stop install upgrade" -- ${cur}))
            ;;
        2)
            case ${prev} in
                account)
                    COMPREPLY=($(compgen -W "login logout current detail" -- ${cur}))
                ;;
                space)
                    COMPREPLY=($(compgen -W "ls" -- ${cur}))
                ;;
                bloon)
                    COMPREPLY=($(compgen -W "ls" -- ${cur}))
                ;;
            esac
            ;;
        *)
            COMPREPLY=()
            ;;
    esac
}

complete -F _bloon_cli_complete bloon
