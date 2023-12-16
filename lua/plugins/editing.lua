local utils = require 'utils'

return {
  -- Git related plugins
  'tpope/vim-fugitive',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  'mbbill/undotree',

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
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

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

  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {
      mappings = {
        basic = false,
        extra = false,
      },
    },
    config = function(_, opts)
      require('Comment').setup(opts)
      utils.load_mappings 'comment'
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      require 'plugins.configs.treesitter'
    end,
  },

  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    version = false,
    opts = {},
  },

  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    opts = {},
  },

  {
    'NvChad/nvterm',
    event = 'VeryLazy',
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

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'VeryLazy',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },
}

