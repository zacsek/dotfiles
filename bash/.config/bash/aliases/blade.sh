# new linux tools
alias cat='bat'
alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias dup='jdupes --recurse'
alias dua='dua i'
alias webpdf='google-chrome --headless --print-to-pdf'
alias rip='rip --graveyard $GRAVEYARD'
alias ack='printf "Use rg instead!\n"'


#alias l='exa -la --group-directories-first --icons'
#alias lt='exa -lTa --group-directories-first'
alias l='exa -la --group-directories-first --git --icons'
alias lt='exa -lTa --group-directories-first --git'

NVIM_ALT='NVIM_APPNAME=nvim-chad nvim'

alias v='view'
alias nv="$NVIM_ALT -O"
alias nvim="$NVIM_ALT -O"

alias vim="$NVIM_ALT -O"
# alias vimfzf="$NVIM_ALT -O `fzf -e -m`"
alias vimrc="$NVIM_ALT -O ~/.config/nvim/init.vim ~/.config/nvim/plugin/02_maps.vim"
alias vbashrc="$NVIM_ALT -O ~/.bashrc"
alias valias="$NVIM_ALT -O ~/.config/bash/aliases/*"

alias rm='trash-put'
alias less='less -r'

alias o='xdg-open'
alias pdf='evince'
alias img='eog'
alias xclip='xclip -selection clipboard'
alias inxi='inxi -Fxz'
alias wifipass='echo -n "1@8tUrorooDi6)7" | xclip -selection clipboard'

# directory aliases
alias work='cd ~/work'
alias note='cd ~/work/notes'
alias scripts='cd ~/work/scripts'
alias vp='cd ~/work/stash/vp5'
alias vpsrc='cd ~/work/stash/vp5/src/main/scripts'
alias steam='cd ~/.steam/steam/steamapps/common'
alias sessionbuddy='cd ~/.config/google-chrome/Default/databases/chrome-extension_edacconmaakjimmfgnblocblbcdcpbko_0'
alias vic2='cd "~/.PlayOnLinux/wineprefix/Steam/drive_c/Steam/steamapps/common/Victoria 2"'

# tmux commands
alias scipio_up='ssh scipio -t tmux a -t upload'

# dubious commands (almost) never used
alias dns_show='resolvectl status | rg "Current DNS Server"'
alias zlu='zlib-flate -uncompress <'
alias wttr='curl wttr.in/Esslingen'
alias nmlog='journalctl -u NetworkManager'
alias bt_battery_freebuds='bluetooth_battery FC:94:35:C4:26:5B'
alias fix_utf8='find . -type f -exec echo Fixing: {} \; -exec iconv -f utf-8 -t utf-8 -c -o {} {} \;'
alias find_txt='find . -type f -exec grep -Iq . {} \; -and -print'
alias battery='upower -i `upower -e | grep "BAT"`'
alias temp='sensors'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias dfh="df -h | rg -v '/dev/loop|tmpfs|udev'"

# Old C++ stuff
alias gdb='gdb --silent'
alias tag='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q $PWD'

# Convert dos to unix line endings
alias crlf='find . -type f -exec dos2unix {} \;'

alias git_remote_github="git remote add github \$(gh repo view --json sshUrl --jq .sshUrl)"

alias pip='python3 -m pip'
