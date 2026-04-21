" ALE (Linting and Formatting - Conform/Lint equivalent)
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'python': ['black', 'isort'],
\   'ruby': ['rubocop'],
\   'lua': ['stylua'],
\}

" IndentLine configuration
let g:indentLine_char = '┊'
let g:indentLine_fileTypeExclude = ['help', 'fern']
