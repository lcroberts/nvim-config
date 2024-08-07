local lspconfig = require 'lspconfig'
local vim = vim

-- Sign configuration
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local capabilities_no_format = vim.lsp.protocol.make_client_capabilities()
capabilities_no_format = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities_no_format.documentFormattingProvider = false
capabilities_no_format.documentRangeFormattingProvider = false

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    local vmap = function(keys, func, desc)
      vim.keymap.set('v', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    local imap = function(keys, func, desc)
      vim.keymap.set('i', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>fm', function()
      vim.lsp.buf.format { async = true }
    end, 'LSP formatting')
    map('<leader>rn', function()
      vim.lsp.buf.rename()
    end, '[R]e[n]ame')

    map('<leader>ca', function()
      vim.lsp.buf.code_action()
    end, '[C]ode [A]ction')
    vmap('<leader>ca', function()
      vim.lsp.buf.code_action()
    end, '[C]ode [A]ction')

    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    map('<leader>fs', require('telescope.builtin').lsp_document_symbols, '[F]ind [S]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    map('K', function()
      vim.lsp.buf.hover()
    end, 'Hover Documentation')
    map('<M-k>', function()
      vim.lsp.buf.signature_help()
    end, 'Signature Documentation')

    -- Lesser used LSP functionality
    map('gD', function()
      vim.lsp.buf.declaration()
    end, '[G]oto [D]eclaration')
    map('<leader>wa', function()
      vim.lsp.buf.add_workspace_folder()
    end, '[W]orkspace [A]dd Folder')
    map('<leader>wr', function()
      vim.lsp.buf.remove_workspace_folder()
    end, '[W]orkspace [R]emove Folder')
    map('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Diagnostic
    map(']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')
    map('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
    map('<leader>df', vim.diagnostic.open_float, 'floating diagnostic message')
    map('<leader>dl', vim.diagnostic.setloclist, 'Open diagnostics list')

    imap('<C-d>', vim.lsp.buf.signature_help, 'Show signature help')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      map('<leader>ti', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, '[T]oggle [I]nlay Hints')
    end
  end,
})

require('language_utils').setup_lsp(lspconfig, capabilities, capabilities_no_format)

vim.cmd [[filetype detect]]
