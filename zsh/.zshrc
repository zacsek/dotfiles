# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

# Tilix drop-down terminal in Mint needs to include this
if [[ $TILIX_ID ]]; then
    source /etc/profile.d/vte.sh
fi

# ZSH options
setopt autocd
setopt extendedglob
setopt notify
setopt prompt_subst

# Load and initialize the completion system
autoload -U compinit
compinit -i

# Load and initialize git completion
autoload -U +X bashcompinit && bashcompinit
source /home/zacsek/dotfiles/bash/.config/bash/ext_functions/git-completion.bash

# Set up the prompt
autoload -U promptinit
promptinit

# Source configuration files
CONFIG_DIR="$HOME/.config/zsh"
declare -a Configs=( "paths" "env" "configs" "completions" "funcs" "aliases" "prompt" )

for cfg in ${Configs[@]}; do
    # first include defaults
    if [ ! -d "$CONFIG_DIR/$cfg" ]; then
        source "$CONFIG_DIR/$cfg.sh"
    else
        source "$CONFIG_DIR/$cfg/default.sh"
    fi

    # host specific stuff comes later
    if [ -f "$CONFIG_DIR/$cfg/$HOSTNAME.sh" ]; then
        source "$CONFIG_DIR/$cfg/$HOSTNAME.sh"
    fi
done

# Initialize zoxide, direnv, and mise
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(/home/zacsek/.local/bin/mise activate zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
