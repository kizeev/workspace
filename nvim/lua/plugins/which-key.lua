return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spec = {
            { "<leader>f", group = "Find (telescope)" },
            { "<leader>t", group = "Tree" },
            { "<leader>v", group = "LSP" },
            { "<leader>d", group = "Diagnostics" },
        },
    },
    keys = {
        {
            "<leader>?",
            function() require("which-key").show({ global = false }) end,
            desc = "Buffer-local keymaps (which-key)",
        },
    },
}
