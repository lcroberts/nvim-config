local utils = require 'utils'

return {
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },

  {
    'saecki/crates.nvim',
    ft = { 'toml' },
    config = function(_, opts)
      local crates = require 'crates'
      crates.setup(opts)
      require('cmp').setup.buffer {
        sources = { { name = 'crates' } },
      }
      crates.show()
      utils.load_mappings 'crates'
    end,
  },
  {
    'rust-lang/rust.vim',
    ft = 'rust',
  },
}
