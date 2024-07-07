local vim = vim
local M = {}

M.plugins = {
  {
    'pmizio/typescript-tools.nvim',
    ft = { 'js', 'ts', 'jsx', 'tsx' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
}

M.ensure_installed = {
  lspconfig = {
    'tsserver',
  },
  null_ls = {},
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format) end

return M
