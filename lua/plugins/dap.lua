local vim = vim

return {
  {
    'mfussenegger/nvim-dap',
    event = 'LazyFile',
    config = function()
      vim.keymap.set({ 'n' }, '<leader>db', '<cmd> DapToggleBreakpoint <CR>', { desc = 'Toggle Breakpoint' })
      vim.keymap.set({ 'n' }, '<leader>dc', '<cmd> DapContinue <CR>', { desc = 'Start or continue debugger' })
      vim.keymap.set({ 'n' }, '<leader>dsu', function()
        local widgets = require 'dap.ui.widgets'
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end, { desc = 'Open debugging sidebar' })
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    event = 'LazyFile',
    opts = {},
    config = function(_, opts)
      require('nvim-dap-virtual-text').setup(opts)
    end,
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'LazyFile',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {},
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    event = 'LazyFile',
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

  -- mason.nvim integration
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = 'mason.nvim',
    cmd = { 'DapInstall', 'DapUninstall' },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        'codelldb',
        'bash-debug-adapter',
      },
    },
  },
}
