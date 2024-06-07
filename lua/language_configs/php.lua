local vim = vim
local M = {}

M.plugins = {
  {
    'adalessa/laravel.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'tpope/vim-dotenv',
      'MunifTanjim/nui.nvim',
      'nvimtools/none-ls.nvim',
    },
    ft = { 'php', 'blade' },
    cmd = { 'Sail', 'Artisan', 'Composer', 'Npm', 'Yarn', 'Laravel' },
    keys = {},
    opts = {
      lsp_server = 'intelephense',
    },
  },
  {
    'phpactor/phpactor',
    ft = { 'php', 'blade' },
    build = 'composer install --no-dev -o',
    config = function()
      vim.keymap.set('n', '<leader>pm', ':PhpactorContextMenu<CR>')
    end,
  },
}

return M