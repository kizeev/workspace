return {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
        { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Split/Join toggle" },
    },
    opts = {
        use_default_keymaps = false,
    },
}
