local vim = vim
require 'keymaps'
require 'options'

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

-- [[ Configure plugins ]]
require('lazy').setup {
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { 'catppuccin-mocha' },
  },
  spec = {
    require('language_utils').lang_plugins,
    { import = 'plugins' },
  },
}

-- Create autocmds
require 'autocmd'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
