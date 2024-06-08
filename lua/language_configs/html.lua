local vim = vim
local M = {}

M.plugins = {}

M.ensure_installed = {
  lspconfig = {},
  null_ls = {},
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format)
  lspconfig.html.setup {
    capabilities = capabilities_no_format,
    filetypes = { 'html', 'blade' },
  }

  lspconfig.emmet_language_server.setup {
    capabilities = capabilities_no_format,
  }
end

return M
