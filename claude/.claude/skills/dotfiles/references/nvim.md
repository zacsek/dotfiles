# Neovim (`nvim` package) — NvChad v2.5

Root: `~/.dotfiles/nvim/.config/nvim/` (live at `~/.config/nvim`). Leader is `<Space>`.
For deeper NvChad API questions, also load the `nvchad-customizer` skill.

## Files

| File | Purpose |
|---|---|
| `init.lua` | bootstraps lazy.nvim, imports `nvchad.plugins` + `plugins`, then `options`, `autocmds`, `mappings` (scheduled) |
| `lua/chadrc.lua` | NvChad UI/theme (`M.base46.theme = "onedark"`, transparency, `hl_override`) |
| `lua/options.lua` | `vim.opt.*` on top of `require "nvchad.options"` |
| `lua/mappings.lua` | all custom keymaps on top of `require "nvchad.mappings"` |
| `lua/autocmds.lua` | just `require "nvchad.autocmds"` (yank-highlight autocmd lives in `options.lua`) |
| `lua/plugins/init.lua` | every lazy.nvim plugin spec (single file, one list) |
| `lua/configs/lspconfig.lua` | LSP servers |
| `lua/configs/mason.lua` | `ensure_installed` list (also feeds mason-tool-installer) |
| `lua/configs/conform.lua` | formatters by filetype; format on save enabled |
| `lua/configs/telescope.lua`, `lua/configs/lazy.lua` | telescope opts, lazy.nvim opts |
| `lua/matugen-template.lua` | base16 colors template rendered by Noctalia → `lua/matugen.lua` (generated, don't edit) |
| `MAPPINGS.md` | human cheat sheet of all mappings — **keep in sync** |
| `nvchad-skill/SKILL.md` | the `nvchad-customizer` skill |

`lazy-lock.json` is git-ignored.

## Recipes

**Keymap** — append to the matching thematic block in `lua/mappings.lua`, always with `desc`:

```lua
map("n", "<leader>xx", "<cmd>SomeCommand<CR>", { desc = "Short description" })
```

Check for clashes first: `rg -n '"<leader>xx"|'"'"'<leader>xx'"'"'' lua/` and the NvChad defaults
(`MAPPINGS.md` rows with Source `NvChad`). Then add a row to the right `MAPPINGS.md` section
(Basic & General, Window & Buffer, LSP & Diagnostics, Telescope & Trouble, Terminal, Git, Tests & Debugging,
Plugins (Other)) with `Source` = `Custom`, keeping the column alignment.

**Plugin** — add a spec to the list in `lua/plugins/init.lua`. Prefer lazy loading (`cmd`, `ft`, `event`, `keys`).
Simple options inline via `opts = {}`; bigger config in `lua/configs/<name>.lua` and `opts = require "configs.<name>"`.
Colorscheme plugins go at the end with `lazy = true, priority = 1000`.

**LSP server** — in `lua/configs/lspconfig.lua`, follow the existing pattern:

```lua
vim.lsp.config("pyright", {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.enable("pyright")
```

and add the Mason package name (e.g. `"pyright"`) to `lua/configs/mason.lua`. Ruby LSP runs through mise
(`cmd = { "mise", "exec", "ruby", "--", "ruby-lsp" }`) — do the same for other mise-managed runtimes.

**Formatter** — `formatters_by_ft` in `lua/configs/conform.lua`, plus the tool in `mason.lua` `ensure_installed`.

**Treesitter parser** — `ensure_installed` in the `nvim-treesitter` spec in `lua/plugins/init.lua`.

**Option** — `lua/options.lua`, `vim.opt.<name> = ...`.

## Validate

```bash
nvim --headless "+lua print('ok')" +qa 2>&1 | tail -5            # startup errors
nvim --headless "+Lazy! sync" +qa                                   # install new plugins (network)
nvim --headless "+checkhealth vim.lsp" "+w! /tmp/claude-health.txt" +qa   # optional
```

User applies by restarting nvim (or `:Lazy sync` for new plugins).

trouble.nvim is v3: commands are `Trouble <mode> toggle` (`diagnostics`, `qflist`, `loclist`, …), not the old
`TroubleToggle`.
