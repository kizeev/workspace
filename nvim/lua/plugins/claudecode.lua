return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    -- Remove 'config = true' if you want it to load instantly, 
    -- or keep it if you want it to lazy-load on keypress.
    lazy = false, -- Uncomment this if you want it to force-load on startup
    opts = {}, -- This automatically calls require("claudecode").setup({})
    -- keys = {
    --   { "<leader>cl", desc = "AI/Claude Code" }, -- Removed 'nil' as it's redundant
    --   { "<leader>ct", ":ClaudeCode<cr>", desc = "Toggle Claude" },
    --   { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    --   { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    --   { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    --   { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    --   { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    --   { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    --   -- Fixed file-tree specific keymap below
    --   {
    --     "<leader>at", -- Changed from <leader>as to avoid duplicate conflict
    --     "<cmd>ClaudeCodeTreeAdd<cr>",
    --     desc = "Add file from tree",
    --     ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    --   },
    --   -- Diff management
    --   { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    --   { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    -- },
  },
}
