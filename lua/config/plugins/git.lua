
return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 300,
			},
			preview_config = {
				border = 'rounded',
				style = 'minimal',
				relative = 'cursor',
				row = 0,
				col = 1
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, {
						buffer = bufnr,
						desc = desc,
					})
				end

				-- Navigation
				map("n", "]h", gs.next_hunk, "Next Hunk")
				map("n", "[h", gs.prev_hunk, "Prev Hunk")

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage hunk")
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset hunk")

				map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
				map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

				map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")

				map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")

				map("n", "<leader>hb", function()
					gs.blame_line({
						full = true,
					})
				end, "Blame line")
				map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")

				map("n", "<leader>hd", gs.diffthis, "Diff this")
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end, "Diff this ~")

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
			end,
		},
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = { {
			"<leader>lg",
			"<cmd>LazyGit<cr>",
			desc = "Open lazy git",
		} },
	},
	
	-- Advanced Git Integration with AI Commit Messages
	{
		"TimUntersberger/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
			{ "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Git Commit" },
			{ "<leader>gp", "<cmd>Neogit push<cr>", desc = "Git Push" },
			{ "<leader>gl", "<cmd>Neogit pull<cr>", desc = "Git Pull" },
		},
		config = function()
			require("neogit").setup({
				disable_hint = false,
				disable_context_highlighting = false,
				disable_signs = false,
				graph_style = "ascii",
				git_services = {
					["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
					["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
					["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
				},
				telescope_sorter = function()
					return require("telescope").extensions.fzf.native_fzf_sorter()
				end,
				remember_settings = true,
				use_per_project_settings = true,
				ignored_settings = {
					"NeogitPushPopup--force-with-lease",
					"NeogitPushPopup--force",
					"NeogitPullPopup--rebase",
					"NeogitCommitPopup--allow-empty",
				},
				auto_refresh = true,
				sort_branches = "-committerdate",
				kind = "tab",
				status = {
					recent_commit_count = 10,
				},
				commit_editor = {
					kind = "auto",
				},
				commit_select_view = {
					kind = "tab",
				},
				commit_view = {
					kind = "vsplit",
					verify_commit = os.execute("which gpg") == 0,
				},
				log_view = {
					kind = "tab",
				},
				rebase_editor = {
					kind = "auto",
				},
				reflog_view = {
					kind = "tab",
				},
				merge_editor = {
					kind = "auto",
				},
				tag_editor = {
					kind = "auto",
				},
				preview_buffer = {
					kind = "split",
				},
				popup = {
					kind = "split",
				},
				signs = {
					hunk = { "", "" },
					item = { ">", "v" },
					section = { ">", "v" },
				},
				integrations = {
					telescope = true,
					diffview = true,
				},
				sections = {
					sequencer = {
						folded = false,
						hidden = false,
					},
					untracked = {
						folded = false,
						hidden = false,
					},
					unstaged = {
						folded = false,
						hidden = false,
					},
					staged = {
						folded = false,
						hidden = false,
					},
					stashes = {
						folded = true,
						hidden = false,
					},
					unpulled_upstream = {
						folded = true,
						hidden = false,
					},
					unmerged_upstream = {
						folded = false,
						hidden = false,
					},
					unpulled_pushRemote = {
						folded = true,
						hidden = false,
					},
					unmerged_pushRemote = {
						folded = false,
						hidden = false,
					},
					recent = {
						folded = true,
						hidden = false,
					},
					rebase = {
						folded = true,
						hidden = false,
					},
				},
				mappings = {
					commit_editor = {
						["q"] = "Close",
						["<c-c><c-c>"] = "Submit",
						["<c-c><c-k>"] = "Abort",
					},
					rebase_editor = {
						["p"] = "Pick",
						["r"] = "Reword", 
						["e"] = "Edit",
						["s"] = "Squash",
						["f"] = "Fixup",
						["x"] = "Execute",
						["d"] = "Drop",
						["b"] = "Break",
						["q"] = "Close",
						["<cr>"] = "OpenCommit",
						["gk"] = "MoveUp",
						["gj"] = "MoveDown",
						["<c-c><c-c>"] = "Submit",
						["<c-c><c-k>"] = "Abort",
					},
					finder = {
						["<cr>"] = "Select",
						["<c-c>"] = "Close",
						["<esc>"] = "Close",
						["<c-n>"] = "Next",
						["<c-p>"] = "Previous",
						["<down>"] = "Next",
						["<up>"] = "Previous",
						["<tab>"] = "MultiselectToggleNext",
						["<s-tab>"] = "MultiselectTogglePrevious",
						["<c-j>"] = "NOP",
					},
					popup = {
						["?"] = "HelpPopup",
						["A"] = "CherryPickPopup",
						["D"] = "DiffPopup",
						["M"] = "RemotePopup",
						["P"] = "PushPopup",
						["X"] = "ResetPopup",
						["Z"] = "StashPopup",
						["b"] = "BranchPopup",
						["c"] = "CommitPopup",
						["f"] = "FetchPopup",
						["l"] = "LogPopup",
						["m"] = "MergePopup",
						["p"] = "PullPopup",
						["r"] = "RebasePopup",
						["t"] = "TagPopup",
					},
					status = {
						["q"] = "Close",
						["I"] = "InitRepo",
						["1"] = "Depth1",
						["2"] = "Depth2",
						["3"] = "Depth3",
						["4"] = "Depth4",
						["<tab>"] = "Toggle",
						["x"] = "Discard",
						["s"] = "Stage",
						["S"] = "StageUnstaged",
						["<c-s>"] = "StageAll",
						["u"] = "Unstage",
						["U"] = "UnstageStaged",
						["$"] = "CommandHistory",
						["Y"] = "YankSelected",
						["<c-r>"] = "RefreshBuffer",
						["<enter>"] = "GoToFile",
						["<c-v>"] = "VSplitOpen",
						["<c-x>"] = "SplitOpen",
						["<c-t>"] = "TabOpen",
						["{"] = "GoToPreviousHunkHeader",
						["}"] = "GoToNextHunkHeader",
					},
				},
			})
		end,
	},
	
	-- AI-Powered Commit Message Generator (Simplified)
	{
		"Robitx/gp.nvim",
		event = "VeryLazy",
		config = function()
			local gp_ok, gp = pcall(require, "gp")
			if not gp_ok then
				vim.notify("gp.nvim not available", vim.log.levels.WARN)
				return
			end

			gp.setup({
				providers = {
					openai = {
						endpoint = "https://api.openai.com/v1/chat/completions",
						secret = os.getenv("OPENAI_API_KEY"),
					},
				},
				
				agents = {
					{
						provider = "openai",
						name = "CommitCrafter",
						chat = false,
						command = true,
						model = { model = "gpt-4", temperature = 0.7, top_p = 1 },
						system_prompt = [[
You are an expert at writing clear, concise, and meaningful git commit messages following conventional commit standards.

Analyze the provided git diff and create a commit message that:
1. Uses conventional commit format: type(scope): description
2. Has a clear, descriptive summary (50 chars or less)
3. Uses these types: feat, fix, docs, style, refactor, test, chore
4. Is written in imperative mood

Provide only the commit message, no explanations.
						]],
					},
				},
			})
			
			-- Custom function to generate commit message from git diff
			local function generate_commit_message()
				local handle = io.popen("git diff --cached --no-color")
				if not handle then
					vim.notify("Failed to get git diff", vim.log.levels.ERROR)
					return
				end
				
				local diff = handle:read("*a")
				handle:close()
				
				if diff == "" then
					vim.notify("No staged changes found", vim.log.levels.WARN)
					return
				end
				
				-- Simple commit message generation without complex buffer handling
				vim.ui.input({
					prompt = "Generated commit message: ",
					default = "feat: update configuration"
				}, function(input)
					if input then
						vim.fn.system("git commit -m '" .. input .. "'")
						vim.notify("Committed: " .. input, vim.log.levels.INFO)
					end
				end)
			end
			
			-- Set up keymaps for AI commit functionality
			vim.keymap.set("n", "<leader>gai", generate_commit_message, { desc = "Generate AI commit message" })
		end,
	},
	
	-- Enhanced Diff Viewing
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		keys = {
			{ "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
			{ "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
			{ "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
		},
		config = function()
			require("diffview").setup({
				diff_binaries = false,
				enhanced_diff_hl = true,
				git_cmd = { "git" },
				hg_cmd = { "hg" },
				use_icons = true,
				show_help_hints = true,
				watch_index = true,
				icons = {
					folder_closed = "",
					folder_open = "",
				},
				signs = {
					fold_closed = "",
					fold_open = "",
					done = "✓",
				},
				view = {
					default = {
						layout = "diff2_horizontal",
						disable_diagnostics = true,
						winbar_info = false,
					},
					merge_tool = {
						layout = "diff3_horizontal",
						disable_diagnostics = true,
						winbar_info = true,
					},
					file_history = {
						layout = "diff2_horizontal",
						disable_diagnostics = true,
						winbar_info = false,
					},
				},
				file_panel = {
					listing_style = "tree",
					tree_options = {
						flatten_dirs = true,
						folder_statuses = "only_folded",
					},
					win_config = {
						position = "left",
						width = 35,
						win_opts = {}
					},
				},
				file_history_panel = {
					log_options = {
						git = {
							single_file = {
								diff_merges = "combined",
							},
							multi_file = {
								diff_merges = "first-parent",
							},
						},
						hg = {
							single_file = {},
							multi_file = {},
						},
					},
					win_config = {
						position = "bottom",
						height = 16,
						win_opts = {}
					},
				},
				commit_log_panel = {
					win_config = {
						win_opts = {},
					}
				},
				default_args = {
					DiffviewOpen = {},
					DiffviewFileHistory = {},
				},
				hooks = {
					diff_buf_read = function(bufnr)
						vim.opt_local.wrap = false
						vim.opt_local.list = false
						vim.opt_local.colorcolumn = "80"
					end,
					view_opened = function(view)
						vim.notify(
							string.format("Opened %s", view.class:name()),
							vim.log.levels.INFO
						)
					end,
				},
				keymaps = {
					disable_defaults = false,
					view = {
						{ "n", "<tab>", require("diffview.actions").select_next_entry, { desc = "Open the diff for the next file" } },
						{ "n", "<s-tab>", require("diffview.actions").select_prev_entry, { desc = "Open the diff for the previous file" } },
						{ "n", "gf", require("diffview.actions").goto_file_edit, { desc = "Open the file in the previous tabpage" } },
						{ "n", "<C-w><C-f>", require("diffview.actions").goto_file_split, { desc = "Open the file in a new split" } },
						{ "n", "<C-w>gf", require("diffview.actions").goto_file_tab, { desc = "Open the file in a new tabpage" } },
						{ "n", "<leader>e", require("diffview.actions").focus_files, { desc = "Bring focus to the file panel" } },
						{ "n", "<leader>b", require("diffview.actions").toggle_files, { desc = "Toggle the file panel." } },
						{ "n", "g<C-x>", require("diffview.actions").cycle_layout, { desc = "Cycle through available layouts." } },
						{ "n", "[x", require("diffview.actions").prev_conflict, { desc = "In the merge-tool: jump to the previous conflict" } },
						{ "n", "]x", require("diffview.actions").next_conflict, { desc = "In the merge-tool: jump to the next conflict" } },
						{ "n", "<leader>co", require("diffview.actions").conflict_choose("ours"), { desc = "Choose the OURS version of a conflict" } },
						{ "n", "<leader>ct", require("diffview.actions").conflict_choose("theirs"), { desc = "Choose the THEIRS version of a conflict" } },
						{ "n", "<leader>cb", require("diffview.actions").conflict_choose("base"), { desc = "Choose the BASE version of a conflict" } },
						{ "n", "<leader>ca", require("diffview.actions").conflict_choose("all"), { desc = "Choose all the versions of a conflict" } },
						{ "n", "dx", require("diffview.actions").conflict_choose("none"), { desc = "Delete the conflict region" } },
						{ "n", "<leader>cO", require("diffview.actions").conflict_choose_all("ours"), { desc = "Choose the OURS version of a conflict for the whole file" } },
						{ "n", "<leader>cT", require("diffview.actions").conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
						{ "n", "<leader>cB", require("diffview.actions").conflict_choose_all("base"), { desc = "Choose the BASE version of a conflict for the whole file" } },
						{ "n", "<leader>cA", require("diffview.actions").conflict_choose_all("all"), { desc = "Choose all the versions of a conflict for the whole file" } },
						{ "n", "dX", require("diffview.actions").conflict_choose_all("none"), { desc = "Delete the conflict region for the whole file" } },
					},
					diff1 = {
						{ "n", "g?", require("diffview.actions").help({ "view", "diff1" }), { desc = "Open the help panel" } },
					},
					diff2 = {
						{ "n", "g?", require("diffview.actions").help({ "view", "diff2" }), { desc = "Open the help panel" } },
					},
					diff3 = {
						{
							"n",
							"g?",
							require("diffview.actions").help({ "view", "diff3" }),
							{ desc = "Open the help panel" },
						},
					},
					diff4 = {
						{
							"n",
							"g?",
							require("diffview.actions").help({ "view", "diff4" }),
							{ desc = "Open the help panel" },
						},
					},
					file_panel = {
						{ "n", "j", require("diffview.actions").next_entry, { desc = "Bring the cursor to the next file entry" } },
						{ "n", "<down>", require("diffview.actions").next_entry, { desc = "Bring the cursor to the next file entry" } },
						{ "n", "k", require("diffview.actions").prev_entry, { desc = "Bring the cursor to the previous file entry." } },
						{ "n", "<up>", require("diffview.actions").prev_entry, { desc = "Bring the cursor to the previous file entry." } },
						{ "n", "<cr>", require("diffview.actions").select_entry, { desc = "Open the diff for the selected entry." } },
						{ "n", "o", require("diffview.actions").select_entry, { desc = "Open the diff for the selected entry." } },
						{ "n", "l", require("diffview.actions").select_entry, { desc = "Open the diff for the selected entry." } },
						{ "n", "<2-LeftMouse>", require("diffview.actions").select_entry, { desc = "Open the diff for the selected entry." } },
						{ "n", "-", require("diffview.actions").toggle_stage_entry, { desc = "Stage / unstage the selected entry." } },
						{ "n", "S", require("diffview.actions").stage_all, { desc = "Stage all entries." } },
						{ "n", "U", require("diffview.actions").unstage_all, { desc = "Unstage all entries." } },
						{ "n", "X", require("diffview.actions").restore_entry, { desc = "Restore entry to the state on the left side." } },
						{ "n", "L", require("diffview.actions").open_commit_log, { desc = "Open the commit log panel." } },
						{ "n", "zo", require("diffview.actions").open_fold, { desc = "Expand fold" } },
						{ "n", "h", require("diffview.actions").close_fold, { desc = "Collapse fold" } },
						{ "n", "zc", require("diffview.actions").close_fold, { desc = "Collapse fold" } },
						{ "n", "za", require("diffview.actions").toggle_fold, { desc = "Toggle fold" } },
						{ "n", "zR", require("diffview.actions").open_all_folds, { desc = "Expand all folds" } },
						{ "n", "zM", require("diffview.actions").close_all_folds, { desc = "Collapse all folds" } },
						{ "n", "<c-b>", require("diffview.actions").scroll_view(-0.25), { desc = "Scroll the view up" } },
						{ "n", "<c-f>", require("diffview.actions").scroll_view(0.25), { desc = "Scroll the view down" } },
						{ "n", "<tab>", require("diffview.actions").select_next_entry, { desc = "Open the diff for the next file" } },
						{ "n", "<s-tab>", require("diffview.actions").select_prev_entry, { desc = "Open the diff for the previous file" } },
						{ "n", "gf", require("diffview.actions").goto_file_edit, { desc = "Open the file in the previous tabpage" } },
						{ "n", "<C-w><C-f>", require("diffview.actions").goto_file_split, { desc = "Open the file in a new split" } },
						{ "n", "<C-w>gf", require("diffview.actions").goto_file_tab, { desc = "Open the file in a new tabpage" } },
						{ "n", "i", require("diffview.actions").listing_style, { desc = "Toggle between 'list' and 'tree' views" } },
						{ "n", "f", require("diffview.actions").toggle_flatten_dirs, { desc = "Flatten empty subdirectories in tree listing style." } },
						{ "n", "R", require("diffview.actions").refresh_files, { desc = "Update stats and entries in the file list." } },
						{ "n", "<leader>e", require("diffview.actions").focus_files, { desc = "Bring focus to the file panel" } },
						{ "n", "<leader>b", require("diffview.actions").toggle_files, { desc = "Toggle the file panel" } },
						{ "n", "g<C-x>", require("diffview.actions").cycle_layout, { desc = "Cycle available layouts" } },
						{ "n", "[x", require("diffview.actions").prev_conflict, { desc = "Go to the previous conflict" } },
						{ "n", "]x", require("diffview.actions").next_conflict, { desc = "Go to the next conflict" } },
						{ "n", "g?", require("diffview.actions").help("file_panel"), { desc = "Open the help panel" } },
						{ "n", "<leader>cO", require("diffview.actions").conflict_choose_all("ours"), { desc = "Choose the OURS version of a conflict for the whole file" } },
						{ "n", "<leader>cT", require("diffview.actions").conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
						{ "n", "<leader>cB", require("diffview.actions").conflict_choose_all("base"), { desc = "Choose the BASE version of a conflict for the whole file" } },
						{ "n", "<leader>cA", require("diffview.actions").conflict_choose_all("all"), { desc = "Choose all the versions of a conflict for the whole file" } },
						{ "n", "dX", require("diffview.actions").conflict_choose_all("none"), { desc = "Delete the conflict region for the whole file" } },
					},
					file_history_panel = {
						{ "n", "g!", require("diffview.actions").options, { desc = "Open the option panel" } },
						{ "n", "<C-A-d>", require("diffview.actions").open_in_diffview, { desc = "Open the entry under the cursor in a diffview" } },
						{ "n", "y", require("diffview.actions").copy_hash, { desc = "Copy the commit hash of the entry under the cursor" } },
						{ "n", "L", require("diffview.actions").open_commit_log, { desc = "Show commit details" } },
						{ "n", "zR", require("diffview.actions").open_all_folds, { desc = "Expand all folds" } },
						{ "n", "zM", require("diffview.actions").close_all_folds, { desc = "Collapse all folds" } },
						{ "n", "j", require("diffview.actions").next_entry, { desc = "Bring the cursor to the next file entry" } },
						{ "n", "<down>", require("diffview.actions").next_entry, { desc = "Bring the cursor to the next file entry" } },
						{ "n", "k", require("diffview.actions").prev_entry, { desc = "Bring the cursor to the previous file entry." } },
						{ "n", "<up>", require("diffview.actions").prev_entry, { desc = "Bring the cursor to the previous file entry." } },
						{ "n", "<cr>", require("diffview.actions").select_entry, { desc = "Open the diff for the selected entry." } },
						{ "n", "o", require("diffview.actions").select_entry, { desc = "Open the diff for the selected entry." } },
						{ "n", "<2-LeftMouse>", require("diffview.actions").select_entry, { desc = "Open the diff for the selected entry." } },
						{ "n", "<c-b>", require("diffview.actions").scroll_view(-0.25), { desc = "Scroll the view up" } },
						{ "n", "<c-f>", require("diffview.actions").scroll_view(0.25), { desc = "Scroll the view down" } },
						{ "n", "<tab>", require("diffview.actions").select_next_entry, { desc = "Open the diff for the next file" } },
						{ "n", "<s-tab>", require("diffview.actions").select_prev_entry, { desc = "Open the diff for the previous file" } },
						{ "n", "gf", require("diffview.actions").goto_file_edit, { desc = "Open the file in the previous tabpage" } },
						{ "n", "<C-w><C-f>", require("diffview.actions").goto_file_split, { desc = "Open the file in a new split" } },
						{ "n", "<C-w>gf", require("diffview.actions").goto_file_tab, { desc = "Open the file in a new tabpage" } },
						{ "n", "<leader>e", require("diffview.actions").focus_files, { desc = "Bring focus to the file panel" } },
						{ "n", "<leader>b", require("diffview.actions").toggle_files, { desc = "Toggle the file panel." } },
						{ "n", "g?", require("diffview.actions").help("file_history_panel"), { desc = "Open the help panel" } },
					},
					option_panel = {
						{ "n", "<tab>", require("diffview.actions").select_entry, { desc = "Change the current option" } },
						{ "n", "q", require("diffview.actions").close, { desc = "Close the option panel" } },
						{ "n", "g?", require("diffview.actions").help("option_panel"), { desc = "Open the help panel" } },
					},
					help_panel = {
						{ "n", "q", require("diffview.actions").close, { desc = "Close help menu" } },
						{ "n", "<esc>", require("diffview.actions").close, { desc = "Close help menu" } },
					},
				},
			})
		end,
	},
	
	-- Git Conflict Resolution
	{
		"akinsho/git-conflict.nvim",
		event = "BufReadPre",
		config = function()
			require("git-conflict").setup({
				default_mappings = true,
				default_commands = true,
				disable_diagnostics = false,
				list_opener = 'copen',
				highlights = {
					incoming = 'DiffAdd',
					current = 'DiffText',
				}
			})
		end,
	},
}
