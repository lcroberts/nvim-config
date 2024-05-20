local lspconfig = require 'lspconfig'
local vim = vim
require('mason').setup()
require('mason-lspconfig').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.offsetEncoding = 'utf-8'

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
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
  end,
})

lspconfig.bashls.setup {
  capabilities = capabilities,
  filetypes = { 'sh' },
}

lspconfig.pylsp.setup {
  capabilities = capabilities,
}

lspconfig.yamlls.setup {
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup {
  capabilities = capabilities,
}

lspconfig.taplo.setup {
  capabilities = capabilities,
}

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signgatureHelpProvider = false
  end,
  capabilities = capabilities,
}

lspconfig.lua_ls.setup {
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  capabilities = capabilities,
}

lspconfig.typos_lsp.setup {
  capabilities = capabilities,
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
}

capabilities.documentFormattingProvider = false
capabilities.documentRangeFormattingProvider = false
lspconfig.intelephense.setup {
  capabilities = capabilities,
}
