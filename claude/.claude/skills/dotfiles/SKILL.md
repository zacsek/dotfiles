---
name: dotfiles
description: >
  Map and workflow for zacsek's GNU Stow dotfiles repo at ~/.dotfiles. Use whenever finding, reading,
  adding or changing ANY personal config: shell (zsh/bash aliases, functions, env vars, PATH, completions,
  prompt, per-host overrides), Neovim/NvChad (mappings, plugins, LSP, formatters, options), Niri
  (keybinds, window rules, hot-rules, layout, input, autostart, displays), Noctalia (settings.json, bar
  widgets, hooks, plugins, color templates), ghostty, alacritty, mise tools, git config, vim, nix
  home-manager, or adding a brand-new config/package to the dotfiles. Also use for "where is X
  configured", "add an alias", "bind a key", "add a tool", and anything under ~/.config/{sh,nvim,niri,
  noctalia,ghostty,alacritty,mise,nix}, ~/.zshrc, ~/.bashrc or ~/.gitconfig.
---

# Dotfiles

All personal config lives in `~/.dotfiles` (git repo, managed with GNU Stow). Every top-level directory is a
stow package whose contents mirror `$HOME`. **Edit files in `~/.dotfiles/...`**; the live paths are
symlinks into it, so the edit is live immediately.

## Package map

| Package | Live path | What lives there | Details |
|---|---|---|---|
| `sh` | `~/.config/sh/`, `~/.zshrc`, `~/.bashrc`, `~/.p10k.zsh`, `~/.profile`, `~/.zprofile` | aliases, functions, env, PATH, completions, prompt; per-host overrides | [references/shell.md](references/shell.md) |
| `nvim` | `~/.config/nvim/` | NvChad v2.5: mappings, plugins, LSP, conform, mason | [references/nvim.md](references/nvim.md) |
| `niri` | `~/.config/niri/` | compositor: keybinds, window rules, hot-rules, layout, input, autostart | [references/niri-noctalia.md](references/niri-noctalia.md) |
| `noctalia` | `~/.config/noctalia/` | shell bar/launcher/lock: settings.json, plugins, hooks, color templates | [references/niri-noctalia.md](references/niri-noctalia.md) |
| `ghostty`, `alacritty` | `~/.config/ghostty/config`, `~/.config/alacritty/alacritty.toml` | terminals | [references/other.md](references/other.md) |
| `mise` | `~/.config/mise/config.toml` | CLI tool versions (`[tools]`) | [references/other.md](references/other.md) |
| `git` | `~/.gitconfig` | git aliases, delta, pull/rebase | [references/other.md](references/other.md) |
| `vim` | `~/.vimrc`, `~/.vim/` | legacy vim (vim-plug) — nvim is the real editor | [references/other.md](references/other.md) |
| `nix-home-manager` | `~/.config/nix/` + `flake.nix`/`home.nix` | package list synced with `bom.txt` | [references/other.md](references/other.md) |
| `screenshots` | `~/.local/bin/`, `~/.config/systemd/user/` | screenshot-path watcher daemon | README.md |
| `claude` | `~/.claude/skills/dotfiles/` | this skill | — |

Read only the reference file for the area you are touching.

## Finding where something is configured

```bash
cd ~/.dotfiles
rg -n --hidden -g '!.git' -g '!*.bak' -g '!**/i18n/**' -g '!**/colorschemes/**' -g '!**/git-completion.bash' -g '!**/bash_git.sh' '<term>'
```

- Keybinds: niri → `niri/.config/niri/cfg/keybinds.kdl` (+ upstream defaults in
  `~/.local/share/feathers-and-flame/config-ref/deployed/niri/cfg/keybinds.kdl`, read-only); nvim →
  `nvim/.config/nvim/lua/mappings.lua`; terminals → `keybind =` in ghostty, `[[keyboard.bindings]]` in alacritty.
- Aliases/functions may be defined per host — check both `default.sh` and `<host>.sh` (current host: `hostname`).
- Ignore `*.bak` files when searching and editing; they are stale snapshots.

## Generated files — never hand-edit

Noctalia regenerates these from the wallpaper palette. They are **gitignored and untracked** (along with
`noctalia/.../plugins/daily-wallpaper/downloads/`), so they don't exist on a fresh clone until Noctalia
runs — anything that includes them must tolerate absence (niri uses `include optional=true "./noctalia.kdl"`):

- `niri/.config/niri/noctalia.kdl` (focus-ring/border colors)
- `alacritty/.config/alacritty/themes/noctalia.toml`, `ghostty/.config/ghostty/themes/noctalia`
- `nvim/.config/nvim/lua/matugen.lua` → edit `lua/matugen-template.lua` instead
- `noctalia/.config/noctalia/colors.json`

To change colors permanently, override them in a non-generated file (e.g. `cfg/layout.kdl`) or edit the template.

## Workflow for any change

1. Locate the right file with the map above; read the surrounding section and match its style
   (section headers, indentation — niri uses tabs, Lua uses 2 spaces, settings.json 4 spaces).
2. Check for collisions before adding a key/alias/name (`rg` the repo; for niri also the F&F defaults).
   If a keybind or alias would shadow an existing one, ask the user before overriding and suggest a free alternative.
3. Edit in `~/.dotfiles`.
4. Validate (per-area command in the reference file): `zsh -n`/`bash -n`, `niri validate`,
   `nvim --headless +qa`, `python3 -m json.tool`, etc.
5. Update companion docs when relevant: `nvim/.config/nvim/MAPPINGS.md` for nvim mappings,
   `README.md` package table for new packages, `bom.txt` + `home.nix` for new CLI tools,
   `MANUAL_INSTALLS.md` for non-scriptable installs.
6. Tell the user how to apply it (`src`, niri auto-reloads, restart noctalia, etc.).
7. Don't commit unless asked. When asked, commit only the files you touched — the tree often has
   unrelated work in progress. Commit subjects are short and lowercase-ish (`niri`, `transparency & dropbox`,
   `Add Ghostty and Alacritty configs`).

## Adding a new config / package

Stow folds directories: `~/.config/niri`, `~/.config/sh`, `~/.config/nvim`, etc. are **directory symlinks**, so new
files inside an existing package's directory appear live without re-stowing. Top-level `$HOME` files
(`.zshrc`, `.gitconfig`, …) are individual file symlinks.

For a brand-new app (e.g. `yazi`):

```bash
mkdir -p ~/.dotfiles/yazi/.config
mv ~/.config/yazi ~/.dotfiles/yazi/.config/      # adopt the existing config, if any
stow -d ~/.dotfiles -t ~ yazi                       # creates ~/.config/yazi -> ../.dotfiles/yazi/.config/yazi
```

Then add a row to the `README.md` packages table. A new file placed directly in `$HOME` of an existing package
(e.g. `sh/.zshenv`) needs `stow -d ~/.dotfiles -t ~ -R sh`.

`install.sh` stows every top-level dir and **backs up (moves away) any real directory** in the target that
the package also contains, except the container dirs listed in its `case` skip list
(`.config`, `.local`, `.local/bin`, `.claude`, …). If a new package nests under a shared container dir that
isn't in that list, add it there first, otherwise a fresh install will move the whole container aside.

## Related skills

- `cachyos_niri` — deeper Niri/Noctalia/Feathers-and-Flame knowledge (IPC commands, F&F scripts, AUR policy).
- `nvchad-customizer` — deeper NvChad patterns (lives in this repo at `nvim/.config/nvim/nvchad-skill/`).

Use this skill for *where* and *how it's organised here*; use those for syntax depth.
