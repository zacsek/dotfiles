#!/usr/bin/env bash
# ==============================================================================
# install_nix_homemanager.sh
# Universal, idempotent installer for Nix, Flakes, and Home Manager.
# Supports Arch, CachyOS, Ubuntu, Debian, and other Linux distributions.
# ==============================================================================

set -euo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# --- 1. Environment Discovery ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAKE_DIR="${SCRIPT_DIR}/nix-home-manager"

TARGET_USER="${SUDO_USER:-$USER}"
TARGET_USER="${TARGET_USER:-$(whoami)}"
TARGET_HOME="$(eval echo "~${TARGET_USER}")"

log_info "Target User: ${TARGET_USER}"
log_info "Target Home: ${TARGET_HOME}"
log_info "Flake Directory: ${FLAKE_DIR}"

if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    log_info "Detected OS: ${PRETTY_NAME:-$ID}"
fi

# --- 2. Nix Installation & Multi-User Setup ---
NIX_BIN=""
if command -v nix &>/dev/null; then
    NIX_BIN="$(command -v nix)"
elif [ -x "/nix/var/nix/profiles/default/bin/nix" ]; then
    NIX_BIN="/nix/var/nix/profiles/default/bin/nix"
elif [ -x "${TARGET_HOME}/.nix-profile/bin/nix" ]; then
    NIX_BIN="${TARGET_HOME}/.nix-profile/bin/nix"
fi

if [ -z "${NIX_BIN}" ]; then
    log_info "Nix not found on system. Installing via Determinate Systems installer..."
    if command -v curl &>/dev/null; then
        curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
    else
        log_error "curl is required to download the Nix installer. Please install curl and re-run."
        exit 1
    fi
else
    log_info "Nix binary found at ${NIX_BIN}."
    
    # If installed via system package manager (e.g. pacman on Arch/CachyOS), ensure daemon is running
    if command -v systemctl &>/dev/null; then
        if systemctl list-unit-files | grep -q "nix-daemon"; then
            if ! systemctl is-active --quiet nix-daemon.service && ! systemctl is-active --quiet nix-daemon.socket; then
                log_info "Activating system nix-daemon..."
                sudo systemctl enable --now nix-daemon.socket 2>/dev/null || sudo systemctl enable --now nix-daemon.service 2>/dev/null || true
            fi
        fi
    fi
fi

# Source Nix environment into current execution context
for profile_script in \
    "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" \
    "${TARGET_HOME}/.nix-profile/etc/profile.d/nix.sh" \
    "/etc/profile.d/nix.sh"; do
    if [ -f "$profile_script" ]; then
        log_info "Sourcing Nix environment from: ${profile_script}"
        # shellcheck disable=SC1090
        . "$profile_script"
        break
    fi
done

if ! command -v nix &>/dev/null; then
    if [ -x "/nix/var/nix/profiles/default/bin/nix" ]; then
        export PATH="/nix/var/nix/profiles/default/bin:$PATH"
    elif [ -x "${TARGET_HOME}/.nix-profile/bin/nix" ]; then
        export PATH="${TARGET_HOME}/.nix-profile/bin:$PATH"
    else
        log_error "Failed to locate 'nix' executable after installation/sourcing."
        exit 1
    fi
fi

# --- 3. Enable Flakes & Experimental Features ---
log_info "Configuring Nix experimental features (nix-command flakes)..."
USER_NIX_CONF="${TARGET_HOME}/.config/nix/nix.conf"
mkdir -p "$(dirname "${USER_NIX_CONF}")"

# Check if experimental-features is already enabled in user or system config
NEEDS_CONF=true
if [ -f "${USER_NIX_CONF}" ] && grep -q "nix-command" "${USER_NIX_CONF}"; then
    NEEDS_CONF=false
elif [ -f /etc/nix/nix.conf ] && grep -q "nix-command" /etc/nix/nix.conf; then
    NEEDS_CONF=false
fi

if [ "${NEEDS_CONF}" = true ]; then
    log_info "Adding 'experimental-features = nix-command flakes' to ${USER_NIX_CONF}..."
    echo "experimental-features = nix-command flakes" >> "${USER_NIX_CONF}"
    chown "${TARGET_USER}:" "${USER_NIX_CONF}" 2>/dev/null || true
fi

# Ensure user is in trusted-users if /etc/nix/nix.conf is writable or multi-user
if [ -w /etc/nix/nix.conf ] 2>/dev/null || sudo -n true 2>/dev/null; then
    if [ -f /etc/nix/nix.conf ] && ! grep -q "trusted-users" /etc/nix/nix.conf; then
        echo "trusted-users = root ${TARGET_USER}" | sudo tee -a /etc/nix/nix.conf >/dev/null || true
    fi
fi

# --- 4. Prepare Flake User Configuration ---
log_info "Checking Flake configuration for user '${TARGET_USER}'..."
if grep -q "\"${TARGET_USER}\" =" "${FLAKE_DIR}/flake.nix"; then
    FLAKE_TARGET=".#${TARGET_USER}"
else
    log_info "User '${TARGET_USER}' not explicitly in flake.nix, adding dynamic configuration entry..."
    # Add entry for this user to flake.nix
    sed -i "s/homeConfigurations = {/homeConfigurations = {\n        \"${TARGET_USER}\" = mkHomeConfig \"${TARGET_USER}\";/" "${FLAKE_DIR}/flake.nix"
    FLAKE_TARGET=".#${TARGET_USER}"
fi

# --- 5. Apply Home Manager Flake ---
log_info "Applying Home Manager configuration (${FLAKE_TARGET})..."
cd "${FLAKE_DIR}"

# Ensure lockfile is updated or valid
if [ ! -f flake.lock ]; then
    nix --extra-experimental-features "nix-command flakes" flake lock
fi

if command -v home-manager &>/dev/null; then
    home-manager switch --flake "${FLAKE_TARGET}" --extra-experimental-features "nix-command flakes"
else
    log_info "Bootstrapping Home Manager via nix run..."
    nix --extra-experimental-features "nix-command flakes" run github:nix-community/home-manager/release-25.05 -- switch --flake "${FLAKE_TARGET}"
fi

log_success "Home Manager configuration successfully applied!"
echo ""
echo -e "${GREEN}==============================================================================${NC}"
echo -e "${GREEN}Installation Complete!${NC}"
echo -e "To activate the environment in your current shell session, run:"
echo -e "  ${BLUE}source ~/.nix-profile/etc/profile.d/hm-session-vars.sh${NC}"
echo -e "Or simply restart your terminal / log out and log back in."
echo -e "${GREEN}==============================================================================${NC}"
