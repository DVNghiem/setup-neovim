local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()


require 'lspconfig'.ts_ls.setup {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    init_options = {
        hostInfo = "neovim"
    },
    single_file_support = true,
    capabilities = capabilities
}
