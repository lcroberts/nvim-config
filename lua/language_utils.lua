local vim = vim
local M = {}

M.languages = { 'defaults' }
local ok, langs = pcall(require, 'languages')
if not ok then
  langs = {}
end
for _, value in ipairs(langs) do
  table.insert(M.languages, value)
end

local lsp_setup_functions = {}

M.null_ls_sources = {}

M.ensure_installed = {
  lspconfig = {},
  null_ls = {},
}

M.lang_plugins = {}
for index, lang in ipairs(M.languages) do
  local module = 'language_configs.' .. lang
  local ok, plugins = pcall(require, module)
  if not ok then
    plugins = {}
    vim.api.nvim_err_writeln(lang .. ' is not supported or an error occurred')
  end
  M.lang_plugins[index] = plugins.plugins
  table.insert(lsp_setup_functions, plugins.lsp_config)

  for _, value in ipairs(plugins.ensure_installed.lspconfig) do
    table.insert(M.ensure_installed.lspconfig, value)
  end

  for _, value in ipairs(plugins.ensure_installed.null_ls) do
    table.insert(M.ensure_installed.null_ls, value)
  end
end

M.lang_plugins = vim.tbl_values(M.lang_plugins)

M.setup_lsp = function(lspconfig, capabilities, capabilities_no_format)
  for _, setup in ipairs(lsp_setup_functions) do
    setup(lspconfig, capabilities, capabilities_no_format)
  end
end

return M
