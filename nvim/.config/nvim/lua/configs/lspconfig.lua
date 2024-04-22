-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = {
  "bashls",
  "cssls",
  "docker_compose_language_service",
  "dockerls",
  "html",
  "java_language_server",
  "kotlin_language_server",
  "lua_ls",
  "ruby_ls",
  "sqlls",
  "standardrb",
  "terraformls",
  "vimls",
  -- "bash-debug-adapter",
  -- "bash-language-server",
  -- "docker-compose-language-service",
  -- "dockerfile-language-server",
  -- "java-language-server",
  -- "kotlin-debug-adapter",
  -- "kotlin-language-server",
  -- "lua-language-server",
  -- "prettier",
  -- "rubocop",
  -- "ruby-lsp",
  -- "rust-analyzer",
  -- "solargraph",
  -- "spectral",
  -- "spectral-language-server",
  -- "sqlls",
  -- "standardrb",
  -- "stylua",
  -- "terraform-ls",
  -- "vim-language-server",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
