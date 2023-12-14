local utils = require 'utils'

return {

  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  'tpope/vim-surround',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'mbbill/undotree',

  {
    'williamboman/mason.nvim',
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
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
    opts = {
      ensure_installed = {
        'stylua',
        'cpplint',
        'selene',
        'vale',
        'typos',
        'vale',
        'trivy',
        'cpplint',
        'clang_format',
        'prettier',
        'beautysh',
        'shellcheck',
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
    opts = {
      ensure_installed = {
        -- 'rust_analyzer',
        'bashls',
        'pylsp',
        'yamlls',
        'lua_ls',
        'taplo',
        'clangd',
        'tailwindcss',
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
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',

      -- Additional lua configuration, makes nvim stuff amazing!
      {
        'folke/neodev.nvim',
        opts = {},
      },
    },
    config = function()
      require 'plugins.configs.lspconfig'
    end,
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      exclude = {
        filetypes = {
          'dashboard',
        },
      },
    },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {
      mappings = {
        basic = false,
        extra = false,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      require 'plugins.configs.treesitter'
    end,
  },

  {
    'windwp/nvim-autopairs',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  {
    'NvChad/nvterm',
    opts = {},
  },

  -- Lua
  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {},
    config = function(_, opts)
      require('persistence').setup(opts)
      utils.load_mappings 'persistence'
    end,
  },
}

