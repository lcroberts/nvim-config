local vim = vim

return {
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    opts = {
      max_concurrent_installers = 10,
      automatic_installation = true,
    },
    config = function(_, opts)
      require('mason').setup(opts)
    end,
  },

  {
    'jay-babu/mason-null-ls.nvim',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
    opts = {
      ensure_installed = require('language_utils').ensure_installed.null_ls,
    },
    automatic_installation = true,
    config = function(_, opts)
      require('mason-null-ls').setup(opts)
      require 'plugins.configs.null-ls'
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    opts = {
      ensure_installed = require('language_utils').ensure_installed.lspconfig,
    },
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
    end,
  },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = 'LazyFile',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'b0o/schemastore.nvim',
    },
    config = function()
      require 'plugins.configs.lspconfig'
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'LazyFile',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'onsails/lspkind-nvim',

      {
        'L3MON4D3/LuaSnip',
        -- follow latest release.
        version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = 'make install_jsregexp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        opts = {},
        config = function(_, opts)
          require('luasnip').setup(opts)

          -- Prevent cursed af snippet behavior
          vim.api.nvim_create_autocmd('ModeChanged', {
            pattern = '*',
            callback = function()
              if
                ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
                and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
                and not require('luasnip').session.jump_active
              then
                require('luasnip').unlink_current()
              end
            end,
          })
        end,
      },
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require 'plugins.configs.cmp'
    end,
  },
}
