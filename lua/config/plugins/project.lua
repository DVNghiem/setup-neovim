local pick = nil

pick = function()
	return vim.cmd("Telescope projects")
end

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
		config = function(_, opts)
			require("project_nvim").setup(opts)
			local history = require("project_nvim.utils.history")
			history.delete_project = function(project)
				for k, v in pairs(history.recent_projects) do
					if v == project.value then
						history.recent_projects[k] = nil
						return
					end
				end
			end
			require("telescope").load_extension("projects")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		optional = true,
		keys = {
			{ "<leader>fp", pick, desc = "Projects" },
		},
	},
	{
		"nvimdev/dashboard-nvim",
		optional = true,
		opts = function(_, opts)
			if not vim.tbl_get(opts, "config", "center") then
				return
			end
			local projects = {
				action = pick,
				desc = " Projects",
				icon = " ",
				key = "p",
			}

			projects.desc = projects.desc .. string.rep(" ", 43 - #projects.desc)
			projects.key_format = "  %s"

			table.insert(opts.config.center, 3, projects)
		end,
	},
}
