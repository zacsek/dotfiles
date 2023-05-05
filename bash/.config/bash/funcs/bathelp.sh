alias bathelp='bat --plain --language=help'

# Use for example like:
#   > help cp        -> instead of cp --help
#   > help find      -> instead of find --help
#   > help ln        -> instead of ln --help
#   ...

help() {
    "$@" --help 2>&1 | bathelp
}
