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
  local url="ssh://git@git.zacsek.net:2222/zacsek/${1:-$(basename "$PWD")}.git"
  git remote add forgejo "$url" 2>/dev/null || git remote set-url forgejo "$url"
  git remote -v | grep "^forgejo"
}

# --- scanning & OCR (needs: sane, img2pdf, ocrmypdf, tesseract-data-*) ---
: "${SCAN_DEVICE_HP:=airscan:e0:HP Officejet 5740 series [C739CA]}"
: "${SCAN_DEVICE_BROTHER:=}"

# ocr -l LANGS [-r] file.pdf... : OCR each PDF into <name>_ocr.pdf
ocr() {
    local OPTIND=1 opt langs="" raw=0
    local usage="usage: ocr -l LANGS [-r] FILE.pdf... [-- OCRMYPDF_ARGS...]

OCR scanned PDFs; writes <name>_ocr.pdf next to each input.

  -l LANGS   tesseract languages, joined with + (required), e.g. hun+eng
  -r         raw: skip the default --deskew --rotate-pages cleanup
  -h         show this help
  --         pass the remaining args to ocrmypdf (e.g. -- --force-ocr)

installed languages: $(tesseract --list-langs 2>/dev/null | tail -n +2 | grep -v osd | tr '\n' ' ')
examples:
  ocr -l hun+eng contract.pdf          -> contract_ocr.pdf
  ocr -l deu *.pdf"
    while getopts ":l:rh" opt; do
        case "$opt" in
            l) langs="$OPTARG" ;;
            r) raw=1 ;;
            h) echo "$usage"; return 0 ;;
            :) echo "ocr: -$OPTARG needs an argument" >&2; return 2 ;;
            *) echo "ocr: unknown option -$OPTARG (see ocr -h)" >&2; return 2 ;;
        esac
    done
    shift $((OPTIND - 1))

    if [ -z "$langs" ]; then echo "ocr: -l LANGS is required (see ocr -h)" >&2; return 2; fi
    local l
    for l in $(echo "$langs" | tr '+' ' '); do
        if ! tesseract --list-langs 2>/dev/null | grep -qx "$l"; then
            echo "ocr: language '$l' not installed (sudo pacman -S tesseract-data-$l)" >&2
            return 2
        fi
    done

    local files=() extra=() f
    while [ $# -gt 0 ]; do
        if [ "$1" = "--" ]; then shift; extra=("$@"); break; fi
        files+=("$1"); shift
    done
    if [ ${#files[@]} -eq 0 ]; then echo "ocr: no input files (see ocr -h)" >&2; return 2; fi
    [ "$raw" -eq 0 ] && extra=(--deskew --rotate-pages "${extra[@]}")

    local rc=0 out
    for f in "${files[@]}"; do
        if [ ! -f "$f" ]; then echo "ocr: $f: no such file" >&2; rc=1; continue; fi
        out="${f%.[pP][dD][fF]}_ocr.pdf"
        echo "ocr: $f -> $out"
        ocrmypdf -l "$langs" "${extra[@]}" "$f" "$out" || rc=1
    done
    return $rc
}

# scan [-d DEV] [-r DPI] [-m MODE] [-a] [-l LANGS] [NAME] : scan to NAME.pdf (+ NAME_ocr.pdf with -l)
scan() {
    local OPTIND=1 opt dev="hp" dpi=300 mode="Color" source="Flatbed" langs=""
    local usage="usage: scan [-d DEVICE] [-r DPI] [-m MODE] [-a] [-l LANGS] [NAME]

Scan to NAME.pdf (default: scan-<date>-<time>.pdf in the current dir).

  -d DEVICE  hp (default), brother, list, or a full SANE device name
  -r DPI     resolution (default 300; 150 text, 600 photos)
  -m MODE    color (default) or gray
  -a         use the document feeder (ADF): scans all fed pages into one PDF
  -l LANGS   also OCR into NAME_ocr.pdf, e.g. -l hun+eng
  -h         show this help

devices: hp=\$SCAN_DEVICE_HP (${SCAN_DEVICE_HP:-unset}), brother=\$SCAN_DEVICE_BROTHER (${SCAN_DEVICE_BROTHER:-unset})
examples:
  scan                                 -> scan-2026-10-26-173000.pdf
  scan -a -l hun+eng invoice           -> invoice.pdf + invoice_ocr.pdf
  scan -m gray -r 150 ~/Scans/letter"
    while getopts ":d:r:m:al:h" opt; do
        case "$opt" in
            d) dev="$OPTARG" ;;
            r) dpi="$OPTARG" ;;
            m) mode="$OPTARG" ;;
            a) source="ADF" ;;
            l) langs="$OPTARG" ;;
            h) echo "$usage"; return 0 ;;
            :) echo "scan: -$OPTARG needs an argument" >&2; return 2 ;;
            *) echo "scan: unknown option -$OPTARG (see scan -h)" >&2; return 2 ;;
        esac
    done
    shift $((OPTIND - 1))

    case "$dev" in
        list)    scanimage -L; return ;;
        hp)      dev="$SCAN_DEVICE_HP" ;;
        brother) dev="$SCAN_DEVICE_BROTHER" ;;
    esac
    if [ -z "$dev" ]; then
        echo "scan: device not configured; set SCAN_DEVICE_BROTHER (see scan -d list)" >&2
        return 2
    fi
    case "$mode" in
        [cC]olo*) mode="Color" ;;
        [gG]ray|[gG]rey) mode="Gray" ;;
        *) echo "scan: mode must be color or gray" >&2; return 2 ;;
    esac

    local name="${1:-scan-$(date +%F-%H%M%S)}"
    name="${name%.[pP][dD][fF]}"
    if [ -e "$name.pdf" ]; then echo "scan: $name.pdf already exists" >&2; return 1; fi

    local tmp
    tmp="$(mktemp -d)" || return 1
    echo "scan: $dev ($source, ${dpi}dpi, $mode) -> $name.pdf"
    if [ "$source" = "ADF" ]; then
        scanimage -d "$dev" --source ADF --resolution "$dpi" --mode "$mode" \
            --format=png --batch="$tmp/page%03d.png"
    else
        scanimage -d "$dev" --source Flatbed --resolution "$dpi" --mode "$mode" \
            --format=png -o "$tmp/page001.png"
    fi

    local pages=() p
    while IFS= read -r p; do pages+=("$p"); done < <(find "$tmp" -name 'page*.png' | sort)
    if [ ${#pages[@]} -eq 0 ]; then
        echo "scan: nothing was scanned" >&2
        rm -rf "$tmp"; return 1
    fi
    img2pdf "${pages[@]}" -o "$name.pdf" || { rm -rf "$tmp"; return 1; }
    rm -rf "$tmp"
    echo "scan: saved $name.pdf (${#pages[@]} page(s))"

    [ -n "$langs" ] && ocr -l "$langs" "$name.pdf"
}
