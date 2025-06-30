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
				desc = "🔍 Search & Replace in Project",
			},
			{
				"<leader>sw",
				function()
					require("spectre").open_visual({ select_word = true })
				end,
				desc = "🔍 Search & Replace Current Word",
			},
			{
				"<leader>sp",
				function()
					require("spectre").open_file_search({ select_word = true })
				end,
				desc = "🔍 Search & Replace in Current File",
			},
			{
				"<leader>sW",
				function()
					require("spectre").open({
						search_text = vim.fn.expand("<cword>"),
						path = vim.fn.expand("%:p:h")
					})
				end,
				desc = "🔍 Search Word in Directory",
			},
		},
		opts = {
			open_cmd = "noswapfile vnew",
			live_update = true,
			line_sep_start = '┌─────────────────────────────────────────',
			result_padding = '¦  ',
			line_sep       = '└─────────────────────────────────────────',
			highlight = {
				ui = "String",
				search = "DiffChange",
				replace = "DiffDelete"
			},
			default = {
				find = {
					cmd = "rg",
					options = { 
						"ignore-case",
						"hidden",
						"glob",
						"smart-case"
					},
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
						"--smart-case",
					},
					options = {
						["ignore-case"] = {
							value = "--ignore-case",
							icon = "[Aa]",
							desc = "ignore case",
						},
						["hidden"] = {
							value = "--hidden",
							desc = "search hidden files",
							icon = "[H]",
						},
						["no-ignore"] = {
							value = "--no-ignore",
							desc = "search .gitignore files",
							icon = "[I]",
						},
						["word-regexp"] = {
							value = "--word-regexp",
							desc = "match whole words only",
							icon = "[W]",
						},
						["fixed-strings"] = {
							value = "--fixed-strings",
							desc = "literal string search",
							icon = "[F]",
						},
						["glob"] = {
							value = "--glob",
							desc = "include/exclude files",
							icon = "[G]",
						},
					},
				},
				["ag"] = {
					cmd = "ag",
					args = {
						"--vimgrep",
						"-s"
					},
					options = {
						["ignore-case"] = {
							value = "-i",
							icon = "[Aa]",
							desc = "ignore case",
						},
						["hidden"] = {
							value = "--hidden",
							desc = "search hidden files",
							icon = "[H]",
						},
						["word-regexp"] = {
							value = "-w",
							desc = "match whole words only",
							icon = "[W]",
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
					desc = "toggle current item",
				},
				["enter_file"] = {
					map = "<cr>",
					cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
					desc = "goto current file",
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
				["show_option_menu"] = {
					map = "<leader>o",
					cmd = "<cmd>lua require('spectre').show_options()<CR>",
					desc = "show search options",
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
					desc = "auto update changes when vim writes file",
				},
				["toggle_ignore_case"] = {
					map = "ti",
					cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
					desc = "toggle ignore case",
				},
				["toggle_ignore_hidden"] = {
					map = "th",
					cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
					desc = "toggle search hidden files",
				},
				["toggle_word_regexp"] = {
					map = "tw",
					cmd = "<cmd>lua require('spectre').change_options('word-regexp')<CR>",
					desc = "toggle whole word match",
				},
				["toggle_no_ignore"] = {
					map = "tg",
					cmd = "<cmd>lua require('spectre').change_options('no-ignore')<CR>",
					desc = "toggle search gitignore files",
				},
				["resume_last_search"] = {
					map = "<leader>l",
					cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
					desc = "resume last search",
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
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts_extend = { "spec" },
		opts = {
			preset = "helix",
			defaults = {},
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
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			if not vim.tbl_isempty(opts.defaults) then
				LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
				wk.register(opts.defaults)
			end
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		tag = "0.1.4",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local lga_actions = require("telescope-live-grep-args.actions")

			telescope.load_extension("media_files")
			telescope.load_extension('lazygit')
			telescope.load_extension("file_browser")
			telescope.load_extension("live_grep_args")

			telescope.setup({
				defaults = {
					path_display = { "truncate" },
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					sorting_strategy = "ascending",
					winblend = 0,
					prompt_prefix = "🔍 ",
					selection_caret = "➤ ",
					entry_prefix = "  ",
					initial_mode = "insert",
					selection_strategy = "reset",
					file_sorter = require("telescope.sorters").get_fuzzy_file,
					file_ignore_patterns = { 
						"node_modules", 
						".git/", 
						"%.lock",
						"dist/",
						"build/",
						"%.log",
						"%.cache",
					},
					generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
					color_devicons = true,
					use_less = true,
					set_env = { ["COLORTERM"] = "truecolor" },
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-x>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,
							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
							["<C-c>"] = actions.close,
							["<Esc>"] = actions.close,
							["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
							["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
							["<C-a>"] = actions.select_all,
							["<C-l>"] = actions.complete_tag,
						},
						n = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["dd"] = actions.delete_buffer,
							["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
							["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
							["<C-a>"] = actions.select_all,
						},
					},
				},
				pickers = {
					find_files = {
						hidden = false,
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
						theme = "dropdown",
						previewer = false,
						layout_config = {
							width = 0.6,
							height = 0.6,
						},
					},
					live_grep = {
						theme = "ivy",
						layout_config = {
							height = 0.4,
						},
						additional_args = function()
							return { "--hidden", "--smart-case" }
						end,
					},
					grep_string = {
						theme = "ivy",
						layout_config = {
							height = 0.4,
						},
					},
					buffers = {
						theme = "dropdown",
						previewer = false,
						sort_lastused = true,
						sort_mru = true,
						layout_config = {
							width = 0.6,
							height = 0.6,
						},
					},
					help_tags = {
						theme = "ivy",
					},
					git_files = {
						theme = "dropdown",
						previewer = false,
					},
					oldfiles = {
						theme = "dropdown",
						previewer = false,
					},
				},
				extensions = {
					media_files = {
						filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "webm", "pdf", "epub" },
						find_cmd = "rg",
					},
					file_browser = {
						theme = "ivy",
						hijack_netrw = true,
						mappings = {
							["i"] = {
								["<C-w>"] = function() return require("telescope._extensions.file_browser.actions").goto_parent_dir() end,
							},
							["n"] = {
								["h"] = function() return require("telescope._extensions.file_browser.actions").goto_parent_dir() end,
								["l"] = actions.select_default,
							},
						},
					},
					live_grep_args = {
						auto_quoting = true,
						mappings = {
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
								["<C-space>"] = actions.to_fuzzy_refine,
							},
						},
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
	-- VS Code-like search panel
	{
		"roobert/search-replace.nvim",
		config = function()
			require("search-replace").setup({
				default_replace_single_buffer_options = "gcI",
				default_replace_multi_buffer_options = "egcI",
			})
		end,
		keys = {
			{
				"<leader>rp",
				function()
					require("search-replace").open()
				end,
				desc = "🔍 Open Search & Replace Panel",
			},
			{
				"<leader>rb",
				function()
					require("search-replace").replace_in_buffer()
				end,
				desc = "🔍 Replace in Current Buffer",
			},
			{
				"<leader>rs",
				function()
					require("search-replace").replace_in_selection()
				end,
				mode = "v",
				desc = "🔍 Replace in Selection",
			},
		},
	},
	-- Enhanced search UI similar to VS Code
	{
		"MagicDuck/grug-far.nvim",
		config = function()
			require('grug-far').setup({
				headerMaxWidth = 80,
				resultLocation = {
					showNumberColumn = true,
				},
				transient = false,
				keymaps = {
					replace = { n = '<localleader>r' },
					qflist = { n = '<localleader>q' },
					syncLocations = { n = '<localleader>s' },
					syncLine = { n = '<localleader>l' },
					close = { n = '<localleader>c' },
					historyOpen = { n = '<localleader>t' },
					historyAdd = { n = '<localleader>a' },
					refresh = { n = '<localleader>f' },
					openLocation = { n = '<localleader>o' },
					gotoLocation = { n = '<enter>' },
					pickHistoryEntry = { n = '<enter>' },
					abort = { n = '<localleader>b' },
					help = { n = 'g?' },
					toggleShowCommand = { n = '<localleader>p' },
					swapReplacementInterpreter = { n = '<localleader>x' },
				},
				icons = {
					enabled = true,
					pattern = '🔍',
					replacement = '🔄',
					folderFull = '📁',
					folderEmpty = '📂',
					file = '📄',
					line = '📝',
					column = '📍',
				},
			})
		end,
		keys = {
			{
				"<leader>sf",
				function()
					require('grug-far').open()
				end,
				desc = "🔍 Advanced Search & Replace (Grug-Far)",
			},
			{
				"<leader>sF",
				function()
					require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
				end,
				desc = "🔍 Search Current Word (Grug-Far)",
			},
		},
	},
	-- Better quickfix and search navigation
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		dependencies = {
			{
				"junegunn/fzf",
				build = function()
					vim.fn["fzf#install"]()
				end,
			},
		},
		config = function()
			require('bqf').setup({
				auto_enable = true,
				auto_resize_height = true,
				preview = {
					win_height = 12,
					win_vheight = 12,
					delay_syntax = 80,
					border_chars = { "┃", "━", "┏", "┓", "┗", "┛", "┣", "┫", "━" },
					should_preview_cb = function(bufnr, qwinid)
						local ret = true
						local bufname = vim.api.nvim_buf_get_name(bufnr)
						local fsize = vim.fn.getfsize(bufname)
						if fsize > 100 * 1024 then
							ret = false
						end
						return ret
					end
				},
				func_map = {
					vsplit = '',
					ptogglemode = 'z,',
					stoggleup = '',
				},
				filter = {
					fzf = {
						action_for = { ['ctrl-s'] = 'split' },
						extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', '🔍 QuickFix > ' }
					}
				}
			})
		end,
	},
	-- Add telescope extensions for better search
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons" },
	},
	-- Search panel similar to VS Code
	{
		"VonHeikemen/searchbox.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("searchbox").setup({
				popup = {
					relative = "win",
					position = {
						row = "5%",
						col = "95%",
					},
					size = 30,
					border = {
						style = "rounded",
						text = {
							top = "🔍 Search",
							top_align = "center",
						},
					},
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
				},
				hooks = {
					before_mount = function(input)
						-- Do something before the searchbox is mounted
					end,
					after_mount = function(input)
						-- Set up additional keymaps for the searchbox
						vim.keymap.set("i", "<Esc>", "<cmd>stopinsert<cr>", { buffer = input.bufnr })
						vim.keymap.set("i", "<Tab>", function()
							vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, false, true))
						end, { buffer = input.bufnr })
						vim.keymap.set("i", "<S-Tab>", function()
							vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, false, true))
						end, { buffer = input.bufnr })
					end,
					on_done = function(value, search_type)
						-- Handle the search result
						if search_type == "exact" then
							-- Exact search
							vim.cmd("silent! /" .. vim.fn.escape(value, "/\\"))
						else
							-- Fuzzy search
							require("telescope.builtin").live_grep({ default_text = value })
						end
					end,
				},
			})
		end,
		keys = {
			{
				"<leader>sb",
				function()
					require("searchbox").incsearch()
				end,
				desc = "🔍 Search Box (incremental)",
			},
			{
				"<leader>sB",
				function()
					require("searchbox").exact_word()
				end,
				desc = "🔍 Search Box (exact word)",
			},
			{
				"<leader>sR",
				function()
					require("searchbox").replace()
				end,
				desc = "🔍 Search & Replace Box",
			},
		},
	},
	-- Better search highlight
	{
		"haya14busa/vim-asterisk",
		keys = {
			{ "*", "<Plug>(asterisk-*)", desc = "Search word under cursor" },
			{ "#", "<Plug>(asterisk-#)", desc = "Search word under cursor (backward)" },
			{ "g*", "<Plug>(asterisk-g*)", desc = "Search word under cursor (no boundary)" },
			{ "g#", "<Plug>(asterisk-g#)", desc = "Search word under cursor (no boundary, backward)" },
		},
		config = function()
			vim.g["asterisk#keeppos"] = 1
		end,
	},
}
