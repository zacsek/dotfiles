require "nvchad.mappings"

-- add yours here

local map = map

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

--  See `:help wincmd` for a list of all window commands
map('n', '<Tab>', '<C-w>w', { desc = 'Move focus to the next window' })
map('n', '<S-Tab', '<C-w>W', { desc = 'Move focus to the previous window' })

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('c', 'w!!', 'w !sudo tee >/dev/null %', { desc = 'Save file even when forgot to sudo' })

map('c', '<F3>', 'set hlsearch!', { desc = 'Toggle search highlight' })
map('c', '<F4>', 'set wrap!', { desc = 'Toggle line wrapping' })
map('c', '<F5>', 'set list!', { desc = 'Toggle list whitespace' })
map('c', '<F8>', 'set paste!<BAR>set paste?', { desc = 'Toggle paste mode' })

map('n', 'gv', '`[v`]', { desc = 'select previous pasted text' })

map('n', 'n', 'nzz', { desc = 'Center in page: next search item' })
map('n', 'N', 'Nzz', { desc = 'Center in page: prev search item' })

