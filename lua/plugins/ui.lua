return {
  -- Theme
  {
    -- tokyonight theme
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- Status line
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        sections = {
          lualine_x = {
            {
              require('noice').api.statusline.mode.get,
              cond = require('noice').api.statusline.mode.has,
            },
            'encoding',
            'fileformat',
            'filetype',
          },
        },

        -- icons_enabled = false,
        globalstatus = true,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      }
    end,
  },

  {
    'stevearc/dressing.nvim',
    lazy = true,
    opts = {},
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ebug and [D]iagnostics', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it and [G]oto', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = '[H]arpoon and Git [H]unk', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename and [R]ust', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '[F]ind and [F]ormat', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>b'] = { name = '[B]lock', _ = 'which_key_ignore' },
      }

      -- register which-key VISUAL mode
      -- required for visual <leader>hs (hunk stage) to work
      require('which-key').register({
        ['<leader>'] = { name = 'VISUAL <leader>' },
        ['<leader>b'] = { name = '[B]lock', _ = 'which_key_ignore' },
        -- ['<leader>h'] = { 'Git [H]unk' },
      }, { mode = 'v' })
      require('which-key').setup {}
    end,
  },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '󰍵' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '│' },
      }, -- See `:help gitsigns.txt`
      on_attach = function(bufnr)
        require('utils').load_mappings('gitsigns', { buffer = bufnr })
      end,
    },
  },

  {
    'echasnovski/mini.indentscope',
    -- version = false, -- wait till new 0.7.0 release to put it back on semver
    event = 'VeryLazy',
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}

