alias c='clear'
alias q='exit'

alias cat='batcat'
alias fzf='fzf --preview "batcat --color=always --style=numbers --line-range=:500 {}"'
#alias fzf='fzf --preview "cat --color=always --style=numbers --line-range=:500 {}"'

alias dup='jdupes --recurse'
alias ack='printf "Use rg instead!\n"'
alias rg='rg -i'

alias cd_nvim='cd ~/.config/nvim'
alias cd_bash='cd ~/.config/bash'
alias cd_dot='cd ~/dotfiles'

alias ls='ls --color --group-directories-first'
alias l='exa -la --group-directories-first --icons'
#alias l='exa -la --group-directories-first --git --icons'
alias lt='exa -lTa --group-directories-first'
#alias lt='exa -lTa --group-directories-first --git'
#alias l='ls -alh'
#alias lt='ls -alth'
alias ll='ls -alh|less'
alias lx='ls -lhX'
alias cl='c;l'

alias v="nvim -O"
alias nv="nvim -O"
alias vim='nvim -O'
alias vf="find . -type f -not -path '*/.git/*' | fzf-tmux -m | xargs nvim -O"
alias vrc="pushd ~/.config/nvim/lua/custom && (find . -type f -not -path '*/.git/*' | fzf-tmux -m | xargs nvim -O) && popd"
alias valias="nvim -O ~/.config/bash/aliases/*"
alias vpath='nvim -O ~/.config/bash/paths/*'
alias vbash="nvim -O ~/.bashrc"
alias bashsrc='source ~/.bashrc'

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
alias git_remote_github="git remote add github \$(gh repo view --json sshUrl --jq .sshUrl)"

# Convert dos to unix line endings
alias crlf='find . -type f -exec dos2unix {} \;'

# directory aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias opt='cd ~/opt'
alias bin='cd ~/opt/bin'

alias ytd='yt-dlp -f bestvideo+bestaudio --add-chapters --merge-output-format mkv -o "%(uploader)s -- %(title)s [%(id)s].%(ext)s"'
alias ytpl='yt-dlp -f "bv*[height<=1080]+ba/ba" --sponsorblock-remove all --embed-metadata --embed-thumbnail --add-chapters --merge-output-format mkv --yes-playlist -o "%(playlist_index)02d. %(title)s [%(id)s].%(ext)s"'
alias yta='yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 -o "%(uploader)s -- %(title)s [%(id)s].%(ext)s"'

# List Goals of a Makefile:
alias make_goals="make -p | grep -E '^[a-zA-Z0-9_-]+:([^=]|$)' | grep -v '^Makefile' |  sed 's/://' | sort"

alias myip='curl icanhazip.com'

alias upd='sudo apt update && apt list --upgradable'
alias upg='sudo apt upgrade -y'

alias witch='function _wfollow() { local file=$(which $1); while [ -L "$file" ]; do echo -n "$file -> "; file=$(readlink -f "$file"); done; echo $file; }; _wfollow'
alias pack='function _dpkgs() { local file=$(which $1); dpkg -S $file; }; _dpkgs'

alias gh_stars="gh api user/starred --paginate --template '{{range .}}{{.full_name|color \"yellow\"}} ({{timeago .updated_at}}){{\"\\n\"}}{{end}}'"

alias print='function _figlolprint() { local msg=$1; figlet $1 | lolcat --seed 60; }; _figlolprint'
alias fd="fd -p"
