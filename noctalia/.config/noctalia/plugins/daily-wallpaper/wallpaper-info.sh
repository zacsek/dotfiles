#!/usr/bin/env bash
# Show title/description of the current daily wallpaper from its JSON sidecar.

output="$(niri msg -j focused-output | jq -r '.name')"
wallpaper="$(qs -c noctalia-shell ipc call wallpaper get "$output")"
meta="${wallpaper%.*}.json"

if [[ ! -f $meta ]]; then
	notify-send -a "Wallpaper" "No description available" "$(basename "$wallpaper")"
	exit 0
fi

title="$(jq -r '.title' "$meta")"
copyright="$(jq -r '.copyright' "$meta")"
link="$(jq -r '.link' "$meta")"

action="$(notify-send -a "Wallpaper" --action=open="Learn more" "$title" "$copyright")"
[[ $action == open && -n $link ]] && xdg-open "$link"
