-- подключаем Packer как пакет
vim.cmd("packadd packer.nvim")

-- функция для установки плагинов
return require('packer').startup(function()
    -- добавляем Packer в список, чтобы он обновлял сам себя
    use 'wbthomason/packer.nvim'
    -- автосохранение
    use 'Pocco81/auto-save.nvim'
    -- цветовая схема
    use 'morhetz/gruvbox'
    -- файловый менеджер
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {'nvim-tree/nvim-web-devicons'}, -- optional
    }
    -- работа со скобками, кавычками и т.п.
    use 'tpope/vim-surround'
    -- показать структуру файла
    use 'preservim/tagbar'
    -- flake8
    use 'nvie/vim-flake8'
    -- плагин для поиска
    -- start
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = {'nvim-lua/plenary.nvim'},
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }
    -- end
    -- LSP
    use 'neovim/nvim-lspconfig'
    -- предпросмотр функций
    use 'rmagatti/goto-preview'
    -- автодополнение
    -- start
    use 'hrsh7th/nvim-cmp' -- основной плагин автодополнения
    use 'hrsh7th/cmp-nvim-lsp' -- источник автодополнения из LSP
    use 'hrsh7th/cmp-buffer' -- источник автодополнения из содержимого текущего буфера
    use 'hrsh7th/cmp-path' -- источник автодополнения для файловых путей
    use 'hrsh7th/cmp-cmdline' -- источник автодополнения для командной строки
    use 'L3MON4D3/LuaSnip' -- плагин для сниппетов, рекомендуется для использования с nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- источник автодополнения для LuaSnip
    -- end
end)
