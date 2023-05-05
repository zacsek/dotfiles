JAVA=$(readlink -qf `which java`)
export JAVA_HOME=${JAVA%/bin/*}
export GRAVEYARD=/home/zacsek/.local/share/Trash
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
