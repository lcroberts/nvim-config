-- Mapping mode: n (normal), x (visual), i (insert), c (command)
local vim = vim -- Deal with lsp for vim api

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to clipboard' })
vim.keymap.set({ 'n' }, '<leader>Y', [["+Y]], { desc = 'Yank line to clipboard' })
vim.keymap.set({ 'n' }, '<leader>p', [["+p]], { desc = 'Paste from clipboard' })
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without yanking' })
vim.keymap.set('x', '<leader>P', [["_d"+P]], { desc = 'Paste from clipboard without yanking' })

vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>zz', { desc = 'Next in quickfix list' })
vim.keymap.set('n', '<C-p>', '<cmd>cprev<CR>zz', { desc = 'Prev in quickfix list' })
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'Next in location list' })
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = 'Prev in location list' })

vim.keymap.set({ 'n' }, '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = 'window left' })
vim.keymap.set({ 'n' }, '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = 'window right' })
vim.keymap.set({ 'n' }, '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = 'window down' })
vim.keymap.set({ 'n' }, '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = 'window up' })

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'x' }, '<Space>', '<Nop>', { silent = true })
-- Clear highlights
vim.keymap.set({ 'n' }, '<Esc>', '<cmd> noh<cr>', { desc = 'Clear highlights' })
-- Remap for dealing with word wrap
vim.keymap.set({ 'n' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ 'n' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ 'n' }, '<C-u>', '<C-u>zz', { silent = true })
vim.keymap.set({ 'n' }, '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set({ 'n' }, 'n', 'nzzzv', { silent = true })
vim.keymap.set({ 'n' }, 'N', 'Nzzzv', { silent = true })

-- Netrw
vim.keymap.set({}, '<leader>nn', '<cmd>Ntree<cr>', { desc = 'Open Netrw' })

-- UFO
vim.keymap.set({ 'n' }, 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
vim.keymap.set({ 'n' }, 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })

-- Undo Tree
vim.keymap.set({ 'n' }, '<leader>tu', vim.cmd.UndotreeToggle, { desc = 'Toggle undo tree' })
-- Trouble toggle
vim.keymap.set({ 'n' }, '<leader>tt', vim.cmd.TroubleToggle, { desc = 'Toggle trouble' })
-- Vim Fugitive (Git)
vim.keymap.set({ 'n' }, '<leader>gs', vim.cmd.Git, { desc = 'Open git' })

vim.keymap.set({ 'x' }, 'A', ':s/$/', { desc = 'Append to lines' })

-- Move visual selection around
vim.keymap.set({ 'x' }, 'H', '<gv', { desc = 'Move selection left' })
vim.keymap.set({ 'x' }, 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set({ 'x' }, 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set({ 'x' }, 'L', '>gv', { desc = 'Move selection right' })

-- Navigate in insert mode
vim.keymap.set({ 'i' }, '<C-h>', '<Left>', { desc = 'Move left' })
vim.keymap.set({ 'i' }, '<C-l>', '<Right>', { desc = 'Move right' })
vim.keymap.set({ 'i' }, '<C-j>', '<Down>', { desc = 'Move down' })
vim.keymap.set({ 'i' }, '<C-k>', '<Up>', { desc = 'Move up' })
vim.keymap.set({ 'i' }, '<C-b>', '<Esc>_i', { desc = 'Beginning of line' })
vim.keymap.set({ 'i' }, '<C-e>', '<End>', { desc = 'End of line' })
vim.keymap.set({ 'i' }, '<A-;>', '<End>;', { desc = 'Append Semicolon' })
vim.keymap.set({ 'i' }, '<A-,>', '<End>,', { desc = 'Append Comma' })

vim.keymap.set({ 'c' }, '<M-/>', [[\/]], { desc = 'Insert escaped slash' })
