return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },
  {
    'nvim-neorg/neorg',
    dependencies = { 'luarocks.nvim' },
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {
            config = {
              icon_preset = 'diamond',
            },
          },
          ['core.completion'] = {
            config = {
              engine = 'nvim-cmp',
            },
          },
          ['core.ui.calendar'] = {},
          ['core.summary'] = {},
          ['core.dirman'] = {
            config = {
              workspaces = {
                notes = '~/OneDrive/neorg/notes',
              },
              default_workspace = 'notes',
            },
          },
          ['core.keybinds'] = {
            config = {
              hook = function(keybinds)
                keybinds.map('norg', 'n', '<leader>ne', '<cmd>Neorg keybind norg core.looking-glass.magnify-code-block<cr>')
              end,
            },
          },
        },
      }

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
      vim.keymap.set({ 'n' }, '<leader>ni', '<cmd>Neorg index<cr>', { desc = 'Neorg index' })
      vim.keymap.set({ 'n' }, '<leader>nr', '<cmd>Neorg return<cr>', { desc = 'Neorg return' })
      vim.keymap.set({ 'n' }, '<leader>mi', '<cmd>Neorg inject-metadata<cr>', { desc = 'Neorg inject-metadata' })
      vim.keymap.set({ 'n' }, '<leader>mu', '<cmd>Neorg update-metadata<cr>', { desc = 'Neorg update-metadata' })
    end,
  },
}
