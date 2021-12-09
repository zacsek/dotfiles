set path=.,**

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
  
  Plug 'gruvbox-community/gruvbox'
  
  " lsp Plugins
  " Plug 'neovim/nvim-lspconfig'
  " Plug 'hrsh7th/cmp-nvim-lsp'
  " Plug 'hrsh7th/cmp-buffer'
  " Plug 'hrsh7th/nvim-cmp'
  
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 

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
call plug#end()

set runtimepath+='~/.config/nvim/lua'

