# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

Configs=( "paths" "env" "configs" "completions" "funcs" "aliases" )

# Ensure HOSTNAME is set (zsh natively uses HOST instead of HOSTNAME)
HOSTNAME="${HOSTNAME:-$HOST}"

# inspired from: https://rafaelc.org/posts/a-way-to-organize-your-bash-aliases-on-multiple-hosts/
for cfg in "${Configs[@]}"; do
    # first include defaults
    if [[ ! -d "$HOME/.config/bash/$cfg" ]]; then
        [[ -f "$HOME/.config/bash/$cfg.sh" ]] && source "$HOME/.config/bash/$cfg.sh"
    else
        [[ -f "$HOME/.config/bash/$cfg/default.sh" ]] && source "$HOME/.config/bash/$cfg/default.sh"
    fi

    # host specific stuff comes later
    if [[ -f "$HOME/.config/bash/$cfg/$HOSTNAME.sh" ]]; then
        source "$HOME/.config/bash/$cfg/$HOSTNAME.sh"
    fi
done

eval "$(/home/zacsek/.local/bin/mise activate zsh)"
