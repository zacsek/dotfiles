mkcd() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

# vpick [dir]: fuzzy-pick files under dir (default: .) and open them in nvim; does nothing if nothing is picked
vpick() {
    (
        cd -- "${1:-.}" || exit 1
        local files=() f
        while IFS= read -r f; do
            files+=("$f")
        done < <(find . -type f -not -path '*/.git/*' | fzf-tmux -m --preview 'bat --color=always --style=numbers --line-range=:500 {} 2>/dev/null || cat {}')
        [ ${#files[@]} -gt 0 ] && nvim -O "${files[@]}"
    )
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

forgejo_add_remote() {
  local url="ssh://git@forgejo.zacsek.net:2222/zacsek/${1:-$(basename "$PWD")}.git"
  git remote add forgejo "$url" 2>/dev/null || git remote set-url forgejo "$url"
  git remote -v | grep "^forgejo"
}
