return {
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>sr",
				function()
					require("spectre").open()
				end,
				desc = "Replace in files (Spectre)",
			},
			{
				"<leader>sw",
				function()
					require("spectre").open_visual({ select_word = true })
				end,
				desc = "Replace current word (Spectre)",
			},
			{
				"<leader>sp",
				function()
					require("spectre").open_file_search()
				end,
				desc = "Replace in current file (Spectre)",
			},
		},
		opts = {
			open_cmd = "noswapfile vnew",
			live_update = true,
			default = {
				find = {
					-- pick one of item in find_engine
					cmd = "rg",
					options = { "ignore-case" },
				},
				replace = {
					cmd = "sed",
				},
			},
			replace_engine = {
				["sed"] = {
					cmd = "sed",
					args = nil,
					options = {
						["ignore-case"] = {
							value = "--ignore-case",
							icon = "[I]",
							desc = "ignore case",
						},
					},
				},
				["oxi"] = {
					cmd = "oxi",
					args = nil,
					options = {
						["ignore-case"] = {
							value = "i",
							icon = "[I]",
							desc = "ignore case",
						},
					},
				},
			},
			find_engine = {
				["rg"] = {
					cmd = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
					options = {
						["ignore-case"] = {
							value = "--ignore-case",
							icon = "[I]",
							desc = "ignore case",
						},
						["hidden"] = {
							value = "--hidden",
							desc = "hidden file",
							icon = "[H]",
						},
					},
				},
			},
			is_insert_mode = false,
			is_block_ui_break = false,
			mapping = {
				["toggle_line"] = {
					map = "dd",
					cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
					desc = "toggle item",
				},
				["enter_file"] = {
					map = "<cr>",
					cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
					desc = "open file",
				},
				["send_to_qf"] = {
					map = "<leader>q",
					cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
					desc = "send all items to quickfix",
				},
				["replace_cmd"] = {
					map = "<leader>c",
					cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
					desc = "input replace command",
				},
				["run_current_replace"] = {
					map = "<leader>rc",
					cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
					desc = "replace current line",
				},
				["run_replace"] = {
					map = "<leader>R",
					cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
					desc = "replace all",
				},
				["change_view_mode"] = {
					map = "<leader>v",
					cmd = "<cmd>lua require('spectre').change_view()<CR>",
					desc = "change result view mode",
				},
				["change_replace_sed"] = {
					map = "trs",
					cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
					desc = "use sed to replace",
				},
				["change_replace_oxi"] = {
					map = "tro",
					cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
					desc = "use oxi to replace",
				},
				["toggle_live_update"] = {
					map = "tu",
					cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
					desc = "update when vim writes to file",
				},
				["toggle_ignore_case"] = {
					map = "ti",
					cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
					desc = "toggle ignore case",
				},
				["toggle_ignore_hidden"] = {
					map = "th",
					cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
					desc = "toggle search hidden",
				},
			},
		},
	},
	-- Add better search highlighting
	{
		"kevinhwang91/nvim-hlslens",
		event = "VeryLazy",
		opts = {
			calm_down = true,
			nearest_only = true,
			nearest_float_when = "always",
		},
		keys = {
			{ "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
			{ "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
			{ "*", [[*<Cmd>lua require('hlslens').start()<CR>]] },
			{ "#", [[#<Cmd>lua require('hlslens').start()<CR>]] },
			{ "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]] },
			{ "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]] },
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		enabled = vim.fn.executable("make") == 1,
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		vscode = true,
		opts = {},
        -- stylua: ignore
        keys = {
            { "gs",    mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash Jump" },
            { "gS",    mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			spec = {
				mode = { "n", "v" },
				{ "g", group = "goto" },
				{ "gs", group = "surround" },
				{ "]", group = "next" },
				{ "{", group = "prev" },
				{ "<leader><tab>", group = "tabs" },
				{ "<leader>b", group = "buffer" },
				{ "<leader>c", group = "code" },
				{ "<leader>f", group = "file/find" },
				{ "<leader>g", group = "git" },
				{ "<leader>gh", group = "hunks" },
				{ "<leader>q", group = "quit/session" },
				{ "<leader>s", group = "search" },
				{ "<leader>u", group = "ui" },
				{ "<leader>w", group = "windows" },
				{ "<leader>x", group = "diagnostics/quickfix" },
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		tag = "0.1.4",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			telescope.load_extension("media_files")
			telescope.load_extension('lazygit')

			telescope.setup({
				defaults = {
					path_display = { "truncate " },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},
				},
				extensions = {
					media_files = {
						-- filetypes whitelist
						-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
						filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "webm", "pdf", "epub" },
						find_cmd = "fzf", -- find command (defaults to `fd`)
					},
				},
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		event = "VeryLazy",
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
}
