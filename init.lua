-- Set <space> as the leader key
-- See `:help mapleader`

-- [[ Setting options ]]
-- See `:help vim.o`
local vim = vim -- Exists to deal with weird lsp for vim api's

vim.opt.cursorline = true
vim.opt.whichwrap:append '<>[]hl'

vim.opt.termguicolors = true

-- Set highlight on search
vim.opt.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable relative line numbers
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true
-- Visual indicators
vim.opt.colorcolumn = '80'
-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
vim.opt.splitright = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect,preview'

-- Tab stuff
vim.opt.tabstop = 4      -- A TAB character looks like 4 spaces
vim.opt.softtabstop = 4  -- Number of spaces inserted instead of a TAB character
vim.opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.smarttab = true
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c' },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

vim.opt.list = true
vim.opt.pumblend = 20                  -- Popup opacity
vim.opt.pumheight = 10                 -- Number of visible items in popum menu
vim.opt.scrolloff = 5                  -- Keep a number of lines for context
vim.opt.sidescrolloff = 10             -- Columns of context
vim.opt.shiftround = true              -- Round indent
vim.opt.showmode = false               -- Status line does this
vim.opt.smartindent = true             -- Insert mode indents automatically
vim.opt.spelllang = { 'en' }           -- Spell check language
vim.opt.virtualedit = 'block'          -- Cursor can move to where there is no character in visual block mode
vim.opt.wildmode = 'longest:full,full' -- Command line completion mode
vim.opt.winminwidth = 5                -- Minimum window width

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
--
-- disable nvim intro
vim.opt.shortmess:append 'sI'

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
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

-- [[ Configure plugins ]]
require('lazy').setup {
  import = 'plugins',
}

-- Create mappings
require('utils').load_mappings()

-- Create autocmds
require 'autocmd'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
