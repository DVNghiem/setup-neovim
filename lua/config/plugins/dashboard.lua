return {
	"nvimdev/dashboard-nvim",
	lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
	opts = function()
		local logo = [[
          ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
          ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
          ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
          ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
          ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
          ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                              
          🚀 THE ULTIMATE IDE FOR LONG CODING SESSIONS 🚀      
                                                              
           💪 Built for endurance, optimized for health       
              🧘 Your coding companion that cares            
      ]]

		logo = string.rep("\n", 8) .. logo .. "\n\n"

		local opts = {
			theme = "doom",
			hide = {
				-- this is taken care of by lualine
				-- enabling this messes up the actual laststatus setting after loading a file
				statusline = false,
			},
			config = {
				header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = 'Telescope find_files',                           desc = " Find File",       icon = " ", key = "f" },
            { action = "ene!",                                           desc = " New File",        icon = " ", key = "n" },
            { action = 'Telescope oldfiles',                             desc = " Recent Files",    icon = " ", key = "r" },
            { action = 'Telescope projects',                             desc = " Project",         icon = " ", key = "p" },
            { action = 'Telescope live_grep',                            desc = " Find next",       icon = " ", key = "t" },
            { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "s" },
            { action = 'HealthDashboard',                                desc = "🧘 Health Stats",  icon = " ", key = "h" },
            { action = 'CheatSheet',                                     desc = "🆘 Help",          icon = " ", key = "?" },
            { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
          },
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					
					-- Get current time for personalized greeting
					local hour = tonumber(os.date("%H"))
					local greeting = "Good "
					if hour < 12 then
						greeting = greeting .. "morning"
					elseif hour < 17 then
						greeting = greeting .. "afternoon"
					else
						greeting = greeting .. "evening"
					end
					
					return {
						"",
						greeting .. "! Ready for productive coding? 💻",
						"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
						"💡 Press 'h' for health dashboard, '?' for help",
						"Remember: Take breaks and stay hydrated! 🧘💧",
					}
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = "  %s"
		end

		-- open dashboard after closing lazy
		if vim.o.filetype == "lazy" then
			vim.api.nvim_create_autocmd("WinClosed", {
				pattern = tostring(vim.api.nvim_get_current_win()),
				once = true,
				callback = function()
					vim.schedule(function()
						vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
					end)
				end,
			})
		end

		return opts
	end,
}
