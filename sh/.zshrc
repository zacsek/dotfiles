# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Clean up any conflicting aliases from the environment
unalias print 2>/dev/null

# Source imported CachyOS / Zsh environment configuration
if [[ -f "$HOME/.config/sh/cachyos.zsh" ]]; then
    source "$HOME/.config/sh/cachyos.zsh"
elif [[ -f "/usr/share/cachyos-zsh-config/cachyos-config.zsh" ]]; then
    source "/usr/share/cachyos-zsh-config/cachyos-config.zsh"
fi

Configs=( "paths" "env" "configs" "completions" "funcs" "aliases" "prompt" )

# Ensure HOSTNAME is set (zsh natively uses HOST instead of HOSTNAME)
HOSTNAME="${HOSTNAME:-$HOST}"

# inspired from: https://rafaelc.org/posts/a-way-to-organize-your-bash-aliases-on-multiple-hosts/
for cfg in "${Configs[@]}"; do
    # first include defaults
    if [[ ! -d "$HOME/.config/sh/$cfg" ]]; then
        [[ -f "$HOME/.config/sh/$cfg.sh" ]] && source "$HOME/.config/sh/$cfg.sh"
    else
        [[ -f "$HOME/.config/sh/$cfg/default.sh" ]] && source "$HOME/.config/sh/$cfg/default.sh"
    fi

    # host specific stuff comes later
    if [[ -f "$HOME/.config/sh/$cfg/$HOSTNAME.sh" ]]; then
        source "$HOME/.config/sh/$cfg/$HOSTNAME.sh"
    fi
done

# Forgejo CLI completion
if command -v fj &>/dev/null; then
  source <(fj completion zsh)
fi

if command -v mise &>/dev/null; then
    eval "$(mise activate zsh 2>/dev/null)"
elif [ -x "$HOME/.local/bin/mise" ]; then
    eval "$("$HOME/.local/bin/mise" activate zsh 2>/dev/null)"
fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

if command -v direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

if [ -f "$HOME/.atuin/bin/env" ]; then
    . "$HOME/.atuin/bin/env"
fi

# Atuin only on Ctrl-R; Up/Down keep zsh's own (per-terminal) history
if command -v atuin &>/dev/null; then
    eval "$(atuin init zsh --disable-up-arrow)"
    if (( ${+widgets[history-substring-search-up]} )); then
        bindkey '^[[A' history-substring-search-up
        bindkey '^[OA' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        bindkey '^[OB' history-substring-search-down
    fi
fi

