-- Search status component for statusline
local M = {}

local search_utils = require('config.utils.search-utils')

function M.get_search_status()
	local config = search_utils.search_config
	local icons = {}
	
	if config.case_sensitive then
		table.insert(icons, "Aa")
	else
		table.insert(icons, "aa")
	end
	
	if config.whole_word then
		table.insert(icons, "W")
	end
	
	if config.regex_enabled then
		table.insert(icons, ".*")
	end
	
	if config.include_hidden then
		table.insert(icons, "H")
	end
	
	if config.include_gitignore then
		table.insert(icons, "I")
	end
	
	if #icons > 0 then
		return "🔍[" .. table.concat(icons, " ") .. "]"
	else
		return ""
	end
end

function M.setup()
	-- Create autocommand to update statusline when search options change
	vim.api.nvim_create_augroup("SearchStatus", { clear = true })
	
	-- Update statusline when search options change
	vim.api.nvim_create_autocmd("User", {
		group = "SearchStatus", 
		pattern = "SearchOptionsChanged",
		callback = function()
			vim.cmd("redrawstatus")
		end,
	})
end

return M
