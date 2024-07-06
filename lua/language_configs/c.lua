local vim = vim
local M = {}

M.plugins = {
  {
    'p00f/clangd_extensions.nvim',
    opts = {},
  },
}

M.ensure_installed = {
  lspconfig = {
    'clangd',
  },
  null_ls = {
    'codelldb',
  },
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format)
  capabilities.offsetEncoding = 'utf-8'
  lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
      client.server_capabilities.signgatureHelpProvider = false
    end,
    capabilities = capabilities,
  }
end

return M
