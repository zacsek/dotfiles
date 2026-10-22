# Instructions for AGY: Fix Noctalia v4 Invisible/Dark Icons & Text (Qt 6.12+ Regression)

## Problem Context
After updating the system to **Qt 6.12+** (`qt6-declarative >= 6.12.0`), the Noctalia v4 bar (running on QuickShell via `qs -c noctalia-shell`) renders all text, numbers, badges, and icons as pure black (`#000000`) on a dark bar background.

## Root Cause
Qt 6.12 introduced a built-in global QML singleton type named `Color` (`QQuickColor`) inside `QtQuick`. This shadows Noctalia Shell's custom singleton `Color.qml` (`import qs.Commons`). Consequently, all expressions like `Color.mOnSurface` or `Color.resolveColorKey(...)` evaluate to `undefined` or throw `TypeError`, causing QML color properties to fall back to `#000000`.

## Resolution Steps
Execute the following steps to fix the issue persistently across reboots:

1. **Create User-Level QuickShell Override**:
   - Copy `/etc/xdg/quickshell/noctalia-shell` to `~/.config/quickshell/noctalia-shell` (QuickShell automatically prioritizes `$XDG_CONFIG_HOME/quickshell/noctalia-shell` over `/etc/xdg`).

2. **Rename the Custom Singleton**:
   - Rename `~/.config/quickshell/noctalia-shell/Commons/Color.qml` to `~/.config/quickshell/noctalia-shell/Commons/NColor.qml`.
   - If `~/.config/quickshell/noctalia-shell/Commons/qmldir` exists and registers `Color`, update it to `NColor`.

3. **Update References Across Shell & Plugins**:
   - Replace all whole-word occurrences of `Color.` with `NColor.` (`sed -i -E 's/\bColor\./NColor./g'`) across all `.qml` and `.js` files in:
     - `~/.config/quickshell/noctalia-shell/`
     - `~/.config/noctalia/plugins/` (follow symlinks if stowed in dotfiles)

4. **Restart the Bar Daemon**:
   - Kill existing QuickShell Noctalia instances: `pkill -f "qs.*noctalia-shell"`
   - Start the patched instance: `qs -d -c noctalia-shell`

5. **Verify**:
   - Check that no `TypeError` or `undefined` color errors appear in logs and that bar icons/text render in high-contrast white/theme colors.
