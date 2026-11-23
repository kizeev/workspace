--[[ Search ]]--
-- Case-insensitive search: "ignore" also finds "IGNORE"
vim.opt.ignorecase = true

-- ...unless the pattern has uppercase letters: "Ignore" finds only "Ignore"
vim.opt.smartcase = true

-- Briefly jump to the matching bracket when one is inserted
vim.opt.showmatch = true
