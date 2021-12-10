# If not running interactively, don't do anything
source /etc/profile

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

[ -z "$PS1" ] && return

# Tilix drop-down terminal in Mint needs to include this
if [[ $TILIX_ID ]]; then
        source /etc/profile.d/vte.sh
fi

declare -a Configs=("aliases" "completions" "configs" "env" "funcs" "paths" "prompt")

for cfg in ${Configs[@]}; do
    # first include defaults
    if [! -d ~/.config/bash/$cfg ]; then
        . ~/.config/bash/$cfg.sh
    else
        . ~/.config/bash/$cfg/default.sh
    fi

    # host specific stuff comes later
    if [ -f ~/.config/bash/$cfg/$HOSTNAME.sh ]; then
        . ~/.config/bash/$cfg/$HOSTNAME.sh
    fi
done
# inspired from: https://rafaelc.org/posts/a-way-to-organize-your-bash-aliases-on-multiple-hosts/