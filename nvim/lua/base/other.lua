--[[ Настройка панелей ]]--
-- Вертикальные сплиты становятся справа
-- По умолчанию панели в Neovim ставятся в зависимости от расположения текущей панели. Данная настройка поможет нам держать панели в порядке
vim.opt.splitright = true

-- Горизонтальные сплиты становятся снизу
vim.opt.splitbelow = true


--[[ Дополнительные настройки ]]--
-- Используем системный буфер обмена
vim.opt.clipboard = 'unnamedplus'

-- Отключаем дополнение файлов в конце
vim.opt.fixeol = false

-- Автодополнение (встроенное в Neovim)
vim.opt.completeopt = 'menuone,noselect'

-- Не автокомментировать новые линии при переходе на новую строку
vim.cmd("autocmd BufEnter * set fo-=c fo-=r fo-=o")

-- показать номер строки
vim.opt.number = true 

-- показать относительные номера строк
vim.opt.relativenumber = true 

-- включить мышь
vim.opt.mouse = "a"

-- не создавать swap файл при открытии
vim.opt.swapfile = false 

-- кодировка
vim.opt.encoding = "utf-8" 

-- прокручивать на 7 строк до низа экрана
vim.opt.scrolloff = 7 

-- история в 1000 строк
vim.opt.history = 1000 

-- показать границу строки в файлах python в 79 символов
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt.colorcolumn = "79"
  end,
})

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Enable folding
vim.opt.foldenable = true
vim.opt.foldmethod = 'indent'  -- or 'syntax', 'marker', 'expr'
vim.opt.foldlevel = 99  -- Open all folds by default
