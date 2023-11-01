return {
    "dracula/vim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme dracula]])
        vim.o.background = "dark"
        vim.o.termguicolors = true
        vim.o.t_Co=256
    end,
}
