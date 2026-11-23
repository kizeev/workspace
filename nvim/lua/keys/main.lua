local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- leader key: ','
vim.g.mapleader = ','

-- clear search highlight
map('n', '<Leader><Space>', ':nohlsearch<CR>', vim.tbl_extend('force', opts, { desc = 'Clear search highlight' }))

-- "jk" as <Esc> in insert, command-line and visual modes
map('i', 'jk', '<Esc>', opts)
map('c', 'jk', '<C-c>', opts)
map('v', 'jk', '<Esc>', opts)
