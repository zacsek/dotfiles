export JAVA=$(readlink -qf "$(command -v java)" 2>/dev/null)
if [ -n "$JAVA" ] && [ -z "$JAVA_HOME" ] && [ "${JAVA##*/}" = java ]; then
    export JAVA_HOME=${JAVA%/bin/*}
fi
export GRAVEYARD=/home/zacsek/.local/share/Trash

if command -v batcat &>/dev/null; then
    export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
else
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

export OLLAMA_MODELS=/home/zacsek/.ollama/models
export EDITOR="nvim"
