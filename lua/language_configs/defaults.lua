local vim = vim
local M = {}

M.plugins = {
  -- Additional lua configuration, makes nvim stuff amazing!
  {
    'folke/neodev.nvim',
    opts = {
      library = {
        plugins = { 'neotest' },
        types = true,
      },
    },
  },
}

M.null_ls_sources = {}

M.ensure_installed = {
  lspconfig = {},
  null_ls = {},
}

M.lsp_config = function(lspconfig, capabilities, capabilities_no_format)
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
