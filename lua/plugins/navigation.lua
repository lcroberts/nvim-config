local utils = require 'utils'

local M = {
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },

  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    version = '*',
    opts = {
      options = {
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require('lazyvim.config').icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') ..
          (diag.warning and icons.Warn .. diag.warning or '')
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
    config = function(_, opts)
      vim.opt.termguicolors = true
      require('bufferline').setup(opts)

      -- Fixes bufferline on session restore
      vim.api.nvim_create_autocmd('BufAdd', {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
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
      require('harpoon').setup(opts)
      utils.load_mappings 'harpoon'
    end,
  },
}

return M
