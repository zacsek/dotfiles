lua require("theprimeagen")

nnoremap <leader>dot :lua require('theprimeagen.telescope').search_dotfiles()<CR>
nnoremap <leader>rc :lua require('theprimeagen.telescope').search_vimconfig()<CR>
nnoremap <leader>sh :lua require('theprimeagen.telescope').search_bash()<CR>
nnoremap <leader>zsh :lua require('theprimeagen.telescope').search_zsh()<CR>


nnoremap <leader>gr :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <Leader>ff :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>b :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>h :lua require('telescope.builtin').help_tags()<CR>

nnoremap <leader>gf :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>gb :lua require('theprimeagen.telescope').git_branches()<CR>
"nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
"nnoremap <leader>gm :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
" nnoremap <leader>va :lua require('theprimeagen.telescope').anime_selector()<CR>
" nnoremap <leader>vc :lua require('theprimeagen.telescope').chat_selector()<CR>
" nnoremap <leader>td :lua require('theprimeagen.telescope').dev()<CR>
