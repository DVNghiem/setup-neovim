return {
    {
        "nvim-pack/nvim-spectre",
        build = false,
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
        -- stylua: ignore
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        vscode = true,
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts_extend = { "spec" },
        opts = {
            preset = "helix",
            defaults = {},
            spec = {
                mode = { "n", "v" },
                {"g", group = "goto" },
                {"gs", group = "surround" },
                {"]", group = "next" },
                {"{", group = "prev" },
                {"<leader><tab>", group = "tabs" },
                {"<leader>b", group = "buffer" },
                {"<leader>c", group = "code" },
                {"<leader>f", group = "file/find" },
                {"<leader>g", group = "git" },
                {"<leader>gh", group = "hunks" },
                {"<leader>q", group = "quit/session" },
                {"<leader>s", group = "search" },
                {"<leader>u", group = "ui" },
                {"<leader>w", group = "windows" },
                {"<leader>x", group = "diagnostics/quickfix" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            if not vim.tbl_isempty(opts.defaults) then
              LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
              wk.register(opts.defaults)
            end
          end,
    },
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        tag = "0.1.4",
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    path_display = { "truncate " },
                    mappings = {
                        i = {
                            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                            ["<C-j>"] = actions.move_selection_next,     -- move to next result
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        },
                    },
                },
            })
        end,
    },
    {
        "stevearc/dressing.nvim",
        lazy = true,
        event = "VeryLazy",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

}
