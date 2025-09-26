# History settings
setopt HIST_IGNORE_ALL_DUPS  # Ignore duplicates
setopt HIST_IGNORE_SPACE     # Ignore commands starting with a space
setopt APPEND_HISTORY        # Append to history file

export HISTSIZE=1000
export SAVEHIST=2000
export HISTIGNORE="&:[ ]*:c:l:q:..*" # Zsh has a slightly different pattern syntax

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# LESS Termcap
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# CCache
export USE_CCACHE=1

# ulimit
ulimit -c unlimited

# No bell
unsetopt BEEP
