local utils = require 'utils'

return {
  {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    dependencies = 'neovim/nvim-lspconfig',
    opts = function()
      return require 'plugins.configs.rust-tools'
    end,
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end,
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
