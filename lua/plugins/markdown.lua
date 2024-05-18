local vim = vim

return {
  {
    'tadmccorkle/markdown.nvim',
    ft = 'markdown',
    opts = {},
  },

  {
    'jghauser/follow-md-links.nvim',
    ft = 'markdown',
  },

  { -- Requires glow to be installed
    'ellisonleao/glow.nvim',
    ft = 'markdown',
    opts = {
      width_ratio = 0.7,
      height_ratio = 0.7,
      style = 'dark',
    },
    cmd = 'Glow',
    config = function(_, opts)
      require('glow').setup(opts)
      vim.keymap.set({ 'n' }, '<leader>tg', vim.cmd.Glow, { desc = 'Toggle glow md preview' })
    end,
  },
}
