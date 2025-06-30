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
            { "j-hui/fidget.nvim", opts = {} },
            { "ray-x/lsp_signature.nvim", event = "VeryLazy" },
            { "folke/trouble.nvim", cmd = "Trouble" },
            { "simrat39/symbols-outline.nvim", cmd = "SymbolsOutline" },
        },
        event = "VeryLazy",
        config = function()
            -- Enhanced LSP Configuration
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            
            -- Enhanced capabilities for better IDE experience
            capabilities.textDocument.completion.completionItem = {
                documentationFormat = { "markdown", "plaintext" },
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                resolveSupport = {
                    properties = {
                        "documentation",
                        "detail",
                        "additionalTextEdits",
                    },
                },
            }

            -- LSP Saga configuration
            local status, saga = pcall(require, "lspsaga")
            if status then
                saga.setup({
                    ui = {
                        winblend = 10,
                        border = 'rounded',
                        colors = {
                            normal_bg = '#002b36'
                        }
                    },
                    code_action = {
                        num_shortcut = true,
                        show_server_name = false,
                        extend_gitsigns = true,
                        keys = {
                            quit = "q",
                            exec = "<CR>",
                        },
                    },
                    lightbulb = {
                        enable = true,
                        enable_in_insert = true,
                        sign = true,
                        sign_priority = 40,
                        virtual_text = false,
                    },
                    rename = {
                        quit = "<C-c>",
                        exec = "<CR>",
                        mark = "t",
                        confirm = "<CR>",
                        in_select = true,
                    },
                    symbol_in_winbar = {
                        enable = true,
                        separator = "  ",
                        ignore_patterns = {},
                        hide_keyword = true,
                        show_file = true,
                        folder_level = 2,
                        respect_root = false,
                        color_mode = true,
                    },
                })
            end

            -- LSP Signature configuration
            local signature_status, signature = pcall(require, "lsp_signature")
            if signature_status then
                signature.setup({
                    bind = true,
                    handler_opts = {
                        border = "rounded"
                    },
                    floating_window = true,
                    floating_window_above_cur_line = true,
                    fix_pos = false,
                    hint_enable = true,
                    hint_prefix = "🐼 ",
                    hint_scheme = "String",
                    hi_parameter = "LspSignatureActiveParameter",
                    max_height = 12,
                    max_width = 80,
                    transparency = nil,
                    shadow_blend = 36,
                    shadow_guibg = 'Black',
                    timer_interval = 200,
                    toggle_key = nil,
                })
            end

            -- Symbols Outline configuration
            local outline_status, outline = pcall(require, "symbols-outline")
            if outline_status then
                outline.setup({
                    highlight_hovered_item = true,
                    show_guides = true,
                    auto_preview = false,
                    position = 'right',
                    relative_width = true,
                    width = 25,
                    auto_close = false,
                    show_numbers = false,
                    show_relative_numbers = false,
                    show_symbol_details = true,
                    preview_bg_highlight = 'Pmenu',
                    autofold_depth = nil,
                    auto_unfold_hover = true,
                    fold_markers = { '', '' },
                    wrap = false,
                    keymaps = {
                        close = {"<Esc>", "q"},
                        goto_location = "<Cr>",
                        focus_location = "o",
                        hover_symbol = "<C-space>",
                        toggle_preview = "K",
                        rename_symbol = "r",
                        code_actions = "a",
                        fold = "h",
                        unfold = "l",
                        fold_all = "W",
                        unfold_all = "E",
                        fold_reset = "R",
                    },
                    lsp_blacklist = {},
                    symbol_blacklist = {},
                    symbols = {
                        File = { icon = "", hl = "@text.uri" },
                        Module = { icon = "", hl = "@namespace" },
                        Namespace = { icon = "", hl = "@namespace" },
                        Package = { icon = "", hl = "@namespace" },
                        Class = { icon = "𝓒", hl = "@type" },
                        Method = { icon = "ƒ", hl = "@method" },
                        Property = { icon = "", hl = "@method" },
                        Field = { icon = "", hl = "@field" },
                        Constructor = { icon = "", hl = "@constructor" },
                        Enum = { icon = "ℰ", hl = "@type" },
                        Interface = { icon = "ﰮ", hl = "@type" },
                        Function = { icon = "", hl = "@function" },
                        Variable = { icon = "", hl = "@constant" },
                        Constant = { icon = "", hl = "@constant" },
                        String = { icon = "𝓐", hl = "@string" },
                        Number = { icon = "#", hl = "@number" },
                        Boolean = { icon = "⊨", hl = "@boolean" },
                        Array = { icon = "", hl = "@constant" },
                        Object = { icon = "⦿", hl = "@type" },
                        Key = { icon = "🔐", hl = "@type" },
                        Null = { icon = "NULL", hl = "@type" },
                        EnumMember = { icon = "", hl = "@field" },
                        Struct = { icon = "𝓢", hl = "@type" },
                        Event = { icon = "🗲", hl = "@type" },
                        Operator = { icon = "+", hl = "@operator" },
                        TypeParameter = { icon = "𝙏", hl = "@parameter" },
                        Component = { icon = "", hl = "@function" },
                        Fragment = { icon = "", hl = "@constant" },
                    },
                })
            end

            -- Trouble configuration
            local trouble_status, trouble = pcall(require, "trouble")
            if trouble_status then
                trouble.setup({
                    position = "bottom",
                    height = 10,
                    width = 50,
                    icons = true,
                    mode = "workspace_diagnostics",
                    severity = nil,
                    fold_open = "",
                    fold_closed = "",
                    group = true,
                    padding = true,
                    cycle_results = true,
                    action_keys = {
                        close = "q",
                        cancel = "<esc>",
                        refresh = "r",
                        jump = {"<cr>", "<tab>", "<2-leftmouse>"},
                        open_split = { "<c-x>" },
                        open_vsplit = { "<c-v>" },
                        open_tab = { "<c-t>" },
                        jump_close = {"o"},
                        toggle_mode = "m",
                        switch_severity = "s",
                        toggle_preview = "P",
                        hover = "K",
                        preview = "p",
                        open_code_href = "c",
                        close_folds = {"zM", "zm"},
                        open_folds = {"zR", "zr"},
                        toggle_fold = {"zA", "za"},
                        previous = "k",
                        next = "j"
                    },
                    multiline = true,
                    indent_lines = true,
                    win_config = { border = "single" },
                    auto_open = false,
                    auto_close = false,
                    auto_preview = true,
                    auto_fold = false,
                    auto_jump = {"lsp_definitions"},
                    include_declaration = {
                        "lsp_references",
                        "lsp_implementations",
                        "lsp_definitions",
                    },
                    signs = {
                        error = "",
                        warning = "",
                        hint = "",
                        information = "",
                        other = "",
                    },
                    use_diagnostic_signs = false
                })
            end

            -- Enhanced keymaps for LSP
            local function on_attach(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                
                -- Enhanced navigation
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
                
                -- Enhanced hover and help
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                
                -- Workspace management
                vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                
                -- Code actions and refactoring
                vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
                
                -- Formatting
                vim.keymap.set("n", "<leader>cf", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
                
                -- Diagnostics
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)
                
                -- Trouble integration
                vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", opts)
                vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts)
                vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", opts)
                vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", opts)
                vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", opts)
                vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", opts)
                
                -- Symbols Outline
                vim.keymap.set("n", "<leader>so", "<cmd>SymbolsOutline<cr>", opts)
                
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
                
                -- LSP signature on insert mode
                if signature_status then
                    signature.on_attach({
                        bind = true,
                        handler_opts = {
                            border = "rounded"
                        }
                    }, bufnr)
                end
            end

            -- Configure language servers with enhanced capabilities
            local servers = {
                "lua_ls",
                "pyright",
                "ts_ls",
                "rust_analyzer", 
                "gopls",
                "clangd",
                "jdtls",
                "html",
                "cssls",
                "tailwindcss",
                "jsonls",
                "yamlls",
                "bashls",
                "dockerls",
                "marksman",
            }

            for _, server in ipairs(servers) do
                lspconfig[server].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end

            -- Enhanced diagnostic configuration
            vim.diagnostic.config({
                virtual_text = {
                    enabled = true,
                    source = "if_many",
                    prefix = "●",
                },
                float = {
                    source = "always",
                    border = "rounded",
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            -- Enhanced diagnostic signs
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

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
            -- Enhanced Mason setup with comprehensive tool installation
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
                    border = "rounded",
                    width = 0.8,
                    height = 0.9,
                },
                max_concurrent_installers = 10,
            })
            
            -- Enhanced mason-lspconfig setup with automatic installation
            local lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
            if lspconfig_ok then
                pcall(function()
                    mason_lspconfig.setup({
                        ensure_installed = {
                            "lua_ls",
                            "pyright",
                            "ts_ls", 
                            "rust_analyzer",
                            "gopls",
                            "clangd",
                            "html",
                            "cssls",
                            "tailwindcss",
                            "jsonls",
                            "yamlls",
                            "bashls",
                            "dockerls",
                            "marksman",
                        },
                        automatic_installation = true,
                        handlers = nil, -- Disable automatic handlers to prevent conflicts
                    })
                end)
            end

            -- Enhanced mason-tool-installer for additional tools
            local tool_installer_ok, tool_installer = pcall(require, "mason-tool-installer")
            if tool_installer_ok then
                tool_installer.setup({
                    ensure_installed = {
                        -- Formatters
                        "prettier",
                        "black",
                        "isort",
                        "stylua",
                        "shfmt",
                        
                        -- Linters
                        "eslint_d",
                        "flake8",
                        "pylint",
                        "shellcheck",
                        "hadolint",
                        
                        -- DAP (Debug Adapter Protocol)
                        "debugpy",
                        "node-debug2-adapter",
                        "chrome-debug-adapter",
                        "codelldb",
                        
                        -- Additional tools
                        "json-lsp",
                        "yaml-language-server",
                        "dockerfile-language-server",
                        "bash-language-server",
                    },
                    auto_update = true,
                    run_on_start = true,
                    start_delay = 3000,
                    debounce_hours = 5,
                })
            end
        end,
    }
}
