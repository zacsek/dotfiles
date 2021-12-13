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

args=("-R" "-t$HOME")
modules=()
while true; do
    case "$1" in
        -a|--all)
            #args+=( "$(find . -maxdepth 1 \( ! -name '.*' \) -type d | sed 's/.\///'| xargs)" )
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
            modules+=("$2")
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

for m in ${modules[@]}; do
    stow "${args[@]}" $m
done

