local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

require("lspconfig").jdtls.setup({
	cmd = { "jdtls", "-configuration", "~/.cache/jdtls/config", "-data", "~/.cache/jdtls/workspace" },
	filetypes = { "java" },
	init_options = {
		jvm_args = {},
		workspace = "~/.cache/jdtls/workspace",
	},
	single_file_support = true,
	capabilities = capabilities,
})
