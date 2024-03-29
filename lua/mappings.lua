-- This config uses the nvchad mapping configuration style. Here is an example:
-- opts is an optional parameter
-- ["keys"] = {"action", "description", opts = {}},
--
-- ["<C-n>"] = {"<cmd> NvimTreeToggle <CR>", "Toggle nvimtree"},
-- ["<leader>ff"] = {"<cmd> Telescope <CR>", "Telescope"},

-- opts can have the props: buffer, silent, noremap, nowait and so on.
-- All standard key binding opts are supported.
-- [";"] = { ":", "enter cmdline", opts = { nowait = true } },

-- For a more complex keymap
-- ["<leader>tt"] = {
--   function()
--      require("base46").toggle_transparency()
--   end,
--   "toggle transparency",
-- },
-- For more information go here: https://nvchad.com/docs/config/mappings

local M = {}
local vim = vim -- Deal with lsp for vim api

-- general mapping section, not plugin specific. Loaded by calling utils.load_mappings with no args
M.general = {
  -- Normal mode
  n = {
    -- Vim Tmux navigation
    ['<C-h>'] = { '<cmd> TmuxNavigateLeft<CR>', 'window left' },
    ['<C-l>'] = { '<cmd> TmuxNavigateRight<CR>', 'window right' },
    ['<C-j>'] = { '<cmd> TmuxNavigateDown<CR>', 'window down' },
    ['<C-k>'] = { '<cmd> TmuxNavigateUp<CR>', 'window up' },

    -- Keymaps for better default experience
    ['<Space>'] = { '<Nop>', opts = { silent = true } },
    -- Clear highlights
    ['<Esc>'] = { '<cmd> noh<cr>', 'Clear highlights' },
    -- Remap for dealing with word wrap
    ['k'] = { "v:count == 0 ? 'gk' : 'k'", opts = { expr = true, silent = true } },
    ['j'] = { "v:count == 0 ? 'gj' : 'j'", opts = { expr = true, silent = true } },
    ['<C-u>'] = { '<C-u>zz', opts = { silent = true } },
    ['<C-d>'] = { '<C-d>zz', opts = { silent = true } },
    ['n'] = { 'nzzzv', opts = { silent = true } },
    ['N'] = { 'Nzzzv', opts = { silent = true } },

    -- Netrw
    ['<leader>nn'] = { '<cmd>Ntree<cr>', 'Open Netrw' },

    -- Save for Ctrl+s
    ['<C-s>'] = { '<cmd> w<cr>', 'Save file' },
    -- Copy file
    ['<C-c>'] = { '<cmd> %y+<cr>', 'Copy file contents' },

    -- UFO
    ['zR'] = { require('ufo').openAllFolds, 'Open all folds' },
    ['zM'] = { require('ufo').closeAllFolds, 'Close all folds' },

    -- Undo Tree
    ['<leader>tu'] = { vim.cmd.UndotreeToggle, 'Toggle undo tree' },

    -- Trouble toggle
    ['<leader>tt'] = { vim.cmd.TroubleToggle, 'Toggle trouble' },

    -- Vim Fugitive (Git)
    ['<leader>gs'] = { vim.cmd.Git, 'Open git' },
  },

  -- Visual mode
  x = {
    ['<Space>'] = { '<Nop>', opts = { silent = true } },

    -- Move visual selection around
    ['H'] = { '<gv', 'Move selection left' },
    ['J'] = { ":m '>+1<CR>gv=gv", 'Move selection down' },
    ['K'] = { ":m '<-2<CR>gv=gv", 'Move selection up' },
    ['L'] = { '>gv', 'Move selection right' },
    ['<leader>p'] = { [["_dP]], 'Replace text' },
    ['A'] = { ':s/$/' },
  },

  -- Insert mode
  i = {
    -- Navigate in insert mode
    ['<C-h>'] = { '<Left>', 'Move left' },
    ['<C-l>'] = { '<Right>', 'Move right' },
    ['<C-j>'] = { '<Down>', 'Move down' },
    ['<C-k>'] = { '<Up>', 'Move up' },

    ['<C-b>'] = { '<Esc>_i', 'Beginning of line' },
    ['<C-e>'] = { '<End>', 'End of line' },

    ['<A-;>'] = { '<End>;', 'Append Semicolon' },
    ['<A-,>'] = { '<End>,', 'Append Comma' },
  },

  c = {
    ['<M-/>'] = { [[\/]] },
  },
}

local harpoon = require 'harpoon'
-- Harpoon is a new section and must be loaded by specifying a section with utils.load_mappings
M.harpoon = {
  plugin = true,

  n = {
    ['<leader>1'] = { '<cmd> lua require("harpoon"):list():select(1)<cr>', 'Harpoon' },
    ['<leader>2'] = { '<cmd> lua require("harpoon"):list():select(2)<cr>', 'Harpoon' },
    ['<leader>3'] = { '<cmd> lua require("harpoon"):list():select(3)<cr>', 'Harpoon' },
    ['<leader>4'] = { '<cmd> lua require("harpoon"):list():select(4)<cr>', 'Harpoon' },
    ['<leader>5'] = { '<cmd> lua require("harpoon"):list():select(5)<cr>', 'Harpoon' },
    ['<leader>ha'] = {
      function()
        harpoon:list():append()
      end,
      'Harpoon append',
    },
    ['<leader>hl'] = {
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      'Harpoon list',
    },
  },
}

M.glow = {
  plugin = true,
  n = {
    ['<leader>tg'] = { vim.cmd.Glow, 'Toggle glow md preview' },
  },
}

M.dap = {
  plugin = true,
  n = {
    ['<leader>db'] = {
      '<cmd> DapToggleBreakpoint <CR>',
      'Toggle Breakpoint',
    },
    ['<leader>dc'] = {
      '<cmd> DapContinue <CR>',
      'Start or continue debugger',
    },
    ['<leader>dsu'] = {
      function()
        local widgets = require 'dap.ui.widgets'
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      'Open debugging sidebar',
    },
  },
}

M.crates = {
  plugin = true,
  n = {
    ['<leader>rcu'] = {
      function()
        require('crates').upgrade_all_crates()
      end,
      'update crates',
    },
  },
}

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end
M.telescope = {
  plugin = true,
  n = {
    -- See `:help telescope.builtin`
    ['<leader>fo'] = { require('telescope.builtin').oldfiles, '[f]ind recently [o]pened files' },
    ['<leader>fb'] = { require('telescope.builtin').buffers, '[f]ind existing [b]uffers' },
    ['<leader>ff'] = { require('telescope.builtin').find_files, '[f]ind [f]iles' },
    ['<leader>ft'] = { telescope_live_grep_open_files, '[f]ind [t]ext' },
    ['<leader>fh'] = { require('telescope.builtin').help_tags, '[f]ind [h]elp page' },
    ['<leader>fw'] = { require('telescope.builtin').grep_string, '[f]ind current [w]ord' },
    ['<leader>fg'] = { require('telescope.builtin').live_grep, '[f]ind by [g]rep' },
    ['<leader>fG'] = { ':LiveGrepGitRoot<cr>', '[f]ind by [G]rep on Git Root' },
    ['<leader>fd'] = { require('telescope.builtin').diagnostics, '[f]ind [d]iagnostics' },
    ['<leader>fr'] = { require('telescope.builtin').resume, '[f]ind [r]esume' },
    ['<leader>f/'] = {
      function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      '[f]uzzily search [/] in current buffer',
    },
    ['<leader>gf'] = { require('telescope.builtin').git_files, 'Search [G]it [F]iles' },

    -- Theme search
    ['<leader>th'] = { require('telescope.builtin').colorscheme, '[t]heme search' },
  },
}

M.lspconfig = {
  plugin = true,
  n = {
    ['<leader>fm'] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      'LSP formatting',
    },
    ['<leader>rn'] = {
      function()
        vim.lsp.buf.rename()
      end,
      '[R]e[n]ame',
    },
    ['<leader>ca'] = {
      function()
        vim.lsp.buf.code_action()
      end,
      '[C]ode [A]ction',
    },
    ['gd'] = { require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition' },
    ['gr'] = { require('telescope.builtin').lsp_references, '[G]oto [R]eferences' },
    ['gi'] = { require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation' },
    ['<leader>D'] = { require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition' },
    ['<leader>fs'] = { require('telescope.builtin').lsp_document_symbols, '[F]ind [S]ymbols' },
    ['<leader>ws'] = { require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols' },

    -- See `:help K` for why this keymap
    ['K'] = {
      function()
        vim.lsp.buf.hover()
      end,
      'Hover Documentation',
    },
    ['<M-k>'] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      'Signature Documentation',
    },

    -- Lesser used LSP functionality
    ['gD'] = {
      function()
        vim.lsp.buf.declaration()
      end,
      '[G]oto [D]eclaration',
    },
    ['<leader>wa'] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      '[W]orkspace [A]dd Folder',
    },
    ['<leader>wr'] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      '[W]orkspace [R]emove Folder',
    },
    ['<leader>wl'] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      '[W]orkspace [L]ist Folders',
    },

    -- Diagnostic
    [']d'] = { vim.diagnostic.goto_next, 'Go to next diagnostic message' },
    ['[d'] = { vim.diagnostic.goto_prev, 'Go to previous diagnostic message' },
    ['<leader>df'] = { vim.diagnostic.open_float, 'floating diagnostic message' },
    ['<leader>dl'] = { vim.diagnostic.setloclist, 'Open diagnostics list' },
  },
}

M.gitsigns = {
  plugin = true,
  n = {
    [']c'] = {
      function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          package.loaded.gitsigns.next_hunk()
        end)
        return '<Ignore>'
      end,
      'Jump to next hunk',
    },

    ['[c'] = {
      function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          package.loaded.gitsigns.prev_hunk()
        end)
        return '<Ignore>'
      end,
      'Jump to previous hunk',
    },

    ['<leader>hs'] = { package.loaded.gitsigns.stage_hunk, 'git stage hunk' },
    ['<leader>hr'] = { package.loaded.gitsigns.reset_hunk, 'git reset hunk' },
    ['<leader>hS'] = { package.loaded.gitsigns.stage_buffer, 'git Stage buffer' },
    ['<leader>hu'] = { package.loaded.gitsigns.undo_stage_hunk, 'undo stage hunk' },
    ['<leader>hR'] = { package.loaded.gitsigns.reset_buffer, 'git Reset buffer' },
    ['<leader>hp'] = { package.loaded.gitsigns.preview_hunk, 'preview git hunk' },
    ['<leader>hd'] = { package.loaded.gitsigns.diffthis, 'git diff against index' },

    ['<leader>hb'] = {
      function()
        package.loaded.gitsigns.blame_line { full = false }
      end,
      'git blame line',
    },

    ['<leader>hD'] = {
      function()
        package.loaded.gitsigns.diffthis '~'
      end,
      'git diff against last commit',
    },

    ['<leader>tb'] = { package.loaded.gitsigns.toggle_current_line_blame, 'toggle git blame line' },
    ['<leader>td'] = { package.loaded.gitsigns.toggle_deleted, 'toggle git show deleted' },
  },

  v = {
    [']c'] = {
      function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          package.loaded.gitsigns.next_hunk()
        end)
        return '<Ignore>'
      end,
      'Jump to next hunk',
    },

    ['<leader>hs'] = {
      function()
        package.loaded.gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end,
      'stage git hunk',
    },

    ['<leader>hr'] = {
      function()
        package.loaded.gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end,
      'reset git hunk',
    },
  },
}

