local util = require 'lspconfig.util'
local lspconfig = require 'lspconfig'
require('mason').setup()
require('mason-lspconfig').setup()

local on_attach = function(_, bufnr)
  -- Create keymappings for lsp
  require('utils').load_mappings('lspconfig', { buffer = bufnr })
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.offsetEncoding = 'utf-8'

lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'sh' },
  root_dir = util.find_git_ancestor(),
  single_file_support = true,
}

lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'python' },
  root_dir = util.find_git_ancestor(),
}

lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'yaml', 'yaml.docker.compose' },
  root_dir = util.find_git_ancestor(),
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    'aspnetcorerazor',
    'astro',
    'astro-markdown',
    'blade',
    'clojure',
    'django-html',
    'htmldjango',
    'edge',
    'eelixir',
    'elixir',
    'ejs',
    'erb',
    'eruby',
    'gohtml',
    'haml',
    'handlebars',
    'hbs',
    'html',
    'html-eex',
    'heex',
    'jade',
    'leaf',
    'liquid',
    'markdown',
    'mdx',
    'mustache',
    'njk',
    'nunjucks',
    'php',
    'razor',
    'slim',
    'twig',
    'css',
    'less',
    'postcss',
    'sass',
    'scss',
    'stylus',
    'sugarss',
    'javascript',
    'javascriptreact',
    'reason',
    'rescript',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
  },
}

lspconfig.taplo.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'toml' },
  root_dir = util.root_pattern('*.toml', '.git'),
}

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signgatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  root_dir = util.root_pattern('.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git'),
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.typos_lsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.intelephense.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
