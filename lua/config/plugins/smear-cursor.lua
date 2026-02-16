return {
	"sphamba/smear-cursor.nvim",
	event = "VeryLazy",
	opts = {
		-- Smear cursor when switching buffers or windows.
		smear_between_buffers = true,

		-- Disable smear for neighbor lines (reduces CPU usage)
		smear_between_neighbor_lines = false,

		-- Draw the smear in buffer space instead of screen space when scrolling
		scroll_buffer_space = false,

		-- Legacy computing symbols
		legacy_computing_symbols_support = true,

		-- Disable smear in insert mode (reduces rendering overhead)
		smear_insert_mode = false,

		stiffness = 0.7,
		trailing_stiffness = 0.5,
		trailing_exponent = 5,
		hide_target_hack = true,
		gamma = 1,
		distance_stop_animating = 0.5,
	},
}
