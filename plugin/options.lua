-- Set <space> as the leader keyinit
-- See `:help mapleader`
-- [[ Setting options ]]
local opt = vim.opt

opt.wrap = false
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

-- Enable break indent
opt.breakindent = true
-- Visual indicators
opt.colorcolumn = '120'
-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
opt.splitright = true
opt.splitbelow = true

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect,preview'

-- Tab stuff
opt.tabstop = 4 -- A TAB character looks like 4 spaces
opt.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
opt.shiftwidth = 0
opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
opt.smarttab = true

vim.g.editorconfig = true
vim.g.editorconfig_trim_trailing_whitespace = true
vim.g.editorconfig_insert_final_newline = false

opt.list = true
opt.fillchars:append { eob = ' ' }

opt.pumblend = 10 -- Popup opacity
opt.pumheight = 10 -- Number of visible items in popum menu
opt.scrolloff = 8 -- Keep a number of lines for context
opt.sidescrolloff = 8 -- Columns of context
opt.shiftround = true -- Round indent
opt.showmode = false -- Status line does this
opt.smartindent = true -- Insert mode indents automatically
opt.spelllang = { 'en' } -- Spell check language
opt.virtualedit = 'block' -- Cursor can move to where there is no character in visual block mode
opt.wildmode = 'longest:full,full' -- Command line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.nrformats = 'bin,hex,alpha'

opt.undofile = true
opt.backup = true
opt.backupdir:remove('.')

-- disable nvim intro
opt.shortmess:append 'sI'
