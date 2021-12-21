JAVA=$(readlink -qf `which java`)
export JAVA_HOME=${JAVA%/bin/*}

