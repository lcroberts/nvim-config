local vim = vim

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'last_loc',
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'wrap_spell',
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- [[ Highlight on yank ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = augroup 'YankHighlight',
  pattern = '*',
})

-- dont list quickfix buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  group = augroup 'NoListQuickFix',
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('help_window_right', {}),
  pattern = { '*.txt' },
  callback = function()
    if vim.o.filetype == 'help' then
      vim.cmd.wincmd 'L'
    end
  end,
})
