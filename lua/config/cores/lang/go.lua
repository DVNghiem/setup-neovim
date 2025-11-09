local cmp_nvim_lsp = require("cmp_nvim_lsp")
local util = require("lspconfig.util")
local async = require("lspconfig.async")
local mod_cache = nil
local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.config('gopls', {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	single_file_support = true,
	capabilities = capabilities,
	root_dir = function(fname)
		-- see: https://github.com/golang/go/issues/40010
		if not mod_cache then
			local result = async.run_command({ "go", "env", "GOMODCACHE" })
			if result and result[1] then
				mod_cache = vim.trim(result[1])
			else
				mod_cache = vim.fn.system("go env GOMODCACHE")
			end
		end
		if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
			local clients = util.get_lsp_clients({ name = "gopls" })
			if #clients > 0 then
				return clients[#clients].config.root_dir
			end
		end
		return util.root_pattern("go.work", "go.mod", ".git")(fname)
	end,
})
vim.lsp.enable({ 'gopls' })