local utils = require 'utils'
return {
  {
    'tadmccorkle/markdown.nvim',
    -- event = 'VeryLazy',
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
      utils.load_mappings 'glow'
    end,
  },
}

