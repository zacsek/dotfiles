" LSP configuration
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gD <plug>(lsp-declaration)
    nmap <buffer> gs <plug>(lsp-signature-help)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>ra <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <leader>ca <plug>(lsp-code-action)
    nmap <buffer> gr <plug>(lsp-references)
    
    " refer to doc to add more
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled() for languages that has lsp registered via vim-lsp-settings
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
