"--------------------------------------
" Mappings
"--------------------------------------
let mapleader=","
let g:mapleader=","

" toggle between windows
nnoremap <tab> <c-w>w
nnoremap <s-tab> :tabnext<CR>

" toggle between brackets.
nnoremap <space> %

" Save file even when forgot to sudo
cmap w!! w !sudo tee >/dev/null %

" Copy & Paste from system clipboard
nnoremap  <leader>c "+yy
nnoremap  <leader>p "+p

" select previous pasted text
nnoremap <silent> gv `[v`]

" Function keys

" F2
" F3 - toggle search highlight
nnoremap <silent> <F3> :set hlsearch!<CR>
" F4 - toggle line wrapping
nnoremap <silent> <F4> :set wrap!<CR>
" F5 - toggle list whitespace
set listchars=eol:$,tab:>-,space:.
nnoremap <silent> <F5> :set list!<CR>
" F6 - toggle colorcolumn
nnoremap <silent> <F6> :execute "set colorcolumn=" . (&colorcolumn == "" ? "80"  : "")<CR>
" F7
" F8 - toggle paste mode
nnoremap <silent> <F8> :set paste!<BAR>set paste?<CR>
" F9
" F10 - toggle undotree
nnoremap <silent> <F10> :UndotreeToggle<CR>

" open vimrc -> moved to plugin/telescope.vim
"nnoremap <silent> <leader>vrc :topleft vnew ~/.config/nvim/init.vim<CR>

" ,t tabularize on word-start
nnoremap <silent> <leader>t :Tabularize /\<<CR>

" open the error console
nnoremap <leader>cc :botright cope<CR> 
" move to next error
nnoremap <leader>] :cn<CR>
" move to the prev error
nnoremap <leader>[ :cp<CR>

" only keep lines which contain search
"nnoremap ,v :v/<C-R>//d<CR>gg
"nnoremap ,d :g/<C-R>//d<CR>gg

" search next/previous -- center in page
nnoremap n nzz
nnoremap N Nzz
nnoremap * *Nzz

" open help in a vertical split
cnoremap vh vert help 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Split mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" window
nnoremap \|<left>  :topleft  vnew<CR>
nnoremap \|<right> :botright vnew<CR>
nnoremap \|<up>    :topleft  new<CR>
nnoremap \|<down>  :botright new<CR>

" buffer
nnoremap \<left>  :leftabove  vnew<CR>
nnoremap \<right> :rightbelow vnew<CR>
nnoremap \<up>    :leftabove  new<CR>
nnoremap \<down>  :rightbelow new<CR>

"--------------------------------------
" Plugins
"--------------------------------------


" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview


" --- NERDCommenter
"nnoremap # :call NERDComment(1, "toggle")<CR>
nmap # <Plug>NERDCommenterToggle
vmap # <Plug>NERDCommenterToggle
