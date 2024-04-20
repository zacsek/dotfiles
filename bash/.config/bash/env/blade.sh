JAVA=$(readlink -qf `which java`)
export JAVA_HOME=${JAVA%/bin/*}
export GRAVEYARD=/home/zacsek/.local/share/Trash
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
export OLLAMA_MODELS=/home/zacsek/.ollama/models
