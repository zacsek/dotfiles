# Dynamic executable names
if command -v batcat &>/dev/null; then
    alias bat='batcat'
elif ! command -v bat &>/dev/null; then
    alias bat='cat'
fi

if command -v eza &>/dev/null; then
    alias l='eza -lah --group-directories-first --git --icons=auto'
    alias lg='eza -lTah --group-directories-first --git --icons --git-ignore'
    alias lt='eza -lTah --group-directories-first --git --icons'
elif command -v exa &>/dev/null; then
    alias l='exa -lah --group-directories-first --git --icons'
    alias lg='exa -lTah --group-directories-first --git --icons --git-ignore'
    alias lt='exa -lTah --group-directories-first --git --icons'
else
    alias l='ls -lah --color=auto --group-directories-first'
    alias lg='ls -lah --color=auto --group-directories-first'
    alias lt='ls -lah --color=auto --group-directories-first'
fi

## QUICKIES
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias q='exit'
alias c='clear'
alias cl='c;l'
alias cat='bat'
alias o='xdg-open'
alias ll='ls -alh | less'
alias lx='ls -lhX'

## VIM
alias v="nvim -O"
alias nv="nvim -O"
alias vim="nvim -O"
alias valias="v ~/.config/sh/aliases/*"
alias vsh="pushd ~/.config/sh && (find . -type f -not -path '*/.git/*' | fzf-tmux -m | xargs nvim -O) && popd"
alias vfzf="find . -type f -not -path '*/.git/*' | fzf-tmux -m | xargs nvim -O"
alias vpaths="v ~/.config/sh/paths/*"
alias vcfg="pushd ~/.config/nvim/lua && (find . -type f -not -path '*/.git/*' | fzf-tmux -m | xargs nvim -O) && popd"
alias vrc="pushd ~/.config/nvim/lua/custom && (find . -type f -not -path '*/.git/*' | fzf-tmux -m | xargs nvim -O) && popd"

# Edit & Sourcing based on shell
if [ -n "$ZSH_VERSION" ]; then
    alias src="source ~/.zshrc"
    alias vshrc="v ~/.zshrc"
    alias vzsh="v ~/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    alias src="source ~/.bashrc"
    alias vshrc="v ~/.bashrc"
    alias vbashrc="v ~/.bashrc"
fi

## DIRS
alias cd_sh='cd ~/.config/sh'
alias cd_dot='cd ~/dotfiles'
alias cd_nvim='cd ~/.config/nvim'
alias dot="cd ~/.dotfiles"
alias opt='cd ~/opt'
alias bin='cd ~/opt/bin'

## UPDATE/UPGRADE (OS Detection)
if command -v pacman &>/dev/null; then
    alias upd='sudo pacman -Sy'
    alias upg='sudo pacman -Syu'
elif command -v apt &>/dev/null; then
    alias upd='sudo apt update && apt list --upgradable'
    alias upg='sudo apt upgrade -y'
else
    # Fallback to outputting warning if neither package manager is found
    alias upd='echo "Neither pacman nor apt found on this system."'
    alias upg='echo "Neither pacman nor apt found on this system."'
fi

## GIT
alias gita="git add"
alias gitd="git diff"
alias gits="git status"
alias gcm="git commit -m"
alias gg='gitg --all'
alias gk='gitk --all'
alias glog='git log --oneline --abbrev-commit --all --graph --decorate --color'
alias git_remote_github="git remote add github \$(gh repo view --json sshUrl --jq .sshUrl)"
alias gh_stars="gh api user/starred --paginate --template '{{range .}}{{.full_name|color \"yellow\"}} ({{timeago .updated_at}}){{\"\\n\"}}{{end}}'"

## DOCKER
alias dc='docker container'
alias di='docker image'
alias dls='docker image ls'
alias dps='docker container ps'
alias dip="docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

# RSYNC + SSH
alias rsync='rsync -avz --info=progress2'
alias ssync='rsync -avz --info=progress2 -e "ssh"'
alias scipio_up='ssh scipio -t tmux a -t upload'

# YOUTUBE
alias yta='yt-dlp --cookies-from-browser chrome --extract-audio --audio-format mp3 --audio-quality 0 -o "%(uploader)s -- %(title)s [%(id)s].%(ext)s"'
alias ytd='yt-dlp --cookies-from-browser chrome -f bestvideo+bestaudio --add-chapters --merge-output-format mkv -o "%(uploader)s -- %(title)s [%(id)s].%(ext)s"'
alias ytpl='yt-dlp --cookies-from-browser chrome -f "bv*[height<=1080]+ba/ba" --sponsorblock-remove all --embed-metadata --embed-thumbnail --add-chapters --merge-output-format mkv --yes-playlist -o "%(playlist_index)02d. %(title)s [%(id)s].%(ext)s"'
alias ytu='yt-dlp -U'

## Other tools
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias battery='upower -i `upower -e | grep "BAT"` 2>/dev/null'
alias crlf='find . -type f -exec dos2unix {} \;'
alias dfh="df -h | rg -v '/dev/loop|tmpfs|udev'"
alias diff="colordiff -uraN"
alias dns_show='resolvectl status | rg "Current DNS Server"'
alias dua='dua i'
alias dup='jdupes --recurse'
alias fd="fd -p"
alias find_txt='find . -type f -exec grep -Iq . {} \; -and -print'
alias fix_utf8='find . -type f -exec echo Fixing: {} \; -exec iconv -f utf-8 -t utf-8 -c -o {} {} \;'
alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias img='eog'
alias inxi='inxi -Fxz'
alias ipa='ip -br a'
alias less='less -r'
alias myip='curl icanhazip.com'
alias net_health='sudo dmesg | grep -i eno1 && sudo dmesg | grep -i "link up" && ls /sys/class/net/'
alias nmlog='journalctl -u NetworkManager'
alias pdf='evince'
alias pip='python3 -m pip'
alias rg='rg -i'
alias rip='rip --graveyard $GRAVEYARD'
alias temp='sensors'
alias webpdf='google-chrome --headless --print-to-pdf'
alias wttr='curl wttr.in/Esslingen'
alias xclip='xclip -selection clipboard'
alias zlu='zlib-flate -uncompress <'

## C++
alias gdb='gdb --silent'
alias tag='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q $PWD'
alias make_goals="make -p | grep -E '^[a-zA-Z0-9_-]+:([^=]|$)' | grep -v '^Makefile' |  sed 's/://' | sort"
alias ssh_pass='ssh -o PubkeyAuthentication=no -o PreferredAuthentications=password'
