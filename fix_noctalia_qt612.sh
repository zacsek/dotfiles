#!/usr/bin/env bash
# ==============================================================================
# fix_noctalia_qt612.sh
# Fixes invisible/black text & icons in Noctalia v4 (QuickShell) on Qt 6.12+
# Root cause: Qt 6.12 added a built-in QML global `Color` (QQuickColor), which
# shadows Noctalia Shell's `Commons/Color.qml` singleton.
# ==============================================================================

set -euo pipefail

SYS_SHELL_DIR="/etc/xdg/quickshell/noctalia-shell"
USER_SHELL_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/quickshell/noctalia-shell"
USER_PLUGINS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/noctalia/plugins"

echo "==> Starting Noctalia v4 Qt 6.12+ Color Collision Fix..."

# 1. Copy system shell config to user override directory if not already present
if [[ ! -d "$SYS_SHELL_DIR" ]]; then
    echo "ERROR: System Noctalia shell not found at $SYS_SHELL_DIR" >&2
    exit 1
fi

mkdir -p "$(dirname "$USER_SHELL_DIR")"
if [[ -d "$USER_SHELL_DIR" ]]; then
    BACKUP_DIR="${USER_SHELL_DIR}.bak.$(date +%s)"
    echo "==> Backing up existing $USER_SHELL_DIR to $BACKUP_DIR"
    mv "$USER_SHELL_DIR" "$BACKUP_DIR"
fi

echo "==> Copying $SYS_SHELL_DIR to $USER_SHELL_DIR..."
cp -r "$SYS_SHELL_DIR" "$USER_SHELL_DIR"

# 2. Rename Commons/Color.qml -> Commons/NColor.qml
if [[ -f "$USER_SHELL_DIR/Commons/Color.qml" ]]; then
    echo "==> Renaming Commons/Color.qml -> Commons/NColor.qml..."
    mv "$USER_SHELL_DIR/Commons/Color.qml" "$USER_SHELL_DIR/Commons/NColor.qml"
fi

# Update qmldir if present in Commons
if [[ -f "$USER_SHELL_DIR/Commons/qmldir" ]]; then
    sed -i 's/\bColor\b/NColor/g' "$USER_SHELL_DIR/Commons/qmldir"
fi

# 3. Replace all `Color.` references with `NColor.` in user shell and plugins
echo "==> Patching QML/JS files in $USER_SHELL_DIR..."
find -L "$USER_SHELL_DIR" -type f \( -name "*.qml" -o -name "*.js" \) \
    -exec sed -i -E 's/\bColor\./NColor./g' {} +

if [[ -d "$USER_PLUGINS_DIR" ]]; then
    echo "==> Patching QML/JS files in $USER_PLUGINS_DIR..."
    find -L "$USER_PLUGINS_DIR" -type f \( -name "*.qml" -o -name "*.js" \) \
        -exec sed -i -E 's/\bColor\./NColor./g' {} +
fi

# 4. Restart the QuickShell Noctalia daemon
echo "==> Restarting Noctalia bar..."
pkill -f "qs.*noctalia-shell" || true
while pgrep -f "qs.*noctalia-shell" >/dev/null 2>&1; do
    sleep 0.2
done
sleep 0.5
nohup qs -d -c noctalia-shell >/dev/null 2>&1 &

echo "==> Done! Noctalia v4 bar should now render with normal colors."
