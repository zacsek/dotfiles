vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use { 'dundalek/lazy-lsp.nvim', requires = { 'neovim/nvim-lspconfig' } }
end)

