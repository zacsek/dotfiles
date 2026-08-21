# Manual Software Installations

This document tracks specific manual installation instructions or workarounds needed for this dotfiles environment (e.g. CachyOS / Wayland / Niri).

---

## Maestral (Dropbox Client)

The official Dropbox Linux client uses outdated X11 tray protocols which do not work on modern Wayland compositors (like Niri) without bloated proxies. **Maestral** is an open-source, lightweight Python client for Dropbox that has native Wayland support and a working tray icon.

### Installation on CachyOS / Arch Linux
Because this environment uses `mise` to manage Python versions, building Maestral from the AUR can fail with `No module named build` (because `paru` will attempt to use the `mise` python instead of the system python). Additionally, Maestral's test suite currently fails on some machines.

Use this command to temporarily bypass `mise` and skip the broken unit tests:

```bash
env PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl" paru -S --mflags="--nocheck" maestral maestral-qt
```

### Post-Installation
After it successfully installs, start the GUI and follow the browser prompts to link your Dropbox account:

```bash
maestral gui
```

*(Note: Maestral is already configured to autostart silently in `niri/cfg/autostart.kdl`)*
