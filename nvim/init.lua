-- отключаем netrw для плагина nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



require('base/search')
require('base/tabs')
require('base/other')

require('keys/main')
require('keys/plugins')

require('plugins/packer_install')
require('plugins/color')
require('plugins/nvim-tree')
require('plugins/treesetter')
require('plugins/goto-preview')
require('plugins/nvim-cmp')
