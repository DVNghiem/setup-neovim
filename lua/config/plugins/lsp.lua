return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "glepnir/lspsaga.nvim",
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        event = "VeryLazy",
        config = function()
            local status, saga = pcall(require, "lspsaga")
            if (not status) then return end
            saga.setup({
                ui = {
                    winblend = 10,
                    border = 'rounded',
                    colors = {
                        normal_bg = '#002b36'
                    }
                }
            })

            -- code action
            local codeaction = require("lspsaga.codeaction")
            vim.keymap.set("n", "<leader>ca", function() codeaction:code_action() end, { silent = true })
            vim.keymap.set("v", "<leader>ca", function()
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
                codeaction:range_code_action()
            end, { silent = true })
        end,
    },
    {

        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr:on("package:install:success", function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    }
}
