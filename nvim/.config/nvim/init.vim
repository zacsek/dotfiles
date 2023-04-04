set nocompatible

set path=.,**
set runtimepath+='~/.config/nvim/lua'

" Autoinstall vim-plug {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}

call plug#begin('~/.config/nvim/plugged')
  Plug 'godlygeek/tabular'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-surround'

  Plug 'gruvbox-community/gruvbox'
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

  " lsp Plugins
  Plug 'neovim/nvim-lspconfig'
  "Plug 'dundalek/lazy-lsp.nvim'
  " Plug 'hrsh7th/cmp-nvim-lsp'
  " Plug 'hrsh7th/cmp-buffer'
  " Plug 'hrsh7th/nvim-cmp'
  "
  " Plug 'SmiteshP/nvim-navic' " need config

  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  Plug 'junegunn/fzf'


  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'christoomey/vim-tmux-navigator'
  " nvim-tree file explorer
  Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
  Plug 'kyazdani42/nvim-tree.lua'

  " fern
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-git-status.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/glyph-palette.vim'

  " telescope
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'nvim-lua/completion-nvim'
  "Plug 'sharkdp/fd'

  " git
  Plug 'tpope/vim-fugitive'

  " undotree
  Plug 'mbbill/undotree'

  " ruby
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rake'
  Plug 'tpope/vim-bundler'

  " yaml
  Plug 'cuducos/yaml.nvim'

  " ansible / yaml
  Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }

call plug#end()


lua require('plugins')

