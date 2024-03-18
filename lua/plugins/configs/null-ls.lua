local null_ls = require 'null-ls'

null_ls.setup {
  sources = {
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
    null_ls.builtins.diagnostics.golangci_lint.with {
      diagnostic_config = {
        update_in_insert = false,
      },
    },

    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.alejandra,
  },
}
