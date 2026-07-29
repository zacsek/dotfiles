# If not running interactively, don't do anything
# set -o vi
source /etc/profile

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

[ -z "$PS1" ] && return

# Tilix drop-down terminal in Mint needs to include this
if [[ $TILIX_ID ]]; then
        source /etc/profile.d/vte.sh
fi

# add __git_ps1 function
source ~/.config/sh/ext_functions/git-completion.bash
source /usr/share/git/completion/git-prompt.sh

declare -a Configs=( "paths" "env" "configs" "completions" "funcs" "aliases" "prompt" )

# inspired from: https://rafaelc.org/posts/a-way-to-organize-your-bash-aliases-on-multiple-hosts/
for cfg in ${Configs[@]}; do
    # first include defaults
    if [ ! -d ~/.config/sh/$cfg ]; then
        . ~/.config/sh/$cfg.sh
    else
        . ~/.config/sh/$cfg/default.sh
    fi

    # host specific stuff comes later
    if [ -f ~/.config/sh/$cfg/$HOSTNAME.sh ]; then
        . ~/.config/sh/$cfg/$HOSTNAME.sh
    fi
done

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi

if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

if command -v mise &>/dev/null; then
    eval "$(mise activate bash 2>/dev/null)"
elif [ -x "$HOME/.local/bin/mise" ]; then
    eval "$("$HOME/.local/bin/mise" activate bash 2>/dev/null)"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
