return {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
        require("illuminate").configure({})

        -- default background highlight blends into gruvbox; underline is
        -- theme-agnostic and stays visible regardless of colorscheme
        local hl = { underline = true, bg = "NONE" }
        vim.api.nvim_set_hl(0, "IlluminatedWordText", hl)
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", hl)
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", hl)
    end,
}
