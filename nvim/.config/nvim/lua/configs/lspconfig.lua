local nvchad_lsp = require "nvchad.configs.lspconfig"
local telescope_builtin = require "telescope.builtin"
local utils = require "utils"

local on_attach = nvchad_lsp.on_attach
-- local on_attach = function(client, bufnr)
--   nvchad_lsp.on_attach(client, bufnr)
--
--   local opts = { buffer = bufnr }
--   vim.keymap.set("n", "gd", function()
--     telescope_builtin.lsp_definitions({
--       jump_type = "tab",
--       on_list = function(results)
--         return utils.deduplicate_locations(results)
--       end,
--     })
--   end, opts)
--   vim.keymap.set("n", "gi", function()
--     telescope_builtin.lsp_implementations({
--       jump_type = "tab",
--       on_list = function(results)
--         return utils.deduplicate_locations(results)
--       end,
--     })
--   end, opts)
-- end
local capabilities = nvchad_lsp.capabilities

-- HTML
vim.lsp.config("html", {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.enable("html")

-- CSS
vim.lsp.config("cssls", {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.enable("cssls")

-- YAML
vim.lsp.config("yamlls", {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.enable("yamlls")

-- JSON
vim.lsp.config("jsonls", {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.enable("jsonls")

-- Ruby
vim.lsp.config("ruby_lsp", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "ruby" },
  cmd = { "/home/zacsek/.local/share/mise/installs/ruby/3.4.7/bin/ruby-lsp" },
})
vim.lsp.enable("ruby_lsp")

-- RuboCop
-- vim.lsp.config("rubocop", {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "ruby" },
-- })
-- vim.lsp.enable("rubocop")
