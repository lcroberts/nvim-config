local vim = vim

local M = {
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
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
    config = function(_, opts)
      local harpoon = require 'harpoon'

      harpoon:setup(opts)
      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<leader>hl', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end)
      vim.keymap.set('n', '<leader>5', function()
        harpoon:list():select(5)
      end)
    end,
  },

  {
    'stevearc/oil.nvim',
    opts = {
      keymaps = {
        ["<BS>"] = "actions.parent",
      },
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function(_, opts)
        require('oil').setup(opts)
        vim.keymap.set({ 'n' }, '<leader>nn', '<cmd>Oil<cr>', { desc = 'Open fileview' })
    end,
  },
}

return M
