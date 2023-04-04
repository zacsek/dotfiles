alias c='clear'
alias q='exit'

alias ls='ls --color --group-directories-first'
alias l='ls -alh'
alias ll='ls -alh|less'
alias lt='ls -alth'
alias lx='ls -lhX'
alias cl='c;l'

alias vim='vim -O'
alias vimrc='vim ~/.vimrc'

alias docki='docker image'
alias dockc='docker container'
alias dockls='docker image ls'
alias dockps='docker container ps'
# Get IP address of container: dockip <container_name_or_id>
alias dockip="docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

alias diff="colordiff -uraN"
alias gits="git status"
alias gitd="git difftool -d"
alias gitk='gitk --all'
alias gitg='gitg --all'
alias gitlog='git log --oneline --abbrev-commit --all --graph --decorate --color'

# directory aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias opt='cd ~/opt'
alias bin='cd ~/opt/bin'

alias ytd='yt-dlp -f bestvideo+bestaudio --add-chapters --merge-output-format mkv -o "%(uploader)s -- %(title)s [%(id)s].%(ext)s"'
alias yta='yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 -o "%(uploader)s -- %(title)s [%(id)s].%(ext)s"'

# List Goals of a Makefile:
alias make_goals="make -p | grep -E '^[a-zA-Z0-9_-]+:([^=]|$)' | grep -v '^Makefile' |  sed 's/://' | sort"

