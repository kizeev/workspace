local M = {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
        -- Custom registrations
        vim.filetype.add({
            extension = {
                csproj = "xml",
                esproj = "xml",
                keymap = "c",
                mdx = "markdown",
                uproject = "json",
                wsdl = "xml",
            },
        })

        -- Install a parser on first use rather than all ~300 supported
        -- languages on every startup (the previous approach: this plugin
        -- bundles queries for every language it supports, so walking its
        -- own runtime/queries directory and installing all of them ran a
        -- full ensure-installed pass over ~300 parsers on every launch)
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match) or args.match
                if not vim.tbl_contains(require("nvim-treesitter").get_available(), lang) then
                    return
                end
                if vim.tbl_contains(require("nvim-treesitter").get_installed(), lang) then
                    vim.treesitter.start(args.buf, lang)
                else
                    -- :wait() blocks the event loop, which errors when called
                    -- from inside a FileType autocmd (fires under textlock);
                    -- :await() installs without blocking and starts
                    -- highlighting once the parser is actually ready
                    require("nvim-treesitter").install(lang):await(function(err)
                        if not err and vim.api.nvim_buf_is_valid(args.buf) then
                            vim.treesitter.start(args.buf, lang)
                        end
                    end)
                end
            end,
        })
    end,
}

return { M }
