
#gem_vim() { vim -O lib/vp5/$1.rb spec/$1_spec.rb; }
#export -f gem_vim

#wait_on_file() { echo $(dirname $1); inotifywait -e close_write -m $(dirname $1) | while read -r path action file; do if [[ "$file" = "$1" ]]; then eval $2; fi; done	}

mkcd()
{
	mkdir -p -- "$1" &&
		cd -P -- "$1"
}

