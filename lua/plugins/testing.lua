local vim = vim

return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'V13Axel/neotest-pest',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-pest',
        },
      }

      vim.keymap.set('n', '<leader>tn', function()
        require('neotest').run.run()
      end, { desc = 'Test nearest' })
      vim.keymap.set('n', '<leader>tf', function()
        require('neotest').run.run(vim.fn.expand '%')
      end, { desc = 'Test file' })
      vim.keymap.set('n', '<leader>ts', function()
        require('neotest').run.stop()
      end, { desc = 'Test stop (nearest)' })
    end,
  },
}
