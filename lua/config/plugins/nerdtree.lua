local keymap = vim.keymap
return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { },

    lazy = false,
    priority = 1000,
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.opt.termguicolors = true
        require("nvim-tree").setup({
            filters = {
                dotfiles = false,
                custom = { '^.git$' }
            },
            view = {
                adaptive_size = true,
            },
            renderer = {
                group_empty = true,
            },
        })
        local opts = {silent = true, nowait = true}
        keymap.set("n", "<leader>e", ":NERDTreeToggle<CR>", opts)

    end,
}
