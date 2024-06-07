local vim = vim
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy file event
local Event = require 'lazy.core.handler.event'
Event.mappings.LazyFile = { id = 'LazyFile', event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' } }
Event.mappings['User LazyFile'] = Event.mappings.LazyFile

local lang_plugins = {}
local langs
if vim.fn.filereadable './lua/languages.lua' == 1 then
  langs = require 'languages'
else
  langs = { 'php', 'rust' }
end
for index, lang in ipairs(langs) do
  local plugins = require('language_configs.' .. lang)
  lang_plugins[index] = plugins.plugins
end
lang_plugins = vim.tbl_values(lang_plugins)
local file = io.open('debug', 'w')
file:write(vim.inspect(lang_plugins))
file:close()

-- [[ Configure plugins ]]
require('lazy').setup {
  lang_plugins,
  { import = 'plugins' },
}

-- Create autocmds
require 'autocmd'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
