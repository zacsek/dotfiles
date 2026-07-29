mkcd() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

help() {
    "$@" --help 2>&1 | bat --plain --language=help
}

tailf() {
    tail -f "$1" | bat --paging=never -l log
}

witch() {
    local file=$(which "$1" 2>/dev/null)
    if [ -z "$file" ]; then
        echo "witch: $1 not found" >&2
        return 1
    fi
    while [ -L "$file" ]; do
        echo -n "$file -> "
        file=$(readlink -f "$file")
    done
    echo "$file"
}

pack() {
    local file=$(which "$1" 2>/dev/null)
    if [ -z "$file" ]; then
        echo "pack: $1 not found" >&2
        return 1
    fi
    if command -v dpkg &>/dev/null; then
        dpkg -S "$file"
    else
        echo "dpkg not available on this system." >&2
        return 1
    fi
}

figprint() {
    if command -v figlet &>/dev/null && command -v lolcat &>/dev/null; then
        figlet "$*" | lolcat --seed 60
    else
        echo "$*"
    fi
}
