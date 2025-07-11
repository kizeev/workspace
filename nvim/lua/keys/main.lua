local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- установить LeaderKey как ','
vim.g.mapleader = ','

-- отключить подсветку результата поиска
map('n', '<Leader><Space>', ':nohlsearch<CR>', opts)

-- установить "jk" как <Esc> во всех режимах
map('i', 'jk', '<Esc>', opts)
map('c', 'jk', '<C-c>', opts)
map('v', 'jk', '<Esc>', opts)

-- rename (var, func and etc) with lsp
vim.keymap.set('n', '<Leader>cr', vim.lsp.buf.rename)
