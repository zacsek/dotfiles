if [ -n "$ZSH_VERSION" ]; then
    path+=("$HOME/opt/bin" "$HOME/.cargo/bin" "$HOME/.local/bin" "$HOME/.local/share/mise/installs" "$HOME/go/bin")
    setopt localoptions nullglob
    path+=($HOME/opt/*/bin)
    path+=($HOME/opt/*/*/bin)
    typeset -U path
elif [ -n "$BASH_VERSION" ]; then
    export PATH=$PATH$( find $HOME/opt/ -maxdepth 2 -type d -name bin -printf ":%p" 2>/dev/null )
    export PATH=$PATH:~/.cargo/bin
    export PATH=$PATH:~/.local/bin
    export PATH=$PATH:~/.local/share/mise/installs
    export PATH=$PATH:~/go/bin
    export PATH=$PATH:~/opt/bin
fi
