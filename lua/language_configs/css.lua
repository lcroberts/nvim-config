local vim = vim
local M = {}

M.plugins = {}

M.ensure_installed = {
  lspconfig = {
    'tailwindcss',
    'cssls',
  },
  null_ls = {},
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format)
  lspconfig.cssls.setup {
    capabilities = capabilities_no_format,
  }

  lspconfig.tailwindcss.setup {
    capabilities = capabilities,
  }
end

return M
