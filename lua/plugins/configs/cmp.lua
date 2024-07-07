local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

require('luasnip.loaders.from_snipmate').lazy_load()
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_lua').lazy_load { paths = vim.fn.stdpath 'config' .. '/snippets' }

luasnip.config.setup {}

cmp.setup {
  formatting = {
    format = lspkind.cmp_format(),
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  completion = {
    completeopt = 'menu,menuone,noinsert',
  },

  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-y>'] = cmp.mapping.confirm { select = true },
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'lazydev' },
    { name = 'neorg' },
    { name = 'path' },
    { name = 'buffer' },
  },
}
