local vim = vim
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-n>'] = require('telescope.actions').move_selection_next,
        ['<C-p>'] = require('telescope.actions').move_selection_previous,
      },
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    path_display = { 'truncate' },
    color_devicons = true,
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- Custom live_grep function to search in git root
local function enter_config()
  local config_dir = vim.fn.stdpath 'config'
  vim.api.nvim_exec('cd ' .. config_dir, {})
  require('telescope.builtin').find_files { cwd = config_dir }
end

vim.api.nvim_create_user_command('EnterConfig', enter_config, {})

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

vim.keymap.set({ 'n' }, '<leader>fo', require('telescope.builtin').oldfiles, { desc = '[f]ind recently [o]pened files' })
vim.keymap.set({ 'n' }, '<leader>fb', require('telescope.builtin').buffers, { desc = '[f]ind existing [b]uffers' })
vim.keymap.set({ 'n' }, '<leader>ff', require('telescope.builtin').find_files, { desc = '[f]ind [f]iles' })
vim.keymap.set({ 'n' }, '<leader>ft', telescope_live_grep_open_files, { desc = '[f]ind [t]ext' })
vim.keymap.set({ 'n' }, '<leader>fh', require('telescope.builtin').help_tags, { desc = '[f]ind [h]elp page' })
vim.keymap.set({ 'n' }, '<leader>fw', require('telescope.builtin').grep_string, { desc = '[f]ind current [w]ord' })
vim.keymap.set({ 'n' }, '<leader>fg', require('telescope.builtin').live_grep, { desc = '[f]ind by [g]rep' })
vim.keymap.set({ 'n' }, '<leader>fG', ':LiveGrepGitRoot<cr>', { desc = '[f]ind by [G]rep on Git Root' })
vim.keymap.set({ 'n' }, '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[f]ind [d]iagnostics' })
vim.keymap.set({ 'n' }, '<leader>fr', require('telescope.builtin').resume, { desc = '[f]ind [r]esume' })
vim.keymap.set({ 'n' }, '<leader>f/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[f]uzzily search [/] in current buffer' })

vim.keymap.set({ 'n' }, '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
-- Theme search
vim.keymap.set({ 'n' }, '<leader>th', require('telescope.builtin').colorscheme, { desc = '[t]heme search' })
