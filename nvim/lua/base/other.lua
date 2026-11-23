--[[ Splits ]]--
-- Vertical splits open to the right (by default the position depends on the
-- current window, this keeps the layout predictable)
vim.opt.splitright = true

-- Horizontal splits open below
vim.opt.splitbelow = true


--[[ Misc ]]--
-- Keep undo history between sessions
vim.opt.undofile = true

-- Use the system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Don't add a missing newline at the end of the file
vim.opt.fixeol = false

-- Built-in completion menu behavior
vim.opt.completeopt = 'menuone,noselect'

-- Don't continue comments automatically on new lines
vim.cmd("autocmd BufEnter * set fo-=c fo-=r fo-=o")

-- Line numbers
vim.opt.number = true 

-- Relative line numbers
vim.opt.relativenumber = true 

-- Enable the mouse
vim.opt.mouse = "a"

-- No swap files
vim.opt.swapfile = false 

-- Encoding
vim.opt.encoding = "utf-8" 

-- Keep 7 lines visible above/below the cursor
vim.opt.scrolloff = 7 

-- Command-line history of 1000 entries
vim.opt.history = 1000 

-- Show a 79-column ruler in Python files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt.colorcolumn = "79"
  end,
})

-- 24-bit color
vim.opt.termguicolors = true

-- Enable folding
vim.opt.foldenable = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99

vim.opt.foldtext = ''

-- Reload the file from disk if it changed outside nvim (e.g. edits by another tool)
vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "checktime",
})
