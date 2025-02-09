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
            -- import mason
            local mason = require("mason")

            -- import mason-lspconfig
            local mason_lspconfig = require("mason-lspconfig")

            local mason_tool_installer = require("mason-tool-installer")

            -- enable mason and configure icons
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            mason_lspconfig.setup({
                -- list of servers for mason to install
                ensure_installed = {
                    "ts_ls",
                    "html",
                    "cssls",
                    "tailwindcss",
                    "svelte",
                    "lua_ls",
                    "graphql",
                    "emmet_ls",
                    "prismals",
                    "pyright",
                    "rust_analyzer"
                },
                -- auto-install configured servers (with lspconfig)
                automatic_installation = true, -- not the same as ensure_installed
            })

            mason_tool_installer.setup({
                ensure_installed = {
                    "prettier", -- prettier formatter
                    "stylua", -- lua formatter
                    "isort", -- python formatter
                    "black", -- python formatter
                    "pylint", -- python linter
                    "eslint_d", -- js linter
                },
            })
        end,
    }
}
