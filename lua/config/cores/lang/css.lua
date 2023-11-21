local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}