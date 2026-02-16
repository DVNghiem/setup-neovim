return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- nvim-treesitter should not be lazy-loaded
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
    },
    config = function()
        -- New nvim-treesitter API (v0.11.0+)
        local treesitter = require("nvim-treesitter")
        
        -- Setup is optional - only needed if you want to change install_dir
        treesitter.setup({
            install_dir = vim.fn.stdpath('data') .. '/site',
        })
        
        -- Install language parsers
        local parsers = {
            "json",
            "javascript",
            "typescript",
            "tsx",
            "yaml",
            "markdown",
            "markdown_inline",
            "bash",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "rust",
            "python",
            "go",
            "toml",
        }
        
        -- Install parsers asynchronously
        treesitter.install(parsers)
        
        -- Enable treesitter highlighting for specific filetypes
        vim.api.nvim_create_autocmd('FileType', {
            pattern = {
                'javascript', 'typescript', 'tsx', 'jsx',
                'json', 'yaml',
                'lua', 'vim', 'rust', 'python', 'go',
                'bash', 'sh', 'markdown', 'toml',
            },
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
        
        -- Enable treesitter-based folding
        vim.api.nvim_create_autocmd('FileType', {
            pattern = {
                'javascript', 'typescript', 'tsx', 'jsx',
                'json', 'yaml',
                'lua', 'vim', 'rust', 'python', 'go',
                'bash', 'sh', 'markdown', 'toml',
            },
            callback = function()
                vim.wo[0][0].foldmethod = 'expr'
                vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo[0][0].foldlevel = 99  -- start with all folds open
            end,
        })

        -- PERF: Switch to manual foldmethod in insert mode to prevent
        -- foldexpr from being recalculated on every keystroke
        vim.api.nvim_create_autocmd('InsertEnter', {
            callback = function()
                if vim.wo.foldmethod == 'expr' then
                    vim.w._old_foldmethod = 'expr'
                    vim.wo.foldmethod = 'manual'
                end
            end,
        })
        vim.api.nvim_create_autocmd('InsertLeave', {
            callback = function()
                if vim.w._old_foldmethod == 'expr' then
                    vim.w._old_foldmethod = nil
                    vim.wo.foldmethod = 'expr'
                end
            end,
        })
        
        -- Enable indentation (built into Neovim for supported languages)
        vim.api.nvim_create_autocmd('FileType', {
            pattern = {
                'javascript', 'typescript', 'tsx', 'jsx',
                'json', 'yaml',
                'lua', 'rust', 'python', 'go',
            },
            callback = function()
                vim.bo.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
            end,
        })
    end,
}
