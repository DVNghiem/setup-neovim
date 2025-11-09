return {
    "nvimtools/none-ls.nvim", -- configure formatters & linters
    lazy = true,
    -- event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        local mason_null_ls = require("mason-null-ls")

        local null_ls = require("null-ls")

        local null_ls_utils = require("null-ls.utils")

        mason_null_ls.setup({
            ensure_installed = {
                "pylint", -- python linter
                "eslint_d", -- js linter
            },
        })

        -- for conciseness
        local diagnostics = null_ls.builtins.diagnostics -- to setup linters

        -- configure null_ls
        null_ls.setup({
            -- add package.json as identifier for root (for typescript monorepos)
            root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
            -- setup linters only (formatters handled by conform.nvim)
            sources = {
                diagnostics.pylint,
                diagnostics.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
                    end,
                }),
            },
        })
    end,
}
