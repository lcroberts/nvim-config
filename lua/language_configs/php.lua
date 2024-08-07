local vim = vim
local M = {}

M.plugins = {
  {
    'adalessa/laravel.nvim',
    ft = { 'php', 'blade' },
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'tpope/vim-dotenv',
      'MunifTanjim/nui.nvim',
      'nvimtools/none-ls.nvim',
    },
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

M.ensure_installed = {
  lspconfig = {
    'intelephense',
  },
  null_ls = {
    'pint',
    'blade_formatter',
  },
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format)
  lspconfig.intelephense.setup {
    capabilities = capabilities_no_format,
    filetypes = { 'php', 'blade' },
  }
end

return M
