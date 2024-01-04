local utils = require 'utils'

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
      utils.load_mappings 'glow'
    end,
  },

  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      workspaces = {
        {
          name = 'school',
          path = '~/Documents/MarkdownNotes/School Notes',
        },
        {
          name = 'misc',
          path = '~/Documents/MarkdownNotes/Misc Notes',
        },
        {
          name = 'certs',
          path = '~/Documents/MarkdownNotes/Certification Notes',
        },
      },
    },
  },
}
