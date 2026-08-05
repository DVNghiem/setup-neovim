local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.config('rust_analyzer', {
	capabilities = capabilities,
	cmd = {
		"rust-analyzer",
	},
	-- Set memory limit via environment
	cmd_env = {
		["RA_LRU_CAP"] = "64",  -- Limit LRU cache entries to reduce RAM
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
