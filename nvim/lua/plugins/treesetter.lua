require('nvim-treesitter.configs').setup{
    ensure_installed = { "python", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "bash", "csv", "dockerfile", "dot", "git_config", "gitignore", "html", "json", "sql", "tmux", "xml", "yaml" },
    highlight = {
        enable = true,              -- false will disable the whole extension
    },
-- additional configuration here
}
