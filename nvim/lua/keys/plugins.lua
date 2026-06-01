local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- NvimTree
map('n', '<Leader>tf', ':NvimTreeFindFile<CR>', opts)

-- Telescope
map('n', '<Leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<Leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<Leader>fb', ':Telescope buffers<CR>', opts)
map('n', '<Leader>fh', ':Telescope help_tags<CR>', opts)

-- LazyGit
map('n', '<Leader>lg', ':LazyGit<CR>', opts)

-- flake8
map('n', '<Leader>fl', ':call flake8#Flake8()<CR>', opts)

-- namu (explorer)
map('n', '<Leader>tt', ':Namu ctags<CR>', opts)

-- claudecode
map('n', '<Leader>co', ':ClaudeCode<CR>', opts)
map('n', '<Leader>cs', ':ClaudeCodeSend<CR>', opts)
map('n', '<Leader>ca', ':ClaudeCodeAdd %<CR>', opts)
map('n', '<Leader>ct', ':ClaudeCodeTreeAdd<CR>', opts)
