return {
    dir = "~",
    name = "vifm-wrapper",
    keys = {
        {
            "<leader>e",
            function()
                local buf = vim.api.nvim_create_buf(false, true)
                local width = math.floor(vim.o.columns * 0.8)
                local height = math.floor(vim.o.lines * 0.8)
                vim.api.nvim_open_win(buf, true, {
                    relative = "editor",
                    width = width,
                    height = height,
                    row = math.floor((vim.o.lines - height) / 2),
                    col = math.floor((vim.o.columns - width) / 2),
                    style = "minimal",
                    border = "rounded",
                })
                local tmpfile = vim.fn.tempname()
                local cwd = vim.fn.expand("%:p:h")
                if cwd == "" or vim.fn.isdirectory(cwd) == 0 then cwd = vim.fn.getcwd() end
                vim.fn.termopen("vifm --choose-files " .. tmpfile .. " " .. vim.fn.shellescape(cwd), {
                    on_exit = function()
                        vim.api.nvim_buf_delete(buf, { force = true })
                        if vim.fn.filereadable(tmpfile) == 1 then
                            local files = vim.fn.readfile(tmpfile)
                            for _, f in ipairs(files) do
                                if f ~= "" then vim.cmd("edit " .. vim.fn.fnameescape(f)) end
                            end
                            vim.fn.delete(tmpfile)
                        end
                    end,
                })
                vim.cmd("startinsert")
            end,
            desc = "Vifm (floating)",
        },
    },
}
