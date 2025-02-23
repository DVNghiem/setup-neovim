-- Show context of the current function
return {
	"nvim-treesitter/nvim-treesitter-context",
	event = _G.BufEvent,
	opts = { mode = "cursor", max_lines = 5 },
}
