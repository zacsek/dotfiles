# Other packages

## ghostty — `ghostty/.config/ghostty/config`

Default terminal (`Mod+Return`). `key = value` lines grouped under `# Section` comments (Font, Window, Cursor,
Keyboard bindings…). Keybinds: `keybind = ctrl+shift+x=action`. `theme = noctalia` points at the generated
`themes/noctalia` (don't edit). Validate: `ghostty +validate-config`. Reload: `ctrl+shift+,` or new window.

## alacritty — `alacritty/.config/alacritty/alacritty.toml`

Used for floating btop (`--class btop-floating`) and the arch-updater. TOML; keybinds are
`[[keyboard.bindings]]` tables with `key`, `mods`, `action`/`chars`, optional `mode`. Imports generated
`themes/noctalia.toml` (don't edit). `live_config_reload = true`.

## mise — `mise/.config/mise/config.toml`

Global CLI tools under `[tools]` as `name = "latest"` (or pinned, e.g. `python = "3.14.4"`); backends like
`"cargo:lq"`, `"aqua:owner/repo"`. Add: `mise use -g <tool>@latest` (writes this file through the symlink) or
edit by hand, then `mise install`. Also add the tool to `bom.txt` (right category, aligned comment).

## git — `git/.gitconfig`

Sections: `[user]`, `[core]` (pager = delta), `[pull] rebase`, `[alias]` (tab-indented, aligned `=`),
`[delta]`, `[credential "https://gitea.zacsek.net"]`. Validate: `git config --list >/dev/null`.

## vim — `vim/.vimrc`, `vim/.vim/plugin/NN_<topic>.vim`

Legacy config with vim-plug; numbered plugin files (`01_sets`, `02_maps`, `03_color`, … `08_lsp`) and
`after/ftplugin/<ft>.vim`. Add new topics as the next number. Only touch if the user asks about vim specifically —
`vim` is aliased to `nvim`.

## nix-home-manager — `nix-home-manager/{flake.nix,home.nix}`, `.config/nix/nix.conf`

`home.nix` `home.packages` mirrors `bom.txt` category by category (comments say "Synchronized with bom.txt").
When adding a CLI tool that should be on every machine: add it to `bom.txt` **and** `home.nix` in the same
category; use `(getPkg "name")` for packages that may not exist in nixpkgs. Explanation in `nix_explanation.md`;
installer `install_nix_homemanager.sh`.

## Repo-level files

- `install.sh` — stows every top-level package (with backups); `--root` also for root.
- `README.md` — package table + package details. Add new packages here.
- `bom.txt` — bill of materials of CLI tools, by category.
- `MANUAL_INSTALLS.md` — manual install steps / workarounds (e.g. Maestral). Add a `## Name` section for anything
  that can't be automated.
- `.gitignore` — ignores `lazy-lock.json`, `.oldies/`, `.ruby-lsp`.
