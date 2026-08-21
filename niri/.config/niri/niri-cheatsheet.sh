#!/usr/bin/env bash

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    notify-send -t 5000 "Niri Cheatsheet" "fzf is not installed. Please install it with 'sudo pacman -S fzf'."
    exit 1
fi

# Run the python parser and pipe to fzf with interactive settings
python3 ~/.config/niri/parse_binds.py | fzf \
    --delimiter ' │ ' \
    --with-nth=1,2 \
    --header "Niri Cheatsheet: [Enter] Copy Keybind | [Ctrl-Y] Copy Command | [Esc] Exit" \
    --layout=reverse \
    --border \
    --info=inline \
    --prompt="Search Keybinds > " \
    --preview "printf 'Keybind:  %s\nFunction: %s\nCommand:  %s\n' '{1}' '{2}' '{3}'" \
    --preview-window="bottom:4:wrap" \
    --bind "enter:execute-silent(echo -n {1} | xargs | wl-copy && notify-send -t 2000 'Niri Cheatsheet' 'Copied keybind to clipboard: {1}')+abort" \
    --bind "ctrl-y:execute-silent(echo -n {3} | wl-copy && notify-send -t 2000 'Niri Cheatsheet' 'Copied command to clipboard: {3}')"
