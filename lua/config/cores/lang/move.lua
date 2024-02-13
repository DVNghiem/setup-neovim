local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()


require 'lspconfig'.move_analyzer.setup {
    cmd = { "move-analyzer" },
    filetypes = { "move" },
    capabilities = capabilities
}
