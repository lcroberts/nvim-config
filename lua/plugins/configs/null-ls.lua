local null_ls = require 'null-ls'
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup {
  sources = {
    -- lua
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.selene.with {
      diagnostic_config = {
        update_in_insert = false,
      },
    },

    -- bash
    null_ls.builtins.formatting.shfmt,

    -- go
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.code_actions.impl,
    null_ls.builtins.diagnostics.golangci_lint.with {
      diagnostic_config = {
        update_in_insert = false,
      },
    },

    -- php
    null_ls.builtins.formatting.pint,
    null_ls.builtins.formatting.blade_formatter,
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
