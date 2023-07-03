alias c='clear'
alias q='exit'

alias l='exa -la --group-directories-first --icons'
alias lt='exa -lTa --group-directories-first'

alias ls='ls --color --group-directories-first'
#alias l='ls -alh'
#alias ll='ls -alh|less'
#alias lt='ls -alth'
alias lx='ls -lhX'
alias cl='c;l'

#alias vim='nvim -O'
#alias vim_alias='nvim -O ~/.config/bash/aliases/*'
#alias vim_path='nvim -O ~/.config/bash/paths/*'
#alias vim_bash='nvim -O ~/.bashrc'
#alias vimrc='vim ~/.config/nvim/init.vim'

alias docki='docker image'
alias dockc='docker container'
alias dockls='docker image ls'
alias dockps='docker container ps'
# Get IP address of container: dockip <container_name_or_id>
alias dockip="docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

alias diff="colordiff -uraN"
alias gits="git status"
#alias gitd="git difftool -d"
alias gitd="git diff"
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

alias myip='curl icanhazip.com'

alias upd='sudo apt update && apt list --upgradable'
alias upg='sudo apt upgrade -y'

alias cat='batcat'
alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias dup='jdupes --recurse'
alias ack='printf "Use rg instead!\n"'
#alias l='exa -la --group-directories-first --git --icons'
#alias lt='exa -lTa --group-directories-first --git'

alias v='view'
alias vim='nvim -O'
alias vim_fzf='nvim -O `fzf -e -m`'
alias vim_rc='nvim -O ~/.config/nvim/init.vim ~/.config/nvim/plugin/02_maps.vim'
alias vim_bash='nvim -O ~/.bashrc'
alias vim_path='nvim -O ~/.config/bash/paths/*'
alias vim_alias='nvim -O ~/.config/bash/aliases/*'
alias src_bash='source ~/.bashrc'
alias bashsrc='source ~/.bashrc'

alias cd_nvim='cd ~/.config/nvim'
alias cd_bash='cd ~/.config/bash'
alias cd_dot='cd ~/dotfiles'
