-- отключаем netrw для плагина nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('keys/main')
require('keys/plugins')
require('config.lazy')

require('base/search')
require('base/tabs')
require('base/other')
