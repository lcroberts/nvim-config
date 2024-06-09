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

      local dap = require 'dap'
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
          args = { '--port', '${port}' },
          -- On windows you may have to uncomment this:
          -- detached = false,
        },
      }
      dap.configurations.cpp = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          args = function()
            local args_string = vim.fn.input 'Arguments: '
            return vim.split(args_string, ' ')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
    end,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    event = 'LazyFile',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
    config = function(_, opts)
      require('nvim-dap-virtual-text').setup(opts)
    end,
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
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
