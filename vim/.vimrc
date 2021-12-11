set nocompatible

set path=.,**

" Autoinstall vim-plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}

call plug#begin('~/.vim/plugged')
  Plug 'godlygeek/tabular'
  Plug 'scrooloose/nerdcommenter'

  Plug 'gruvbox-community/gruvbox'

  " fern
  Plug 'lambdalisue/fern.vim'
  "Plug 'lambdalisue/fern-git-status.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  "Plug 'lambdalisue/glyph-palette.vim'

  " git
  Plug 'tpope/vim-fugitive'

  " undotree
  Plug 'mbbill/undotree'
call plug#end()
