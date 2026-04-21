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

# Checks if an item is already stowed or resides within a stowed directory.
# Usage: is_already_stowed /path/to/item [sudo]
is_already_stowed() {
    local item_path="$1"
    local use_sudo="${2:-}"
    local real_path
    
    # If the item doesn't exist, it's not stowed.
    if ! $use_sudo test -e "$item_path" && ! $use_sudo test -L "$item_path"; then
        return 1
    fi

    # Use readlink -f to get the absolute physical path.
    real_path=$($use_sudo readlink -f "$item_path")
    
    # If the real path starts with DOTFILES_DIR, it's stowed.
    if [[ "$real_path" == "$DOTFILES_DIR"* ]]; then
        return 0 # True
    fi
    return 1 # False
}

# Backs up a given path if it exists and isn't already stowed.
# Usage: backup_item /path/to/item [sudo]
backup_item() {
    local item_path="$1"
    local use_sudo="${2:-}"
    
    # CRITICAL SAFETY: Never back up something that is already in the dotfiles repo.
    if is_already_stowed "$item_path" "$use_sudo"; then
        echo "Skipping backup: $item_path is already linked to dotfiles."
        return
    fi

    if $use_sudo test -e "$item_path" || $use_sudo test -L "$item_path"; then
        local backup_path="${item_path}_backup_$DATE"
        local counter=1
        while $use_sudo test -e "$backup_path" || $use_sudo test -L "$backup_path"; do
            backup_path="${item_path}_backup_${DATE}_$counter"
            ((counter++))
        done

        echo "Backing up: $item_path to $backup_path ${use_sudo:+(as root)}"
        $use_sudo mv "$item_path" "$backup_path"
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

        # 1. Directory-level backup strategy:
        # Find directories in the package and check if they exist as real directories in the target.
        find "$pkg" -type d | sed "s|^$pkg/||" | sort -r | while read -r dir; do
            [ "$dir" == "." ] && [ -z "$dir" ] && continue
            
            # Skip common "container" directories that should not be symlinked as a whole
            case "$dir" in
                .config|.local|.local/share|.cache|.ssh|.gnupg) continue ;;
            esac

            local target_path="$target_home/$dir"
            
            # If it's a real directory and NOT already stowed (nor inside a stowed tree)
            if $use_sudo test -d "$target_path" && ! $use_sudo test -L "$target_path"; then
                if ! is_already_stowed "$target_path" "$use_sudo"; then
                     backup_item "$target_path" "$use_sudo"
                fi
            fi
        done

        # 2. File-level conflict backup:
        # Catch any remaining conflicts reported by stow (mostly individual files).
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
