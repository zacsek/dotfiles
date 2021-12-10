alias l='exa -l --group-directories-first --git --icons'
alias lt='exa -lT --group-directories-first --git'

alias v='view'
alias vim='nvim -O'
alias nvimrc='nvim ~/.config/nvim/init.vim'
alias gvim='gvim -p'
alias vimfzf='nvim -O `fzf -e -m`'

alias rm='trash-put'
alias less='less -r'

alias o='gnome-open'
alias pdf='evince'
alias img='eog'
alias xclip='xclip -selection clipboard'
alias inxi='inxi -Fxz'
alias wifipass='echo -n "1@8tUrorooDi6)7" | xclip -selection clipboard'

# directory aliases
alias work='cd ~/work'
alias scripts='cd ~/work/scripts'
alias vp='cd ~/work/stash/vp5'
alias vpsrc='cd ~/work/stash/vp5/src/main/scripts'
alias steam='cd ~/.steam/steam/steamapps/common'
alias sessionbuddy='cd ~/.config/google-chrome/Default/databases/chrome-extension_edacconmaakjimmfgnblocblbcdcpbko_0'
alias vic2='cd "~/.PlayOnLinux/wineprefix/Steam/drive_c/Steam/steamapps/common/Victoria 2"'

# tmux commands
alias scipio_up='ssh scipio -t tmux a -t upload'

# dubious commands (almost) never used
alias dns_show='systemd-resolve --status'
alias zlu='zlib-flate -uncompress <'
alias wttr='curl wttr.in/Esslingen'
alias nmlog='journalctl -u NetworkManager'
alias bt_battery_freebuds='bluetooth_battery FC:94:35:C4:26:5B'
alias fix_utf8='find . -type f -exec echo Fixing: {} \; -exec iconv -f utf-8 -t utf-8 -c -o {} {} \;'
alias find_txt='find . -type f -exec grep -Iq . {} \; -and -print'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Old C++ stuff
alias gdb='gdb --silent'
alias tag='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q $PWD'

