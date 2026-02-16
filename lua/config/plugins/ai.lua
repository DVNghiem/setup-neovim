return {
	-- Copilot core
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		build = ":Copilot auth",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 150,
				keymap = {
					accept = "<M-l>",
					accept_word = "<M-w>",
					accept_line = "<M-j>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<M-h>",
				},
			},
			panel = { enabled = false },
			filetypes = { ["*"] = true },
		},
	},

	-- Copilot completion source
	{
		"zbirenbaum/copilot-cmp",
		dependencies = "copilot.lua",
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- Copilot chat
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			"zbirenbaum/copilot.lua",
			"nvim-lua/plenary.nvim",
		},
		cmd = { "CopilotChat", "CopilotChatToggle", "CopilotChatExplain", "CopilotChatFix", "CopilotChatOptimize" },
		keys = {
			{ "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
			{ "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Explain Code", mode = "v" },
			{ "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "Fix Code", mode = "v" },
			{ "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize Code", mode = "v" },
		},
		opts = {
			debug = false,
			window = {
				layout = "vertical",
				width = 0.4,
				border = "rounded",
			},
			mappings = {
				close = { normal = "q", insert = "<C-c>" },
				reset = { normal = "<C-r>" },
				submit_prompt = { normal = "<CR>", insert = "<C-s>" },
			},
		},
	},
}
