# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/) and automated installation scripts.

Compatible with [dotfiles_ansible_installer](https://github.com/zacsek/dotfiles_ansible_installer).

---

## Packages

| Package | Description |
|---|---|
| [`screenshots`](./screenshots) | Automatic screenshot file path copier for Wayland/CopyQ |
| [`sh`](./sh) | Shell configurations (`zsh`, `bash`, aliases, completions, environment) |
| [`nvim`](./nvim) | Neovim configuration based on [NvChad](https://nvchad.com/) |
| [`vim`](./vim) | Classic Vim setup with plugins |
| [`git`](./git) | Git configuration |
| [`mise`](./mise) | [Mise-en-place](https://mise.jdx.dev/) tool manager configs |
| [`nix-home-manager`](./nix-home-manager) | Nix Home Manager configuration and flakes |

---

## Installation

Run the discovery & stow installer script:

```bash
./install.sh
```

To install for root as well:
```bash
./install.sh --root
```

Or stow individual packages manually:
```bash
stow -t ~ screenshots
```

---

## Package Details

### Screenshots (`screenshots/`)

A lightweight daemon that monitors `~/Pictures/Screenshots/` using Linux kernel `inotify`. When a screenshot is saved (e.g. from Niri), it:
1. Pushes the full file path string to the Wayland clipboard (`wl-copy`).
2. Inserts and selects the file path as slot `0` (top item) in [CopyQ](https://github.com/hluk/CopyQ), preventing raw image data from overtaking the active text queue.
3. Sends a desktop notification with a thumbnail preview.

#### Files:
- `.local/bin/screenshot-path-watcher.py` — Python inotify watcher daemon.
- `.config/systemd/user/screenshot-path-watcher.service` — Systemd user unit for automatic background execution.

#### Enabling the Service:
```bash
systemctl --user daemon-reload
systemctl --user enable --now screenshot-path-watcher.service
```

#### Dependencies:
- `python3`
- `wl-clipboard` (`wl-copy`)
- `copyq` *(optional, if using CopyQ clipboard manager)*
- `libnotify` (`notify-send`)
