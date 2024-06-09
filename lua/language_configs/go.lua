local vim = vim
local M = {}

M.plugins = {
  {
    'leoluz/nvim-dap-go',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
}

M.ensure_installed = {
  lspconfig = {
    'gopls',
  },
  null_ls = {
    'golangci_lint',
    'delve',
  },
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format)
  lspconfig.gopls.setup {
    capabilities = capabilities,
  }
end

return M
