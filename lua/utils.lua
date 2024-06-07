local M = {}

M.get_lang_plugins = function()
  local lang_plugins = {}
  local langs
  if vim.fn.filereadable './languages.lua' == 1 then
    langs = require 'languages'
  else
    langs = {}
  end
  for index, lang in ipairs(langs) do
    local plugins = require('language_configs.' .. lang)
    lang_plugins[index] = plugins.plugins
  end
  lang_plugins = vim.tbl_values(lang_plugins)
  return lang_plugins
end

return M
