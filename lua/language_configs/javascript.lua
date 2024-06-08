local vim = vim
local M = {}

M.plugins = {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
}

M.null_ls_sources = {}

M.ensure_installed = {
  lspconfig = {},
  null_ls = {},
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format) end

return M
