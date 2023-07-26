#!/usr/bin/env bash

set -euo pipefail
IFS=$'\t\n\0'
shopt -s lastpipe

# -allow a command to fail with !’s side effect on errexit
# -use return value from ${PIPESTATUS[0]}, because ! hosed $?
! getopt --test > /dev/null
if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
    echo 'I’m sorry, `getopt --test` failed in this environment.'
    exit 1
fi

# Get the script's absolute directory path
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
echo "Script dir: $script_dir"

OPTIONS=a,s,v,m:
LONGOPTS=all,simulate,verbose,module:

# -regarding ! and PIPESTATUS see above
# -temporarily store output to be able to check for errors
# -activate quoting/enhanced mode (e.g. by writing out “--options”)
# -pass arguments only via   -- "$@"   to separate them correctly
! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    # e.g. return value is 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi
# read getopt’s output this way to handle the quoting right:
eval set -- "$PARSED"

args=("-R" "-d $script_dir" "-t $HOME")
modules=()
while true; do
    case "$1" in
        -a|--all)
            modules+=("bash" "vim" "nvim")
            shift
            ;;
        -s|--simulate)
            args+=("--no")
            shift
            ;;
        -v|--verbose)
            args+=("-vv")
            shift
            ;;
        -m|--module)
            module_path="$script_dir/$2"
            if [ -d "$module_path" ]; then
                modules+=("$2")
            else
                echo "Error: Invalid module directory: $module_path"
                exit 4
            fi
            shift 2
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Programming error"
            exit 3
            ;;
    esac
done

for module in "${modules[@]}"; do
    # Make sure that files & dirs are renamed to .bak
    module_path="$script_dir/$module"
    already_linked=true

    for item in $(find "$module_path" -maxdepth 1 -mindepth 1 -type f -exec basename {} \;); do
        target_path="$HOME/$item"

        if [ -L "$target_path" ] && [ "$(readlink -f "$target_path")" == "$(readlink -m "$module_path/$item")" ]; then
            echo "Skipping $item: Already linked to $module_path/$item"
        else
            already_linked=false
            if [ -e "$target_path" ]; then
                # If file or dir exists rename to .bak
                mv "$target_path" "$target_path.bak"
            fi
        fi
    done

    if [ "$already_linked" = false ]; then
        stow "${args[@]}" "$module"
    fi
done

