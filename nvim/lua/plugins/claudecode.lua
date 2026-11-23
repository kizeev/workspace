return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    -- load on startup so the `claude` CLI can connect to nvim at any time,
    -- not only after a :ClaudeCode* command has been run
    lazy = false,
    opts = {},
  },
}
