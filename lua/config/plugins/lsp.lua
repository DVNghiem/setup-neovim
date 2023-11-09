return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "glepnir/lspsaga.nvim",
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

        local opts = { noremap = true, silent = true }

        -- code action
        local codeaction = require("lspsaga.codeaction")
        vim.keymap.set("n", "<leader>ca", function() codeaction:code_action() end, { silent = true })
        vim.keymap.set("v", "<leader>ca", function()
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
            codeaction:range_code_action()
        end, { silent = true })

        local nvim_lsp = require 'lspconfig'

        local on_attach = function(client)
            require 'completion'.on_attach(client)
        end

        nvim_lsp.rust_analyzer.setup({
            on_attach = on_attach,
            settings = {
                ["rust-analyzer"] = {
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true
                    },
                }
            }
        })
    end,
}