M.comment = {
  plugin = true,
  n = {
    ['<leader>/'] = { "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR>", 'Toggle line comment' },
    ['<leader>b/'] = {
      "<ESC><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>",
      'Toggle block comment',
    },
  },
  v = {
    ['<leader>/'] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      'Toggle line comment',
    },
    ['<leader>b/'] = {
      "<ESC><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>",
      'Toggle block comment',
    },
  },
}

M.illuminate = {
  plugin = true,
  n = {
    [']]'] = {
      function()
        require('illuminate').goto_next_reference(true)
      end,
      'Next reference',
    },
    ['[['] = {
      function()
        require('illuminate').goto_prev_reference(true)
      end,
      'Previous reference',
    },
  },
}

M.trouble = {
  plugin = true,
  n = {
    [']t'] = {
      function()
        require('trouble').open { height = 0 }
        require('trouble').next { skip_groups = true, jump = true }
      end,
      'Next Trouble Item',
    },
    ['[t'] = {
      function()
        require('trouble').open { height = 0 }
        require('trouble').previous { skip_groups = true, jump = true }
      end,
      'Next Trouble Item',
    },
  },
}

M.todo = {
  plugin = true,
  n = {
    ['<leader>tc'] = { '<cmd>TodoQuickFix<cr>', 'Todo Quick Fix' },
  },
}

return M
