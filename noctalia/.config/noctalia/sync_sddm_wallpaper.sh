#!/bin/bash
# Script to synchronize the active Noctalia Shell wallpaper to SDDM theme directory

ACTIVE_WALLPAPER=$(qs -c noctalia-shell ipc call state all 2>/dev/null | jq -r '.state.wallpapers | to_entries[0].value' 2>/dev/null)

if [[ -f "$ACTIVE_WALLPAPER" ]]; then
    # Copy to SDDM theme directory (as active_wallpaper.png)
    sudo cp "$ACTIVE_WALLPAPER" /usr/share/sddm/themes/feathers-modern/active_wallpaper.png
    sudo chmod 644 /usr/share/sddm/themes/feathers-modern/active_wallpaper.png
    echo "Synced SDDM wallpaper: $ACTIVE_WALLPAPER"
else
    # Fallback to system default if not found
    if [[ -d "/usr/share/sddm/themes/feathers-modern" ]]; then
        sudo cp /usr/share/sddm/themes/cachyos-simplyblack/background.png /usr/share/sddm/themes/feathers-modern/active_wallpaper.png
        sudo chmod 644 /usr/share/sddm/themes/feathers-modern/active_wallpaper.png
        echo "No active wallpaper found, fell back to default background."
    fi
fi
