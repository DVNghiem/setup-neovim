return {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    tag = "0.1.4",
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

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
        })
    end,
}
