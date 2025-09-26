#!/bin/bash
set -e # Exit on error

# This script dynamically discovers and stows dotfile packages for both the
# current user and the root user, backing up any conflicting files.

# --- Configuration ---
DATE=$(date +%Y-%m-%d)
# Assumes the script is run from the root of the dotfiles repository
DOTFILES_DIR=$(pwd)
USER_HOME="$HOME"
ROOT_HOME="/root"

# --- Backup Functions ---

# Backs up a given path if it exists.
# Usage: backup_item /path/to/item
backup_item() {
    local item_path="$1"
    if [ -e "$item_path" ] || [ -L "$item_path" ]; then
        echo "Backing up: $item_path"
        mv "$item_path" "${item_path}_backup_$DATE"
    fi
}

# Backs up a given path as root if it exists.
# Usage: sudo_backup_item /path/to/item
sudo_backup_item() {
    local item_path="$1"
    if sudo test -e "$item_path" || sudo test -L "$item_path"; then
        echo "Backing up: $item_path (as root)"
        sudo mv "$item_path" "${item_path}_backup_$DATE"
    fi
}

# --- Main Execution ---

# Find all directories in the current path to use as stow packages, excluding .git
PACKAGES=$(find . -maxdepth 1 -mindepth 1 -type d -not -path './.git' | sed 's|^./||')

if [ -z "$PACKAGES" ]; then
    echo "No packages found to stow. Exiting."
    exit 1
fi

echo "Found packages to stow: $PACKAGES"
echo ""

# --- Process for the current user ---
echo "### Processing for user: $USER ###"
for pkg in $PACKAGES; do
    echo "--- Analyzing package: $pkg ---"
    
    # Use stow's dry run (-n) to find what items would be linked.
    # For each of those items, back it up if it already exists.
    stow -n -t "$USER_HOME" "$pkg" 2>&1 | while read -r line; do
        # We are interested in lines indicating a link, like "LINK: .vimrc => ..."
        if [[ "$line" == "LINK: "* ]]; then
            # Extract the target file/dir name. It's the word after "LINK: "
            target_name=$(echo "$line" | sed -n 's/^LINK: \([^ ]*\).*/\1/p')
            if [ -n "$target_name" ]; then
                backup_item "$USER_HOME/$target_name"
            fi
        fi
    done
    
    echo "Stowing '$pkg' for the current user..."
    stow -t "$USER_HOME" "$pkg"
done

echo ""
echo "### Processing for root user ###"
echo "You may be prompted for your password."

# --- Process for the root user ---
for pkg in $PACKAGES; do
    echo "--- Analyzing package for root: $pkg ---"

    # Dry-run stow with sudo to find conflicts in root's home directory.
    sudo stow -n -t "$ROOT_HOME" "$pkg" 2>&1 | while read -r line; do
        if [[ "$line" == "LINK: "* ]]; then
            target_name=$(echo "$line" | sed -n 's/^LINK: \([^ ]*\).*/\1/p')
            if [ -n "$target_name" ]; then
                sudo_backup_item "$ROOT_HOME/$target_name"
            fi
        fi
    done

    echo "Stowing '$pkg' for the root user..."
    sudo stow -t "$ROOT_HOME" "$pkg"
done

echo ""
echo "Process complete."
