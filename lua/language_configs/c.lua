local vim = vim
local M = {}

M.plugins = {
  {
    'p00f/clangd_extensions.nvim',
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
