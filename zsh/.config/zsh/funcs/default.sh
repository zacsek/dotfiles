mkcd()
{
	mkdir -p -- "$1" &&
		cd -P -- "$1"
}

help() {
    "$@" --help 2>&1 | bat --plain --language=help
}

tailf() {
    tail -f "$1" | bat --paging=never -l log
}
unalias witch 2>/dev/null
witch() {
  local file=$(which $1)
  while [ -L "$file" ]; do
    echo -n "$file -> "
    file=$(readlink -f "$file")
  done
  echo $file
}
unalias pack 2>/dev/null
pack() {
  local file=$(which $1)
  dpkg -S $file
}