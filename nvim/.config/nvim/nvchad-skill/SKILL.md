---
name: nvchad-customizer
description: Expert guidance for customizing and extending NvChad Neovim installations. Use when the user wants to add plugins, change keymappings, configure LSPs (especially Ruby/Rails), or modify NvChad settings.
---

# NvChad Customization Skill

This document provides instructions and architectural context for Gemini to help customize this NvChad installation.

## Core Architecture
NvChad is a "base" Neovim configuration. We extend it using a structured approach in the `lua/` directory.

### Directory Structure
- `init.lua`: Entry point. Bootstraps NvChad and lazy.nvim.
- `lua/chadrc.lua`: Main NvChad UI/Theme/Module configuration. Use this to override NvChad defaults.
- `lua/options.lua`: Custom Neovim options (e.g., `vim.opt.relativenumber = true`).
- `lua/mappings.lua`: Custom keymappings. Use `vim.keymap.set` for new mappings.
- `lua/plugins/init.lua`: Plugin definitions and specifications for **lazy.nvim**.
- `lua/configs/`: Detailed configuration for specific plugins (e.g., LSP, Conform, Telescope).

## Guidelines for Customization

### 1. Adding New Plugins
- Add new plugin specs to `lua/plugins/init.lua`.
- For complex configurations, create a new file in `lua/configs/<plugin_name>.lua` and reference it in the `opts` or `config` key in `lua/plugins/init.lua`.
- **Example:**
  ```lua
  {
    "some/plugin",
    opts = require "configs.some_plugin",
  }
  ```

### 2. Configuring LSP (Neovim 0.11+ Style)
This installation uses the new Neovim 0.11 `vim.lsp.config` and `vim.lsp.enable` pattern in `lua/configs/lspconfig.lua`.
- To add an LSP:
  1. Add it to `ensure_installed` in `lua/configs/mason.lua`.
  2. Configure it in `lua/configs/lspconfig.lua`:
     ```lua
     vim.lsp.config("servername", {
       on_attach = on_attach,
       capabilities = capabilities,
     })
     vim.lsp.enable("servername")
     ```

### 3. Ruby & Rails Setup
- **LSP**: Using `ruby_lsp`. Configuration is in `lua/configs/lspconfig.lua`.
- **Treesitter**: Ensure `ruby` is in `ensure_installed` in `lua/plugins/init.lua`.
- **Formatting**: Managed via `conform.nvim`. Configuration is in `lua/configs/conform.lua`.
  - Ruby currently uses `standardrb` for formatting.
  - To add a new formatter, update `formatters_by_ft` in `lua/configs/conform.lua` and add the binary to `ensure_installed` in `lua/configs/mason.lua`.
- **Rails**: When adding Rails-specific plugins (like `vim-rails`), put them in `lua/plugins/init.lua`.

### 4. Custom Keymappings
- Define mappings in `lua/mappings.lua`.
- Use the `map('n', 'key', 'action', { desc = 'Description' })` helper or `vim.keymap.set`.
- Favor mnemonics and consistency with existing mappings.
- **MAPPINGS.md**: Whenever adding or modifying keymappings, you MUST also update `MAPPINGS.md` to keep it synchronized. Keep the existing layout and markdown formatting. Ensure that the table columns in the markdown file are always aligned for better readability.

### 5. Best Practices
- **Do not modify `init.lua`** unless absolutely necessary.
- **Modularize**: Keep `lua/plugins/init.lua` clean by moving logic to `lua/configs/`.
- **Documentation**: Always include a `desc` in keymappings for `which-key` support.
- **Mise/Version Managers**: Be aware of absolute paths in LSP configs (e.g., `ruby-lsp` path) if environment variables aren't sufficient.

## Commands for Reference
- `:Lazy`: Manage plugins.
- `:Mason`: Manage LSP/Linter/Formatter binaries.
- `:NvCheatsheet`: View all active mappings.
- `:checkhealth`: Debugging.
