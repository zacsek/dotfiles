require "nvchad.mappings"


local map = vim.keymap.set

-- Diagnostics
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<leader>td', function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.disable()
    print("Diagnostics disabled")
  else
    vim.diagnostic.enable()
    print("Diagnostics enabled")
  end
end, { desc = 'Toggle diagnostics' })

-- Window Management
--  See `:help wincmd` for a list of all window commands
map('n', 'qq', '<Cmd>:qa<CR>', { desc = 'Quit all' })
map('n', '<Tab>', '<C-w>w', { desc = 'Move focus to the next window' })
map('n', '<S-Tab', '<C-w>W', { desc = 'Move focus to the previous window' })
map('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- map("n", "\\", "<cmd>:vsplit <CR>", { desc = "Vertical Split" })
map("n", "<leader>cx", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "Close All Buffers" })

-- Editing
map('n', 'w!!', '<Cmd>w !sudo tee >/dev/null %<CR>', { desc = 'Save file even when forgot to sudo' })
map('n', '<F3>', '<Cmd>set hlsearch! | set hlsearch?<CR>', { desc = 'Toggle search highlight' })
map('n', '<F4>', '<Cmd>set wrap! | set wrap?<CR>', { desc = 'Toggle line wrapping' })
map('n', '<F5>', '<Cmd>set list! | set list?<CR>', { desc = 'Toggle list whitespace' })
map('n', '<F8>', '<Cmd>set paste! | set paste?<CR>', { desc = 'Toggle paste mode' })
map('n', 'gv', '`[v`]', { desc = 'select previous pasted text' })
map('n', 'n', 'nzz', { desc = 'Center in page: next search item' })
map('n', 'N', 'Nzz', { desc = 'Center in page: prev search item' })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })

-- LSP
map('n', 'gD', function() vim.lsp.buf.declaration() end, { desc = 'LSP: Go to declaration' })
map('n', 'gd', function() vim.lsp.buf.definition() end, { desc = 'LSP: Go to definition' })
map('n', 'K', function() vim.lsp.buf.hover() end, { desc = 'LSP: Open hover menu' })
map('n', 'gi', function() vim.lsp.buf.implementation() end, { desc = 'LSP: Go to implementation' })
map('n', '<leader>ls', function() vim.lsp.buf.signature_help() end, { desc = 'LSP: Show signature help' })
map('n', '<leader>D', function() vim.lsp.buf.type_definition() end, { desc = 'LSP: Type definition' })
map('n', '<leader>ra', function() require("nvchad.renamer").open() end, { desc = 'LSP: Open renamer' })
map('n', '<leader>ca', function() vim.lsp.buf.code_action() end, { desc = 'LSP code action' })
map('n', 'gr', function() vim.lsp.buf.references() end, { desc = 'LSP references' })
map('n', '<leader>lf', function() vim.diagnostic.open_float { border = "rounded" } end, { desc = 'Floating diagnostic' })
map('n', '<leader>wa', function() vim.lsp.buf.add_workspace_folder() end, { desc = 'Add workspace folder' })
map('n', '<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end, { desc = 'Remove workspace folder' })
map('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = 'List workspace folders' })
map('v', '<leader>ca', function() vim.lsp.buf.code_action() end, { desc = 'LSP code action' })
map('n', 'g,', '<C-t>', { desc = 'Jump back to previous location' })

-- Trouble
map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find Todo" })
map("n", "<leader>qx", "<cmd>TroubleToggle<CR>", { desc = "Open Trouble" })
map("n", "<leader>qw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Open Workspace Trouble" })
map("n", "<leader>qd", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "Open Document Trouble" })
map("n", "<leader>qq", "<cmd>TroubleToggle quickfix<CR>", { desc = "Open Quickfix" })
map("n", "<leader>ql", "<cmd>TroubleToggle loclist<CR>", { desc = "Open Location List" })
map("n", "<leader>qt", "<cmd>TodoTrouble<CR>", { desc = "Open Todo Trouble" })

-- Tmux
map("n", "<c-l>", "<cmd>:TmuxNavigateRight<cr>", { desc = "Tmux Right" })
map("n", "<c-h>", "<cmd>:TmuxNavigateLeft<cr>", { desc = "Tmux Left" })
map("n", "<c-k>", "<cmd>:TmuxNavigateUp<cr>", { desc = "Tmux Up" })
map("n", "<c-j>", "<cmd>:TmuxNavigateDown<cr>", { desc = "Tmux Down" })

-- Tests
map("n", "<leader>tt", function()
  require("neotest").run.run()
end, { desc = "Run nearest test" })
map("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand "% ")
end, { desc = "Run file test" })
map("n", "<leader>to", ":Neotest output<CR>", { desc = "Show test output" })
map("n", "<leader>ts", ":Neotest summary<CR>", { desc = "Show test summary" })

-- Debug
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle Debug UI" })
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
map("n", "<leader>ds", function()
  require("dap").continue()
end, { desc = "Start" })
map("n", "<leader>dn", function()
  require("dap").step_over()
end, { desc = "Step Over" })

-- Git
map("n", "<leader>gl", ":Flog<CR>", { desc = "Git Log" })
map("n", "<leader>gf", ":DiffviewFileHistory<CR>", { desc = "Git File History" })
map("n", "<leader>gc", ":DiffviewOpen HEAD~1<CR>", { desc = "Git Last Commit" })
map("n", "<leader>gt", ":DiffviewToggleFile<CR>", { desc = "Git File History" })

-- Terminal
map("n", "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp", size = 0.4 }
end, { desc = "Toogle Terminal Vertical" })
map("n", "<C-\">", function()
  require("nvchad.term").toggle { pos = "sp", size = 0.4 }
end, { desc = "Toogle Terminal Horizontal" })
map("n", "<C-f>", function()
  require("nvchad.term").toggle { pos = "float" }
end, { desc = "Toogle Terminal Float" })
map("t", "<C-]>", function()
  require("nvchad.term").toggle { pos = "vsp" }
end, { desc = "Toogle Terminal Vertical" })
map("t", "<C-\">", function()
  require("nvchad.term").toggle { pos = "sp" }
end, { desc = "Toogle Terminal Horizontal" })
map("t", "<C-f>", function()
  require("nvchad.term").toggle { pos = "float" }
end, { desc = "Toogle Terminal Float" })

-- Basic
map("i", "jj", "<ESC>")
map("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })
