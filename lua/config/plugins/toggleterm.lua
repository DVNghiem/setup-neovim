return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{ "<C-\\>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Toggle Terminal" },
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical Terminal" },
	},
	opts = {
		open_mapping = [[<C-\>]],
		direction = "float",
		shade_terminals = false,
		float_opts = {
			border = "curved",
			winblend = 0,
		},
	},
}