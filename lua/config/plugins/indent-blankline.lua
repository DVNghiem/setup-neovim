return {
    "lukas-reineke/indent-blankline.nvim",
    event = {"BufReadPost", "BufNewFile"}, -- Changed from BufReadPre for faster file opening
    main = "ibl",
    opts = {
        enabled = true,
        indent = {
            char = "│", -- Subtle indent guide
            tab_char = "│",
        },
        whitespace = {
            remove_blankline_trail = true,
        },
        scope = {
            enabled = true,
            show_start = false,
            show_end = false,
            char = "│",
        },
    }
}
