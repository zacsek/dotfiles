"--------------------------------------
" General
"--------------------------------------

set nocompatible
set hidden                              "" Allow switching edited buffers without saving
set mouse=a
set encoding=utf-8
set noswapfile
set nobackup                            "" Do not keep a backup file.
set backspace=indent,eol,start          "" Make backspace delete lots of things
set guicursor=                          "" set block cursor for nvim
set relativenumber                      "" relative numbering on
set number                              "" numbering on

"--------------------------------------
" Filetype & Indent
"--------------------------------------
filetype plugin indent on
syntax on
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

"--------------------------------------
" Find
"--------------------------------------
" Nice menu when typing `:find *.py`
set wildchar=<TAB>                      "" start wild expansion in the command line using <TAB>
set wildmode=longest,list,full
set wildmenu

" Ignore files
set wildignore+=**/.git/*
set wildignore+=*.o
set wildignore+=*.class
set wildignore+=*.pyc

"--------------------------------------
" Search
"--------------------------------------
set magic                               "" Use 'magic' patterns (extended regular expressions).
set hlsearch                            "" Highlight searched for phrases
set incsearch                           "" Highlight as you type you search phrase
set ignorecase                          "" Case insensitive matching.
set smartcase                           "" Make searches case-insensitive, unless they contain upper-case letters
set gdefault                            "" Assume the /g flag on :s substitutions to replace all matches in a line

"--------------------------------------
" Copy/Paste & Undo
"--------------------------------------

set clipboard=unnamed                   "" yank to the system register (*) by default
set history=100                         "" Number of lines of command line history.
set undolevels=500                      "" Number of undo levels.
set ssop-=options                       "" do not store global & local variables in session
set ssop-=folds                         "" do not store folds in session
set undodir=~/.vim/undodir
set undofile


"--------------------------------------
" Folding
"--------------------------------------
set nofoldenable

"--------------------------------------
" Appearance
"--------------------------------------
" set title
" set noshowmode
" set ls=0
set autoread                            "" auto read when file is changed from outside
set cmdheight=1                         "" Give more space for displaying messages.
set isfname+=@-@
set laststatus=2
set lazyredraw
set matchtime=0                         "" Tenths of seconds to show matching
set noerrorbells
set nostartofline                       "" Do not jump to first character with page commands,
set nowrap                              "" wrap off
set ruler                               "" Show the line and column numbers of the cursor.
set scrolloff=8                         "" Keep a context when scrolling.
set shortmess+=c                        "" Don't pass messages to |ins-completion-menu|.
set showbreak=+                         "" Show a '+' if a line is longer than the screen.
set showcmd                             "" Show (partial) command in status line.
set showmatch                           "" Show matching brackets.
set showmode                            "" Show current mode.
set sidescroll=2
set sidescrolloff=5
set signcolumn=yes
set termguicolors
set textwidth=0                         "" Don't wrap words by default.
set updatetime=50                       "" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set statusline=%<%f%m%r%=%y\ %{&ff}\ %l,%c%V/%o\ %B\ %P

" Automatically remove trailing whitespace on saving
autocmd BufWritePre * :%s/\s\+$//e
