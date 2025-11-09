local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.config('cssls', {
    capabilities = capabilities,
})
vim.lsp.enable({ 'cssls' })