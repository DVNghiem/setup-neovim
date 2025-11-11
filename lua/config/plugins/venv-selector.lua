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
    end
}
