#!/bin/bash
set -e # Exit on error

# This script dynamically discovers and stows dotfile packages for both the
# current user and the root user, backing up any conflicting files.

# --- Configuration ---
DATE=$(date +%Y-%m-%d)

# --- Argument Parsing ---
INSTALL_FOR_ROOT=false
if [ "$1" == "--root" ]; then
  INSTALL_FOR_ROOT=true
fi
# Assumes the script is run from the root of the dotfiles repository
DOTFILES_DIR=$(readlink -f "$(pwd)")
USER_HOME="$HOME"
ROOT_HOME="/root"

# --- Reusable Functions ---

# Checks if an item is already a symlink into the dotfiles directory.
# Usage: is_already_stowed /path/to/item [sudo]
is_already_stowed() {
    local item_path="$1"
    local use_sudo="${2:-}"
    local target

    if $use_sudo test -L "$item_path"; then
        target=$($use_sudo readlink -f "$item_path")
        if [[ "$target" == "$DOTFILES_DIR"* ]]; then
            return 0 # True
        fi
    fi
    return 1 # False
}

# Backs up a given path if it exists and isn't already stowed.
# Usage: backup_item /path/to/item [sudo]
backup_item() {
    local item_path="$1"
    local use_sudo="${2:-}"

    if is_already_stowed "$item_path" "$use_sudo"; then
        echo "Skipping backup: $item_path is already a symlink to dotfiles."
        return
    fi

    if $use_sudo test -e "$item_path" || $use_sudo test -L "$item_path"; then
        echo "Backing up: $item_path ${use_sudo:+(as root)}"
        $use_sudo mv "$item_path" "${item_path}_backup_$DATE"
    fi
}

# Processes a list of packages for a specific home directory.
# Usage: process_packages /home/path [sudo]
process_packages() {
    local target_home="$1"
    local use_sudo="${2:-}"
    local user_name
    user_name=$($use_sudo whoami)

    echo "### Processing for user: $user_name ###"
    for pkg in $PACKAGES; do
        echo "--- Analyzing package: $pkg ---"

        # Find conflicting files by capturing stow's dry-run error output.
        $use_sudo stow -n -t "$target_home" "$pkg" 2>&1 >/dev/null | grep 'existing target' | \
        sed -E 's/.*existing target (is not a symlink: )?//; s/ since.*//' | \
        while read -r conflict; do
            [ -z "$conflict" ] && continue
            conflict=$(echo "$conflict" | xargs)
            backup_item "$target_home/$conflict" "$use_sudo"
        done

        echo "Stowing '$pkg' for $user_name..."
        $use_sudo stow -t "$target_home" "$pkg"
    done
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

# Process for the current user
process_packages "$USER_HOME"

# Process for the root user (optional)
if [ "$INSTALL_FOR_ROOT" = true ]; then
    echo ""
    echo "You may be prompted for your password for root installation."
    process_packages "$ROOT_HOME" "sudo"
else
    echo ""
    echo "Skipping root user installation."
fi

echo ""
echo "Process complete."
