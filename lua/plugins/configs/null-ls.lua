local null_ls = require 'null-ls'

null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.vale.with({
      diagnostic_config = {
        update_in_insert = false,
      },
    }),
    null_ls.builtins.diagnostics.typos.with({
      diagnostic_config = {
        update_in_insert = false,
      },
    }),
    null_ls.builtins.diagnostics.trivy.with({
      diagnostic_config = {
        update_in_insert = false,
      },
    }),
    null_ls.builtins.diagnostics.selene.with({
      diagnostic_config = {
        update_in_insert = false,
      },
    }),
    null_ls.builtins.diagnostics.cpplint.with({
      diagnostic_config = {
        update_in_insert = false,
      },
    }),
    null_ls.builtins.diagnostics.shellcheck.with({
      diagnostic_config = {
        update_in_insert = false,
      },
    }),

    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.beautysh,
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.formatting.trim_newlines,
  },
}
