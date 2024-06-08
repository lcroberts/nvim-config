local vim = vim
local M = {}

M.plugins = {}

M.ensure_installed = {
  lspconfig = {
    'bashls',
  },
  null_ls = {
    'shfmt',
  },
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format)
  lspconfig.bashls.setup {
    capabilities = capabilities,
    filetypes = { 'sh' },
  }
end

return M
