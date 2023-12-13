local utils = require 'utils'

return {
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },

  {
    'tpope/vim-surround',
    lazy = false,
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ebug and [D]iagnostics', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it and [G]oto', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = '[H]arpoon and Git [H]unk', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename and [R]ust', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '[F]ind and [F]ormat', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>b'] = { name = '[B]lock', _ = 'which_key_ignore' },
      }

      -- register which-key VISUAL mode
      -- required for visual <leader>hs (hunk stage) to work
      require('which-key').register({
        ['<leader>'] = { name = 'VISUAL <leader>' },
        ['<leader>b'] = { name = '[B]lock', _ = 'which_key_ignore' },
        -- ['<leader>h'] = { 'Git [H]unk' },
      }, { mode = 'v' })
      require('which-key').setup {}
    end,
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '󰍵' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '│' },
      }, -- See `:help gitsigns.txt`
      on_attach = function(bufnr)
        require('utils').load_mappings('gitsigns', { buffer = bufnr })
      end,
    },
  },

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
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

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
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
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
}



