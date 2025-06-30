-- Utility modules initialization
local M = {}

-- Load search utilities
M.search_utils = require('config.utils.search-utils')
M.search_status = require('config.utils.search-status')

-- Setup all utilities
function M.setup()
	-- Setup search status
	M.search_status.setup()
	
	-- Create search commands
	vim.api.nvim_create_user_command('SearchToggleCase', function()
		M.search_utils.toggle_case_sensitive()
		vim.api.nvim_exec_autocmds("User", { pattern = "SearchOptionsChanged" })
	end, { desc = "Toggle case sensitive search" })
	
	vim.api.nvim_create_user_command('SearchToggleWord', function()
		M.search_utils.toggle_whole_word()
		vim.api.nvim_exec_autocmds("User", { pattern = "SearchOptionsChanged" })
	end, { desc = "Toggle whole word search" })
	
	vim.api.nvim_create_user_command('SearchToggleRegex', function()
		M.search_utils.toggle_regex()
		vim.api.nvim_exec_autocmds("User", { pattern = "SearchOptionsChanged" })
	end, { desc = "Toggle regex search" })
	
	vim.api.nvim_create_user_command('SearchToggleHidden', function()
		M.search_utils.toggle_hidden()
		vim.api.nvim_exec_autocmds("User", { pattern = "SearchOptionsChanged" })
	end, { desc = "Toggle hidden files search" })
	
	vim.api.nvim_create_user_command('SearchToggleIgnore', function()
		M.search_utils.toggle_gitignore()
		vim.api.nvim_exec_autocmds("User", { pattern = "SearchOptionsChanged" })
	end, { desc = "Toggle gitignore files search" })
	
	vim.api.nvim_create_user_command('SearchStatus', function()
		M.search_utils.show_search_status()
	end, { desc = "Show search options status" })
	
	vim.api.nvim_create_user_command('SearchInFiles', function(opts)
		if opts.args and #opts.args > 0 then
			M.search_utils.search_in_filetype(opts.args)
		else
			vim.notify("Usage: :SearchInFiles <filetype>", vim.log.levels.INFO)
		end
	end, { 
		nargs = 1,
		complete = function()
			return { "lua", "python", "javascript", "go", "rust", "c", "cpp", "html", "css", "markdown", "json", "yaml" }
		end,
		desc = "Search in specific file types" 
	})
end

return M
