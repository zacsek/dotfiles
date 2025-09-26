# new linux tools
alias cat='batcat'
alias fzf='fzf --preview "batcat --color=always --style=numbers --line-range=:500 {}"'
alias dup='jdupes --recurse'
alias dua='dua i'
alias webpdf='google-chrome --headless --print-to-pdf'
alias rip='rip --graveyard $GRAVEYARD'
alias ack='printf "Use rg instead!\n"'

#alias l='exa -la --group-directories-first --icons'
#alias lt='exa -lTa --group-directories-first'
alias l='exa -la --group-directories-first --git --icons'
alias lg='exa -la --group-directories-first --git --icons -G'
alias lgit='exa -lTa --group-directories-first --git --icons --git-ignore'
alias lt='exa -lTa --group-directories-first --git --icons'

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
alias vic2='cd "/home/zacsek/.steam/steam/steamapps/common/Victoria 2"'
alias v2save='cd "/home/zacsek/.local/share/Steam/steamapps/compatdata/42960/pfx/drive_c/users/steamuser/Documents/Paradox Interactive/Victoria II/save games/"'

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

alias pip='python3 -m pip'
