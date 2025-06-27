return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvimdev/lspsaga.nvim",
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
            "mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason-lspconfig.nvim",
            { "antosha417/nvim-lsp-file-operations", config = true },
			{"j-hui/fidget.nvim", otp = {}},
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
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            -- Basic mason setup only
            local mason_ok, mason = pcall(require, "mason")
            if not mason_ok then
                vim.notify("Failed to load mason", vim.log.levels.ERROR)
                return
            end

            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
            
            -- Minimal mason-lspconfig setup to avoid the error
            local lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
            if lspconfig_ok then
                -- Use the most minimal setup possible
                pcall(function()
                    mason_lspconfig.setup({
                        ensure_installed = {},
                        automatic_installation = false,
                    })
                end)
            end
        end,
    }
}
