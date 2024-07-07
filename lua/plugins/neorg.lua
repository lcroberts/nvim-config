return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },
  {
    'nvim-neorg/neorg',
    dependencies = {
      'luarocks.nvim',
      'nvim-neorg/neorg-telescope',
      'nvim-lua/plenary.nvim',
    },
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
          ['core.summary'] = {
            config = {
              strategy = 'by_path',
            },
          },
          ['core.qol.toc'] = {
            config = {
              auto_toc = {
                open = true,
                close = true,
              },
              enter = false,
            },
          },
          ['core.integrations.telescope'] = {
            config = {
              insert_file_link = {
                show_title_preview = true,
              },
            },
          },
          ['core.dirman'] = {
            config = {
              workspaces = {
                notes = '~/OneDrive/neorg/notes',
                todo = '~/OneDrive/neorg/todo',
              },
              default_workspace = 'notes',
            },
          },
          ['core.export'] = {},
          ['core.keybinds'] = {
            config = {
              hook = function(keybinds)
                keybinds.remap_event('norg', 'n', '<localleader>ne', 'core.looking-glass.magnify-code-block')
                keybinds.map('norg', 'n', '<C-s>', '<cmd>Telescope neorg find_linkable<cr>')
                keybinds.map('norg', 'i', '<C-i>', '<cmd>Telescope neorg insert_link<cr>')
                keybinds.map('norg', 'n', '<leader>nt', '<cmd>Neorg toc<cr>')
                keybinds.map('norg', 'n', '<leader>mi', '<cmd>Neorg inject-metadata<cr>')
                keybinds.map('norg', 'n', '<leader>mu', '<cmd>Neorg update-metadata<cr>')
              end,
            },
          },
        },
      }

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
      vim.keymap.set({ 'n' }, '<leader>ni', '<cmd>Neorg index<cr>', { desc = 'Neorg index' })
      vim.keymap.set({ 'n' }, '<leader>nr', '<cmd>Neorg return<cr>', { desc = 'Neorg return' })
      vim.keymap.set('n', '<leader>nw', '<cmd>Telescope neorg switch_workspace<cr>', { desc = 'Telescope neorg workspace' })
      vim.keymap.set({ 'n' }, '<leader>fn', '<cmd>Telescope neorg find_norg_files<cr>', { desc = 'Find norg files' })
    end,
  },
}
