local vim = vim
local M = {}

M.plugins = {
  -- Additional lua configuration, makes nvim stuff amazing!
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'Bilal2453/luvit-meta',
  }, -- optional `vim.uv` typings
}

M.ensure_installed = {
  lspconfig = {
    'typos_lsp',
    'yamlls',
    'jsonls',
    'taplo',
    'lua_ls',
  },
  null_ls = {
    'glow',
    'stylua',
    'selene',
  },
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format)
  lspconfig.typos_lsp.setup {
    capabilities = capabilities,
  }

  lspconfig.lua_ls.setup {
    capabilities = capabilities_no_format,
  }

  lspconfig.taplo.setup {
    capabilities = capabilities,
  }

  lspconfig.jsonls.setup {
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  }

  lspconfig.yamlls.setup {
    capabilities = capabilities,
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
end

return M
