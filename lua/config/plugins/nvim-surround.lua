return {
	"kylechui/nvim-surround",
	event = "VeryLazy",
	version = "^4.0.0",
	config = function()
		require("nvim-surround").setup({
			-- Configuration options only (keymaps are automatic in v4)
		})
	end,
}
