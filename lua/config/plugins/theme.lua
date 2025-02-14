return {
	"DVNghiem/dracula-vim",
	lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme dracula_pro]])
        vim.o.background = "dark"
        vim.o.termguicolors = true
    end,
}
