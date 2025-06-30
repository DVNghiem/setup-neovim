-- Enhanced search utilities for VS Code-like experience
local M = {}

-- Search configuration state
M.search_config = {
	case_sensitive = false,
	whole_word = false,
	regex_enabled = false,
	include_hidden = false,
	include_gitignore = false,
}

-- Toggle search options
function M.toggle_case_sensitive()
	M.search_config.case_sensitive = not M.search_config.case_sensitive
	local status = M.search_config.case_sensitive and "ON" or "OFF"
	vim.notify("🔍 Case Sensitive: " .. status, vim.log.levels.INFO)
	return M.search_config.case_sensitive
end

function M.toggle_whole_word()
	M.search_config.whole_word = not M.search_config.whole_word
	local status = M.search_config.whole_word and "ON" or "OFF"
	vim.notify("🔍 Whole Word: " .. status, vim.log.levels.INFO)
	return M.search_config.whole_word
end

function M.toggle_regex()
	M.search_config.regex_enabled = not M.search_config.regex_enabled
	local status = M.search_config.regex_enabled and "ON" or "OFF"
	vim.notify("🔍 Regex: " .. status, vim.log.levels.INFO)
	return M.search_config.regex_enabled
end

function M.toggle_hidden()
	M.search_config.include_hidden = not M.search_config.include_hidden
	local status = M.search_config.include_hidden and "ON" or "OFF"
	vim.notify("🔍 Include Hidden: " .. status, vim.log.levels.INFO)
	return M.search_config.include_hidden
end

function M.toggle_gitignore()
	M.search_config.include_gitignore = not M.search_config.include_gitignore
	local status = M.search_config.include_gitignore and "ON" or "OFF"
	vim.notify("🔍 Include Gitignore: " .. status, vim.log.levels.INFO)
	return M.search_config.include_gitignore
end

-- Get current search options as ripgrep arguments
function M.get_rg_args()
	local args = {}
	
	if not M.search_config.case_sensitive then
		table.insert(args, "--ignore-case")
	end
	
	if M.search_config.whole_word then
		table.insert(args, "--word-regexp")
	end
	
	if not M.search_config.regex_enabled then
		table.insert(args, "--fixed-strings")
	end
	
	if M.search_config.include_hidden then
		table.insert(args, "--hidden")
	end
	
	if M.search_config.include_gitignore then
		table.insert(args, "--no-ignore")
	end
	
	-- Always include these for better output
	table.insert(args, "--color=never")
	table.insert(args, "--no-heading")
	table.insert(args, "--with-filename")
	table.insert(args, "--line-number")
	table.insert(args, "--column")
	
	return args
end

-- Enhanced live grep with current options
function M.live_grep_with_options()
	require('telescope.builtin').live_grep({
		additional_args = function()
			return M.get_rg_args()
		end,
		prompt_title = "🔍 Live Grep " .. M.get_options_string(),
	})
end

-- Enhanced grep string with current options
function M.grep_string_with_options()
	require('telescope.builtin').grep_string({
		additional_args = function()
			return M.get_rg_args()
		end,
		prompt_title = "🔍 Grep String " .. M.get_options_string(),
	})
end

-- Get options string for display
function M.get_options_string()
	local options = {}
	
	if M.search_config.case_sensitive then
		table.insert(options, "Aa")
	else
		table.insert(options, "aa")
	end
	
	if M.search_config.whole_word then
		table.insert(options, "W")
	end
	
	if M.search_config.regex_enabled then
		table.insert(options, ".*")
	end
	
	if M.search_config.include_hidden then
		table.insert(options, "H")
	end
	
	if M.search_config.include_gitignore then
		table.insert(options, "I")
	end
	
	return "[" .. table.concat(options, " ") .. "]"
end

-- Show search options status
function M.show_search_status()
	local status = {
		"🔍 Search Options:",
		"  Case Sensitive: " .. (M.search_config.case_sensitive and "✓" or "✗"),
		"  Whole Word: " .. (M.search_config.whole_word and "✓" or "✗"),
		"  Regex: " .. (M.search_config.regex_enabled and "✓" or "✗"),
		"  Include Hidden: " .. (M.search_config.include_hidden and "✓" or "✗"),
		"  Include Gitignore: " .. (M.search_config.include_gitignore and "✓" or "✗"),
	}
	vim.notify(table.concat(status, "\n"), vim.log.levels.INFO)
end

-- Search in specific file types
function M.search_in_filetype(filetype)
	local extensions = {
		lua = "*.lua",
		python = "*.py",
		javascript = "*.js,*.jsx,*.ts,*.tsx",
		go = "*.go",
		rust = "*.rs",
		c = "*.c,*.h",
		cpp = "*.cpp,*.hpp,*.cc,*.cxx",
		java = "*.java",
		css = "*.css,*.scss,*.sass",
		html = "*.html,*.htm",
		json = "*.json",
		yaml = "*.yaml,*.yml",
		xml = "*.xml",
		markdown = "*.md,*.markdown",
		text = "*.txt",
	}
	
	local glob_pattern = extensions[filetype]
	if not glob_pattern then
		vim.notify("❌ Unknown filetype: " .. filetype, vim.log.levels.ERROR)
		return
	end
	
	local args = M.get_rg_args()
	table.insert(args, "--glob")
	table.insert(args, glob_pattern)
	
	require('telescope.builtin').live_grep({
		additional_args = function()
			return args
		end,
		prompt_title = "🔍 Search in " .. filetype .. " files " .. M.get_options_string(),
	})
end

-- Search with exclude patterns
function M.search_with_exclude(exclude_patterns)
	local args = M.get_rg_args()
	
	for _, pattern in ipairs(exclude_patterns) do
		table.insert(args, "--glob")
		table.insert(args, "!" .. pattern)
	end
	
	require('telescope.builtin').live_grep({
		additional_args = function()
			return args
		end,
		prompt_title = "🔍 Search (excluding patterns) " .. M.get_options_string(),
	})
end

-- Quick file type searches
M.file_type_searches = {
	{ name = "Lua files", key = "sl", filetype = "lua" },
	{ name = "Python files", key = "sp", filetype = "python" },
	{ name = "JavaScript/TypeScript", key = "sj", filetype = "javascript" },
	{ name = "Go files", key = "sg", filetype = "go" },
	{ name = "Rust files", key = "sr", filetype = "rust" },
	{ name = "C/C++ files", key = "sc", filetype = "cpp" },
	{ name = "HTML files", key = "sh", filetype = "html" },
	{ name = "CSS files", key = "ss", filetype = "css" },
	{ name = "Markdown files", key = "sm", filetype = "markdown" },
	{ name = "Config files", key = "sf", exclude = {"*.log", "*.cache", "node_modules/*", ".git/*"} },
}

return M
