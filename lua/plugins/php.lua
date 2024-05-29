return {
  {
    'jwalton512/vim-blade',
    ft = 'blade',
  },
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
    keys = {
      { '<leader>la', ':Laravel artisan<cr>' },
      { '<leader>lr', ':Laravel routes<cr>' },
      { '<leader>lm', ':Laravel related<cr>' },
    },
    event = { 'VeryLazy' },
    config = true,
  },
  {
    'phpactor/phpactor',
    ft = { 'php', 'blade' },
    build = 'composer install --no-dev -o',
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {
      per_filetype = {
        ['php'] = {
          enable_close = true,
        },
        ['blade'] = {
          enable_close = true,
        },
      },
    },
  },
}
