return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {"neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python"},
    event = "VeryLazy",
    keys = {{
        "<leader>vs",
        "<cmd>VenvSelect<CR>",
        desc = "Select Virtual Env"
    }, {
        "<leader>vc",
        "<cmd>VenvSelectCached<CR>",
        desc = "Select Cached Env"
    }},
    opts = {
        search_workspace = true,
        search = true,

        auto_refresh = true,

        name = {"venv", ".venv", "odoo-env", "env", ".env"},

        path = vim.fn.getcwd(),

        parents = 3,

        fd_binary_name = "fd",
        dap_enabled = true,

        notify_on_select = true
    },
    config = function(_, opts)
        require("venv-selector").setup(opts)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            callback = function()
                vim.schedule(function()
                    local venv = vim.env.VIRTUAL_ENV
                    if not venv or venv == "" then
                        vim.cmd("VenvSelectCached")
                    end
                end)
            end
        })
    end
}
