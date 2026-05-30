# new linux tools
alias cat='bat'
alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias dup='jdupes --recurse'
alias dua='dua i'
alias webpdf='google-chrome --headless --print-to-pdf'
alias rip='rip --graveyard $GRAVEYARD'

alias fzf='fzf --preview "batcat --color=always --style=numbers --line-range=:500 {}"'

alias l='exa -la --group-directories-first --git --icons'
alias lg='exa -la --group-directories-first --git --icons -G'
alias lgit='exa -lTa --group-directories-first --git --icons --git-ignore'
alias lt='exa -lTa --group-directories-first --git --icons'

# alias rm='trash-put'
# alias less='less -r'
# alias o='xdg-open'
# alias pdf='evince'
# alias img='eog'
# alias xclip='xclip -selection clipboard'
# alias inxi='inxi -Fxz'

# directory aliases
alias work='cd ~/work'
alias cv='cd ~/work/cv/sajat'
alias note='cd ~/work/notes'
alias scripts='cd ~/work/scripts'
alias vp='cd ~/work/stash/vp5'
alias vpsrc='cd ~/work/stash/vp5/src/main/scripts'
alias steam='cd ~/.steam/steam/steamapps/common'
alias sessionbuddy='cd ~/.config/google-chrome/Default/databases/chrome-extension_edacconmaakjimmfgnblocblbcdcpbko_0'
alias vic2='cd "/home/zacsek/.steam/steam/steamapps/common/Victoria 2"'
alias v2save='cd "/home/zacsek/.local/share/Steam/steamapps/compatdata/42960/pfx/drive_c/users/steamuser/Documents/Paradox Interactive/Victoria II/save games/"'
alias hoi4='cd "/home/zacsek/.steam/steam/steamapps/common/Hearts of Iron IV"'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias dfh="df -h | rg -v '/dev/loop|tmpfs|udev'"

# Old C++ stuff
alias gdb='gdb --silent'
alias tag='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q $PWD'

alias pip='python3 -m pip'
alias keybinds='vim ~/.config/niri/cfg ~/.local/share/feathers-and-flame/config-ref/deployed/niri/cfg/keybinds.kdl'

alias zshsrc='source ~/.zshrc'
