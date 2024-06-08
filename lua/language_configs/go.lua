local vim = vim
local M = {}

M.plugins = {}

M.ensure_installed = {
  lspconfig = {
    'gopls',
  },
  null_ls = {
    'golangci_lint',
  },
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format)
  lspconfig.gopls.setup {
    capabilities = capabilities,
  }
end

return M
