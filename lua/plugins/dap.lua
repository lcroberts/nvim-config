local utils = require 'utils'
return {
  {
    'mfussenegger/nvim-dap',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
      utils.load_mappings 'dap'
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    event = { 'BufReadPre', 'BufNewFile' },
    lazy = false,
    config = function(_, opts)
      require('nvim-dap-virtual-text').setup {}
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      handlers = {},
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup()
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


