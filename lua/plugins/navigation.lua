local utils = require 'utils'

local M = {
  {
    'nvim-tree/nvim-tree.lua',
    event = 'VeryLazy',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {}
    end,
  },

  {
    'kazhala/close-buffers.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function()
      -- Auto command to remove buffers with no name
      vim.api.nvim_create_autocmd('BufAdd', {
        command = "lua require('close_buffers').delete({ type = 'nameless', force = true })",
      })
    end,
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      require 'plugins.configs.telescope'
      utils.load_mappings 'telescope'
    end,
  },

  {
    'kevinhwang91/nvim-ufo',
    event = 'VeryLazy',
    dependencies = {
      'kevinhwang91/promise-async',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require 'plugins.configs.ufo'
    end,
  },

  {
    'ThePrimeagen/harpoon',
    event = 'VeryLazy',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      settings = {
        save_on_toggle = true,
        save_on_ui_close = true,
      },
    },
    init = function()
      utils.load_mappings 'harpoon'
    end,
  },
}

return M


