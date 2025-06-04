require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 45,
        float = {
            enable = true,
            open_win_config = {
                relative = "editor",
                width = 45,
                height = 40,
                row = 0,
            }
        }
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
})
