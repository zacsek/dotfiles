# CachyOS Zsh configuration imported into dotfiles
# Provides Oh-My-Zsh initialization, Powerlevel10k theme, plugins, and shell integrations
# with portable fallbacks for non-CachyOS environments.

# --- Oh-My-Zsh Initialization ---
if [[ -z "$ZSH" ]]; then
    for _omz_dir in "/usr/share/oh-my-zsh" "$HOME/.oh-my-zsh" "/usr/local/share/oh-my-zsh"; do
        if [[ -d "$_omz_dir" ]]; then
            export ZSH="$_omz_dir"
            break
        fi
    done
    unset _omz_dir
fi

# OMZ Settings
DISABLE_MAGIC_FUNCTIONS="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

# Plugins loaded via oh-my-zsh
[[ -z "${plugins[*]}" ]] && plugins=(git fzf extract)

if [[ -n "$ZSH" && -f "$ZSH/oh-my-zsh.sh" ]]; then
    source "$ZSH/oh-my-zsh.sh"
else
    # Fallback completion initialization if Oh-My-Zsh is not installed
    autoload -Uz compinit && compinit -C 2>/dev/null || compinit 2>/dev/null
fi

# --- Prompt / Theme ---
for _p10k_theme in \
    "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme" \
    "/usr/share/powerlevel10k/powerlevel10k.zsh-theme" \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme" \
    "${XDG_DATA_HOME:-$HOME/.local/share}/powerlevel10k/powerlevel10k.zsh-theme"; do
    if [[ -f "$_p10k_theme" ]]; then
        source "$_p10k_theme"
        break
    fi
done
unset _p10k_theme

# Load Powerlevel10k config if present
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

# --- Zsh Plugins (Fish-like syntax highlighting & autosuggestions) ---
for _sh_plugin in \
    "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"; do
    if [[ -f "$_sh_plugin" ]]; then
        source "$_sh_plugin"
        break
    fi
done
unset _sh_plugin

for _as_plugin in \
    "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"; do
    if [[ -f "$_as_plugin" ]]; then
        source "$_as_plugin"
        break
    fi
done
unset _as_plugin

# History Substring Search
for _hss_plugin in \
    "/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" \
    "/usr/share/zsh-history-substring-search/zsh-history-substring-search.zsh" \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" \
    "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"; do
    if [[ -f "$_hss_plugin" ]]; then
        source "$_hss_plugin"
        # Keybindings for history substring search
        bindkey '^[[A' history-substring-search-up 2>/dev/null
        bindkey '^[[B' history-substring-search-down 2>/dev/null
        break
    fi
done
unset _hss_plugin

# --- Command-Not-Found Handler ---
for _cnf_script in \
    "/usr/share/doc/pkgfile/command-not-found.zsh" \
    "/usr/share/command-not-found/command-not-found.zsh" \
    "/etc/zsh_command_not_found"; do
    if [[ -f "$_cnf_script" ]]; then
        source "$_cnf_script"
        break
    fi
done
unset _cnf_script

# --- FZF Integration ---
for _fzf_dir in "/usr/share/fzf" "$HOME/.fzf" "/usr/local/share/fzf"; do
    if [[ -d "$_fzf_dir" ]]; then
        export FZF_BASE="$_fzf_dir"
        break
    fi
done
unset _fzf_dir
