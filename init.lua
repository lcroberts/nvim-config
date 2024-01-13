-- Set <space> as the leader key
-- See `:help mapleader`

-- [[ Setting options ]]
local opt = vim.opt

opt.whichwrap:append '<>[]hl'

opt.termguicolors = true

-- Set highlight on search
opt.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable relative line numbers
opt.relativenumber = true

-- Enable mouse mode
opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
opt.clipboard = 'unnamedplus'

-- Enable break indent
opt.breakindent = true
-- Visual indicators
opt.colorcolumn = '80'
-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
opt.splitright = true

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect,preview'

-- Tab stuff
opt.tabstop = 4      -- A TAB character looks like 4 spaces
opt.softtabstop = 4  -- Number of spaces inserted instead of a TAB character
opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
opt.smarttab = true
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'go' },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

opt.list = true
opt.pumblend = 10                  -- Popup opacity
opt.pumheight = 10                 -- Number of visible items in popum menu
opt.scrolloff = 5                  -- Keep a number of lines for context
opt.sidescrolloff = 10             -- Columns of context
opt.shiftround = true              -- Round indent
opt.showmode = false               -- Status line does this
opt.smartindent = true             -- Insert mode indents automatically
opt.spelllang = { 'en' }           -- Spell check language
opt.virtualedit = 'block'          -- Cursor can move to where there is no character in visual block mode
opt.wildmode = 'longest:full,full' -- Command line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.conceallevel = 1

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable nvim intro
opt.shortmess:append 'sI'

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
opt.rtp:prepend(lazypath)

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
