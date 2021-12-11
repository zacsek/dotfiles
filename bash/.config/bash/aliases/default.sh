alias c='clear'
alias q='exit'
alias cl='clear;ls -alh'

alias l='ls -alh'
alias ll='ls -alh|less'
alias lt='ls -alth'
alias lx='ls -lhX'

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
