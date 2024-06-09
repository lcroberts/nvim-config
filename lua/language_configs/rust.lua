local vim = vim
local M = {}

M.plugins = {
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
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
      vim.keymap.set({ 'n' }, '<leader>rcu', function()
        require('crates').upgrade_all_crates()
      end, { desc = 'update crates' })
    end,
  },
  {
    'rust-lang/rust.vim',
    ft = 'rust',
  },
}

M.ensure_installed = {
  lspconfig = {},
  null_ls = {
    'codelldb',
  },
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format) end

return M
