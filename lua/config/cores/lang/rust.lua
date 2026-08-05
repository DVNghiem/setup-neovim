local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.config('rust_analyzer', {
	capabilities = capabilities,
	cmd = {
		"rust-analyzer",
	},
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = false;
			}
		},
	},
})
vim.lsp.enable({ 'rust_analyzer' })
