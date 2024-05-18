-- local on_attach = function(_, bufnr)
--   require('utils').load_mappings('lspconfig', { buffer = bufnr })
-- end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local options = {
  server = {
    -- on_attach = on_attach,
    capabilities = capabilities,
  },
}

return options
