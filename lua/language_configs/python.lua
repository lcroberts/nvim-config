local vim = vim
local M = {}

M.plugins = {}

M.ensure_installed = {
  lspconfig = {
    'pylsp',
  },
  null_ls = {},
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format)
  lspconfig.pylsp.setup {
    capabilities = capabilities,
  }
end

return M
