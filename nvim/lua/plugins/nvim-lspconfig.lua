return {
  "neovim/nvim-lspconfig",
  dependencies = { 'saghen/blink.cmp' },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    vim.lsp.config('*', { capabilities = capabilities })
    vim.lsp.enable('pyright')

    -- Create a custom, bulletproof restart command
    vim.api.nvim_create_user_command('LspRestart', function()
      -- Get all active clients attached to the current buffer
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      for _, client in ipairs(clients) do
        local configs = vim.lsp.config.get(client.name)
        if configs then
          client:stop(true) -- Force stop the client
          -- Wait a brief moment and restart it
          vim.defer_fn(function()
            vim.lsp.enable(client.name)
          end, 100)
        end
      end
      print("LSP restarted!")
    end, {})
  end,
}
