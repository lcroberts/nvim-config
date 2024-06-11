local vim = vim
return {
  -- Git related plugins
  {
    'tpope/vim-rhubarb',
    dependencies = {
      {
        'tpope/vim-fugitive',
        config = function()
          vim.keymap.set({ 'n' }, '<leader>gs', vim.cmd.Git, { desc = 'Open git' })
        end,
      },
    },
  },

  -- Useful editor commands such as SudoWrite and SudoEdit
  'tpope/vim-eunuch',

  -- Multicursor support
  'mg979/vim-visual-multi',

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set({ 'n' }, '<leader>tu', vim.cmd.UndotreeToggle, { desc = 'Toggle undo tree' })
    end,
  },

  {
    url = 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
    config = function()
      require('rainbow-delimiters.setup').setup {}
    end,
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = 'LazyFile',
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
    event = 'LazyFile',
    opts = {
      mappings = {
        basic = false,
        extra = false,
      },
    },
    config = function(_, opts)
      require('Comment').setup(opts)
      vim.keymap.set({ 'n' }, '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { desc = 'Toggle line comment' })
      vim.keymap.set({ 'n' }, '<leader>b/', "<ESC><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>", { desc = 'Toggle block comment' })
      vim.keymap.set({ 'v' }, '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'Toggle line comment' })
      vim.keymap.set({ 'v' }, '<leader>b/', "<ESC><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>", { desc = 'Toggle block comment' })
    end,
  },

  {
    'echasnovski/mini.nvim',
    event = 'LazyFile',
    version = false,
    config = function()
      require('mini.pairs').setup {
        modes = { insert = true, command = false, terminal = false },
        mappings = {
          -- ["'"] = false,
        },
      }
      vim.keymap.set('n', 's', '<Nop>', {})
      require('mini.surround').setup()

      require('mini.indentscope').setup {
        symbol = '│',
        options = { try_as_border = true },
      }
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'dashboard',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'trouble',
          'neo-tree',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  {
    'RRethy/vim-illuminate',
    event = 'LazyFile',
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
    },
    config = function(_, opts)
      require('illuminate').configure(opts)

      vim.keymap.set({ 'n' }, ']]', function()
        require('illuminate').goto_next_reference(true)
      end, { desc = 'Next reference' })
      vim.keymap.set({ 'n' }, '[[', function()
        require('illuminate').goto_prev_reference(true)
      end, { desc = 'Previous reference' })
    end,
  },

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = 'LazyFile',
    opts = {
      signs = true,
    },
    config = function(_, opts)
      require('todo-comments').setup(opts)
      vim.keymap.set({ 'n' }, '<leader>tc', '<cmd>TodoQuickFix<cr>', { desc = 'Todo Quick Fix' })
    end,
  },

  {
    'kevinhwang91/nvim-ufo',
    event = 'LazyFile',
    dependencies = {
      'kevinhwang91/promise-async',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require 'plugins.configs.ufo'
    end,
  },

  {
    'whatyouhide/vim-textobj-xmlattr',
    dependencies = {
      'kana/vim-textobj-user',
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    event = { 'LazyFile', 'VeryLazy' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'windwp/nvim-ts-autotag',
    },
    build = ':TSUpdate',
    config = function()
      require 'plugins.configs.treesitter'
    end,
  },

  {
    'Wansmer/treesj',
    keys = {
      { 'g,', '<cmd>TSJToggle <cr>', desc = 'Toggle line split' },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    opts = {
      max_join_length = 240,
    },
    config = function(_, opts)
      require('treesj').setup(opts)
    end,
  },
}
