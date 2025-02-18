return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            suggestion = { enabled = true },
            panel = { enabled = true },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
            local copilot_cmp = require("copilot_cmp")
            copilot_cmp.setup(opts)
            copilot_cmp._on_insert_enter({})
        end,
    },
    {
        "nvim-cmp",
        dependencies = {
            {
                "zbirenbaum/copilot-cmp",
                dependencies = "copilot.lua",
                opts = {},
                config = function(_, opts)
                    local copilot_cmp = require("copilot_cmp")
                    copilot_cmp.setup(opts)
                    copilot_cmp._on_insert_enter({})
                end,
            },
        },
        opts = function(_, opts)
            table.insert(opts.sources, 1, {
                name = "copilot",
                group_index = 1,
                priority = 1,
            })
        end,
    }
}
