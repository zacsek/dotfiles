export DOTFILES=~/.dotfiles
export ANSIBLE_NOCOWS=1
export MANROFFOPT="-c"
export MISE_STATUS_MESSAGE_MISSING_TOOLS=never


if [ -n "$ZSH_VERSION" ]; then
    # Save history after each command
    setopt INC_APPEND_HISTORY
elif [ -n "$BASH_VERSION" ]; then
    export PROMPT_COMMAND='history -a' # save history after each command, so multiple terminals are consistent
    export EDITOR="/usr/bin/vim"
fi
