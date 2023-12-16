local utils = require 'utils'
return {
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    config = function()
      utils.load_mappings 'dap'
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      require('nvim-dap-virtual-text').setup(opts)
    end,
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {},
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = 'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup(opts)
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
}


