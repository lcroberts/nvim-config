local lspconfig = require 'lspconfig'
local vim = vim
local M = {}

-- Sign configuration
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require('cmp_nvim_lsp').default_capabilities(M.capabilities)
M.capabilities.offsetEncoding = 'utf-8'

M.capabilities_no_format = vim.lsp.protocol.make_client_capabilities()
M.capabilities_no_format = require('cmp_nvim_lsp').default_capabilities(M.capabilities)
M.capabilities_no_format.offsetEncoding = 'utf-8'
M.capabilities_no_format.documentFormattingProvider = false
M.capabilities_no_format.documentRangeFormattingProvider = false

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

lspconfig.intelephense.setup {
  capabilities = M.capabilities_no_format,
  filetypes = { 'php', 'blade' },
}

lspconfig.tailwindcss.setup {
  capabilities = M.capabilities,
}

lspconfig.bashls.setup {
  capabilities = M.capabilities,
  filetypes = { 'sh' },
}

lspconfig.pylsp.setup {
  capabilities = M.capabilities,
}

lspconfig.yamlls.setup {
  capabilities = M.capabilities,
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}

lspconfig.jsonls.setup {
  capabilities = M.capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.tailwindcss.setup {
  capabilities = M.capabilities,
}

lspconfig.taplo.setup {
  capabilities = M.capabilities,
}

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signgatureHelpProvider = false
  end,
  capabilities = M.capabilities,
}

lspconfig.lua_ls.setup {
  capabilities = M.capabilities_no_format,
}

lspconfig.gopls.setup {
  capabilities = M.capabilities,
}

lspconfig.typos_lsp.setup {
  capabilities = M.capabilities,
}

lspconfig.html.setup {
  capabilities = M.capabilities_no_format,
  filetypes = { 'html', 'blade' },
}

lspconfig.sqlls.setup {
  capabilities = M.capabilities,
}

lspconfig.cssls.setup {
  capabilities = M.capabilities_no_format,
}

lspconfig.emmet_language_server.setup {
  capabilities = M.capabilities_no_format,
}

return M
