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
      ensure_installed = {
        'stylua',
        'selene',
        'trivy',
        'prettier',
        'shfmt',
        'golangci_lint',
        'glow',
        'pint',
        'blade_formatter',
      },
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
      ensure_installed = {
        'bashls',
        'pylsp',
        'yamlls',
        'lua_ls',
        'taplo',
        'clangd',
        'tailwindcss',
        'gopls',
        'typos_lsp',
        'tsserver',
        'intelephense',
        'jsonls',
        'html',
        'sqlls',
        'cssls',
        'emmet_language_server',
      },
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

      -- Additional lua configuration, makes nvim stuff amazing!
      {
        'folke/neodev.nvim',
        opts = {
          library = {
            plugins = { 'neotest' },
            types = true,
          },
        },
      },
      {
        'p00f/clangd_extensions.nvim',
        opts = {},
      },
      {
        'pmizio/typescript-tools.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
      },
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
        'Jezda1337/cmp_bootstrap',
        config = function()
          require('bootstrap-cmp.config'):setup {
            file_types = { 'html', 'css' },
          }
        end,
      },

      {
        'L3MON4D3/LuaSnip',
        -- follow latest release.
        version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = 'make install_jsregexp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        opts = {
          exit_roots = true,
        },
      },
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require 'plugins.configs.cmp'
    end,
  },
}
