return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ruff" },
      })

      -- Modern Approach: Setup pyright via vim.lsp.config
      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git", vim.fn.getcwd() },
        settings = {
          python = {
            -- fall back for a `.venv` at the project root; pyright doesn't
            -- pick up an activated venv from the shell it was spawned in
            venvPath = ".",
            venv = ".venv",
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
        before_init = function(_, config)
          local venv_python = config.root_dir .. "/.venv/bin/python"
          if vim.fn.executable(venv_python) == 1 then
            config.settings.python.pythonPath = venv_python
          end

          -- pyright's root_dir lands on the first ancestor with a
          -- pyproject.toml/.git etc, which can be a namespace-package dir
          -- (no __init__.py) whose imports are only resolvable with its
          -- parent directory on the analysis path (e.g. `from crawlers
          -- import x` inside a `<repo>/crawlers/` with no __init__.py)
          config.settings.python.analysis.extraPaths = {
            vim.fn.fnamemodify(config.root_dir, ":h"),
          }
        end,
      })

      -- ruff handles linting/fixes; pyright stays for type-checking (disable
      -- pyright's own hover so ruff's doesn't get shadowed)
      vim.lsp.config("ruff", {
        cmd = { "ruff", "server", "--preview" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
      })

      -- Enable them globally so they attach automatically on FileType match
      vim.lsp.enable("pyright")
      vim.lsp.enable("ruff")

      -- Unified Autocommand for Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local function opts(desc)
            return { buffer = args.buf, remap = false, desc = desc }
          end

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Goto definition"))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover"))
          vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts("Workspace symbol"))
          vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts("Line diagnostics"))
          vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts("Next diagnostic"))
          vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts("Prev diagnostic"))
          vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts("Code action"))
          vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts("References"))
          vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts("Rename"))
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts("Signature help"))

          -- format via ruff only — pyright doesn't implement formatting, and
          -- letting both clients answer a format request risks double edits
          vim.keymap.set("n", "<leader>vf", function()
            vim.lsp.buf.format({
              async = true,
              filter = function(client) return client.name == "ruff" end,
            })
          end, opts("Format buffer (ruff)"))
        end,
      })
    end,
  },
}
