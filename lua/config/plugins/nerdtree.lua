local keymap = vim.keymap
return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {},

    lazy = false,
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.opt.termguicolors = true
        require("nvim-tree").setup({
            auto_reload_on_write = false,
            disable_netrw = true,
            hijack_cursor = false,
            hijack_netrw = false,
            hijack_unnamed_buffer_when_opening = false,
            sort_by = "name",
            root_dirs = {},
            prefer_startup_root = false,
            sync_root_with_cwd = true,
            reload_on_bufenter = false,
            respect_buf_cwd = false,
            on_attach = "default",
            select_prompts = false,
            view = {
                adaptive_size = false,
                centralize_selection = true,
                width = 30,
                side = "left",
                preserve_window_proportions = false,
                number = false,
                relativenumber = false,
                signcolumn = "yes",
                float = {
                    enable = false,
                    quit_on_focus_loss = true,
                    open_win_config = {
                        relative = "editor",
                        border = "rounded",
                        width = 30,
                        height = 30,
                        row = 1,
                        col = 1,
                    },
                },
            },
            renderer = {
                add_trailing = false,
                group_empty = false,
                highlight_git = true,
                full_name = false,
                highlight_opened_files = "none",
                root_folder_label = ":t",
                indent_width = 4,
                indent_markers = {
                    enable = false,
                    inline_arrows = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        none = " ",
                    },
                },
                
                special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
                symlink_destination = true,
            },
            -- hijack_directories = {
            --     enable = false,
            --     auto_open = true,
            -- },
            update_focused_file = {
                enable = true,
                debounce_delay = 15,
                update_root = true,
                ignore_list = {},
            },
            diagnostics = {
                enable = true,
                show_on_dirs = false,
                show_on_open_dirs = true,
                debounce_delay = 50,
                severity = {
                    min = vim.diagnostic.severity.HINT,
                    max = vim.diagnostic.severity.ERROR,
                },
            },
            filters = {
                dotfiles = false,
                git_clean = false,
                no_buffer = false,
                custom = { "node_modules", "\\.cache", ".git", "venv"},
                exclude = {},
            },
            filesystem_watchers = {
                enable = true,
                debounce_delay = 50,
                ignore_dirs = {},
            },
            git = {
                enable = true,
                ignore = false,
                show_on_dirs = true,
                show_on_open_dirs = true,
                timeout = 200,
            },
            actions = {
                use_system_clipboard = true,
                change_dir = {
                    enable = true,
                    global = false,
                    restrict_above_cwd = false,
                },
                expand_all = {
                    max_folder_discovery = 300,
                    exclude = {},
                },
                file_popup = {
                    open_win_config = {
                        col = 1,
                        row = 1,
                        relative = "cursor",
                        border = "shadow",
                        style = "minimal",
                    },
                },
               
                remove_file = {
                    close_window = true,
                },
            },
            trash = {
                cmd = "trash",
                require_confirm = true,
            },
            live_filter = {
                prefix = "[FILTER]: ",
                always_show_folders = true,
            },
            tab = {
                sync = {
                    open = false,
                    close = false,
                    ignore = {},
                },
            },
            notify = {
                threshold = vim.log.levels.INFO,
            },
            log = {
                enable = false,
                truncate = false,
                types = {
                    all = false,
                    config = false,
                    copy_paste = false,
                    dev = false,
                    diagnostics = false,
                    git = false,
                    profile = false,
                    watcher = false,
                },
            },
            system_open = {
                cmd = nil,
                args = {},
            },

        })
        local opts = { silent = true, nowait = true }
        keymap.set("n", "<leader>e", ":NERDTreeToggle<CR>", opts)
    end,
}
