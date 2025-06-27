return {
    "lukas-reineke/indent-blankline.nvim",
    event = {"BufReadPost", "BufNewFile"}, -- Changed from BufReadPre for faster file opening
    main = "ibl",
    opts = {
        indent = {
            char = "┊"
        }
    }
}
