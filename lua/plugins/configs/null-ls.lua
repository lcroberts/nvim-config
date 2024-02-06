local null_ls = require 'null-ls'
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.typos.with {
      diagnostic_config = {
        update_in_insert = false,
      },
    },
    null_ls.builtins.diagnostics.trivy.with {
      diagnostic_config = {
        update_in_insert = false,
      },
    },
    null_ls.builtins.diagnostics.selene.with {
      diagnostic_config = {
        update_in_insert = false,
      },
    },
    -- null_ls.builtins.diagnostics.cpplint.with {
    --   args = { '--filter=-legal', '$FILENAME' },
    --   diagnostic_config = {
    --     update_in_insert = false,
    --   },
    -- },
    null_ls.builtins.diagnostics.shellcheck.with {
      diagnostic_config = {
        update_in_insert = false,
      },
    },
    null_ls.builtins.diagnostics.golangci_lint.with {
      diagnostic_config = {
        update_in_insert = false,
      },
    },

    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.beautysh,
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.formatting.trim_newlines,
    null_ls.builtins.formatting.gofmt,
  },

  on_attach = function(client, bufnr)
    if client.supports_method 'textDocument/formatting' then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
          vim.lsp.buf.format { async = false }
        end,
      })
    end
  end,
}
