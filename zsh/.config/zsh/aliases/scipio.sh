alias tmux_up='tmux new -s upload'
alias yt_playlist='youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s" -r 10M -R 3'
alias rsync_home='rsync --rsync-path=/bin/rsync -avz -e "ssh" --progress --stats /var/lib/transmission-daemon/downloads/ diskstation:/volumeUSB1/usbshare/'
alias rsync_youtube='rsync --rsync-path=/bin/rsync -avz -e "ssh" --progress --stats /root/youtube/ diskstation:/volumeUSB1/usbshare/__Youtube__/'

