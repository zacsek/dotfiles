# Load vcs_info and colors
autoload -Uz vcs_info
autoload -U colors && colors

# Set a hook to update vcs_info before each prompt
precmd() {
  vcs_info
}

# Enable checking for version control system
zstyle ":vcs_info:*" enable git
# Format for git branch
zstyle ":vcs_info:git:*" formats "(%b)"

# Prompt
setopt PROMPT_SUBST

PS1=""

# Time
PS1+="%{$fg[gray]%}[%{$fg[red]%}%D{%T}%{$fg[gray]%}]%{$reset_color%} "

# User@host (only on SSH)
if [[ -n $SSH_CLIENT ]]; then
  PS1+="%{$fg[yellow]%}%n@%m%{$reset_color%} "
fi

# Working directory
PS1+="%{$fg[green]%}%~%{$reset_color%}"

# Git info
PS1+="%{$fg[blue]%}	extvariable{vcs_info_msg_0_}%{$reset_color%} "

# Prompt symbol
PS1+="%(?.%F{green}.%F{red})%# %f"

PROMPT=$PS1
