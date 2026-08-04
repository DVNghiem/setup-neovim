return {
	{
		"ahmedkhalf/project.nvim",
		opts = {
			manual_mode = false,
			detection_methods = { "pattern", "lsp" },
			patterns = { ".git", "package.json", "Cargo.toml", "pyproject.toml" },
			silent_chdir = true,
			scope_chdir = "global",
		},
		event = "VeryLazy",
		config = function()
			-- ponytail: empty config — opts auto-passed to setup() by lazy.nvim
		end,
	},
}

