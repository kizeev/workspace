local opts = {noremap = true, silent = true}

local function map(mode, lhs, rhs, desc)
  vim.api.nvim_set_keymap(mode, lhs, rhs, vim.tbl_extend('force', opts, { desc = desc }))
end

-- NvimTree
map('n', '<Leader>tf', ':NvimTreeFindFile<CR>', 'Find file in tree')

-- Telescope
map('n', '<Leader>ff', ':Telescope find_files<CR>', 'Find files')
map('n', '<Leader>fg', ':Telescope live_grep<CR>', 'Live grep')
map('n', '<Leader>fb', ':Telescope buffers<CR>', 'Buffers')
map('n', '<Leader>fh', ':Telescope help_tags<CR>', 'Help tags')

-- structural kinds only (classes/functions/methods) so variables don't drown them out;
-- capital variants keep the full, unfiltered symbol list
local STRUCTURAL_SYMBOLS = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct" }

vim.keymap.set('n', '<Leader>fs', function()
  require('telescope.builtin').lsp_document_symbols({ symbols = STRUCTURAL_SYMBOLS })
end, vim.tbl_extend('force', opts, { desc = 'Symbols: classes/functions (buffer)' }))

vim.keymap.set('n', '<Leader>fS', function()
  require('telescope.builtin').lsp_document_symbols()
end, vim.tbl_extend('force', opts, { desc = 'Symbols: all (buffer)' }))

vim.keymap.set('n', '<Leader>fw', function()
  require('telescope.builtin').lsp_dynamic_workspace_symbols({ symbols = STRUCTURAL_SYMBOLS })
end, vim.tbl_extend('force', opts, { desc = 'Symbols: classes/functions (workspace)' }))

vim.keymap.set('n', '<Leader>fW', function()
  require('telescope.builtin').lsp_dynamic_workspace_symbols()
end, vim.tbl_extend('force', opts, { desc = 'Symbols: all (workspace)' }))

-- LazyGit (binding also declared in plugins/lazygit.lua's `keys` spec)

-- Diagnostics (pyright + ruff) — like the old flake8 quickfix window
map('n', '<Leader>dq', ':lua vim.diagnostic.setqflist({ open = true })<CR>', 'Diagnostics: all buffers (quickfix)')
map('n', '<Leader>dl', ':lua vim.diagnostic.setloclist({ open = true })<CR>', 'Diagnostics: current buffer (loclist)')
