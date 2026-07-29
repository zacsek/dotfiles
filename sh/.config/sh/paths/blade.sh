if [ -n "$ZSH_VERSION" ]; then
    path+=(
        ~/work/scripts
        ~/.tmux/plugins/tpm
    )
    typeset -U path
elif [ -n "$BASH_VERSION" ]; then
    export PATH=$PATH:~/work/scripts
    export PATH=$PATH:~/.tmux/plugins/tpm
fi
