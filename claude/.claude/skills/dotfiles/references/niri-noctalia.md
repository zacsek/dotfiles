# Niri + Noctalia (`niri`, `noctalia` packages)

Desktop = CachyOS + Niri + Noctalia Shell, bootstrapped by **Feathers and Flame (F&F)** in
`~/.local/share/feathers-and-flame/` — **read-only, never edit** (updates overwrite it). Read it freely to
learn defaults. For IPC commands and F&F scripts in depth, also load the `cachyos_niri` skill.

## Niri — `~/.dotfiles/niri/.config/niri/`

`config.kdl` includes, in order: F&F defaults (`autostart`, `keybinds`, `rules`, `misc` from
`~/.local/share/feathers-and-flame/config-ref/deployed/niri/cfg/`), then the user files below, then
`noctalia.kdl` (generated colors), then declares workspaces 1–5.

| File | Put here |
|---|---|
| `cfg/keybinds.kdl` | user binds (one `binds { }` block) |
| `cfg/rules.kdl` | `window-rule { }` blocks (floating, sizes, fullscreen, maximize) |
| `cfg/hot-rules.kdl` | `include` lines for toggleable rule sets (commented = off) |
| `cfg/hot-rules/<name>.kdl` | a toggleable rule set: `transparency`, `mass-screenshot`, `hdmi-only`, `tablet-to-hdmi`, `use-dgpu` |
| `cfg/layout.kdl` | gaps, column widths, focus-ring width, centering |
| `cfg/animation.kdl` | animation springs/curves |
| `cfg/input.kdl` | keyboard (layouts `us,hu,de`), touchpad (off), mouse (left-handed, flat) |
| `cfg/display.kdl` | `output` blocks (currently disabled with `/-`) |
| `cfg/autostart.kdl` | `spawn-at-startup` |
| `*.sh` / `*.py` next to config.kdl | helper scripts bound to keys (`toggle-btop.sh`, `niri-cheatsheet.sh`, `parse_binds.py`) |

Ignore `cfg/*.bak` and `cfg/hot-rules/*.bak`.

### Keybinds

```kdl
	Mod+X hotkey-overlay-title="Short Title" { spawn "app" "--flag"; }
	Mod+Shift+X hotkey-overlay-title="Shell thing" { spawn-sh "cmd | other"; }
```

- Tab-indented inside `binds { }`; always set `hotkey-overlay-title` (the Noctalia keybind-cheatsheet plugin
  reads it — `Mod+Slash`). Use `hotkey-overlay-title=null` for repetitive series after the first.
- Before binding, check **both** files for the combo:
  ```bash
  rg -n '^\s*Mod\+X\b' ~/.dotfiles/niri/.config/niri/cfg/keybinds.kdl \
     ~/.local/share/feathers-and-flame/config-ref/deployed/niri/cfg/keybinds.kdl
  ```
  If it's taken, tell the user what it currently does, and offer free alternatives before overriding.
- Scripts: use absolute paths (`/home/zacsek/.config/niri/<script>.sh`), `chmod +x` them.
- Noctalia actions: `spawn-sh "qs -c noctalia-shell ipc call <target> <fn>"`.

### Window rules

```kdl
window-rule {
    match app-id="org.example.App"
    open-floating true
    default-column-width { proportion 0.5; }
    default-window-height { proportion 0.6; }
}
```

Find app-ids with `niri msg windows`. Opacity/blur rules belong in `cfg/hot-rules/transparency.kdl`
(toggled with `Mod+Shift+T`), not `rules.kdl`.

### Hot-rules (toggleable config)

Toggled by F&F: `bash ~/.local/share/feathers-and-flame/script/cmd/hot-rules.sh <name>` — it flips the
`// ` comment prefix on the matching `include ".../hot-rules/<name>.kdl"` line in `cfg/hot-rules.kdl`.
To add one:

1. Create `cfg/hot-rules/<name>.kdl`.
2. Add `// include "./hot-rules/<name>.kdl"` (or uncommented, if it should start on) to `cfg/hot-rules.kdl`.
3. Optionally bind it:
   `Mod+... hotkey-overlay-title="Toggle <Name>" { spawn-sh "bash /home/zacsek/.local/share/feathers-and-flame/script/cmd/hot-rules.sh <name>"; }`

### Validate & apply

```bash
niri validate                     # must print "config is valid"
```

Niri auto-reloads on save; manual: `niri msg action load-config-file` (bound to `Mod+Ctrl+R`, which also refreshes
the cheatsheet).

## Noctalia — `~/.dotfiles/noctalia/.config/noctalia/`

| File / dir | Notes |
|---|---|
| `settings.json` | all shell settings (bar, dock, launcher, idle, nightLight, wallpaper, hooks, templates…). Written by the Noctalia settings GUI. |
| `colors.json` | generated palette — don't edit |
| `user-templates.toml` | extra color templates: `[templates.<id>]` with `input_path`, `output_path`, optional `post_hook`. Placeholders like `{{colors.primary.default.hex}}` (filters: `darken N`, `invert`, `set_hue N`). |
| `plugins.json` | enabled plugins (`states.<id>.enabled`) + source repo |
| `plugins/<id>/` | upstream plugin code from noctalia-plugins — don't edit QML; per-plugin config in `plugins/<id>/settings.json`, bar-widget config in `settings.json` → `bar.widgets` |
| `colorschemes/` | predefined schemes (`colorSchemes.predefinedScheme`) |
| `sync_sddm_wallpaper.sh` | called from `hooks.wallpaperChange` |
| `feathers-modern/`, `theme.conf` | SDDM theme |

### Editing `settings.json`

- Top-level keys: `appLauncher audio bar brightness calendar colorSchemes controlCenter desktopWidgets dock general
  hooks idle location network nightLight noctaliaPerformance notifications osd plugins sessionMenu systemMonitor
  templates ui wallpaper`. Bar widgets: `bar.widgets.{left,center,right}` — arrays of `{ "id": "...", ...opts }`
  (plugin widgets use `"id": "plugin:<name>"`).
- Edit surgically with `jq` or Python, keeping 4-space indentation and key order, e.g.
  ```bash
  f=~/.dotfiles/noctalia/.config/noctalia/settings.json
  jq --indent 4 '.nightLight.nightTemp = "4000"' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
  ```
  Check the existing value type first (`jq '.nightLight' "$f"`) — don't turn strings into numbers.
- Hooks (`.hooks.*`) are shell commands; F&F wires `startup`, `wallpaperChange`, `colorGeneration`, `screenLock` —
  append with `&&` rather than replacing.
- Built-in theming targets are toggled in `.templates.activeTemplates` (`niri`, `alacritty`, `gtk`, `btop`, …);
  custom ones go in `user-templates.toml`.
- Validate: `python3 -m json.tool "$f" >/dev/null`.
- Apply: `bash ~/.local/share/feathers-and-flame/script/cmd/noctalia-restart.sh`. The GUI can rewrite the file
  while running, so make the edit, restart, then re-check the value persisted.

IPC discovery: `qs -c noctalia-shell ipc show`.
