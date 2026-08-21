#!/bin/bash

# Process identifier for the floating btop window
proc_pattern="alacritty --class btop-floating"

if pgrep -f "$proc_pattern" >/dev/null; then
    pkill -f "$proc_pattern"
else
    alacritty --class "btop-floating" -e btop &
fi
