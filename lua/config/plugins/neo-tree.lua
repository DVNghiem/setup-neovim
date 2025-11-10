return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
            require("window-picker").setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    bo = {
                        filetype = {"neo-tree", "neo-tree-popup", "notify"},
                        buftype = {"terminal", "quickfix"}
                    }
                }
            })
        end
    }},
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    init = function()
        if vim.fn.argc(-1) == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                require("neo-tree")
            end
        end
    end,
    config = function()
        local icons = require("config.cores.icon")
        require("neo-tree").setup({
            close_if_last_window = false,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            enable_normal_mode_for_inputs = false,
            open_files_do_not_replace_types = {"terminal", "trouble", "qf"},
            sort_case_insensitive = false,
            sort_function = nil,
            default_component_configs = {
                container = {
                    enable_character_fade = true
                },
                indent = {
                    indent_size = 2,
                    padding = 1,
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NeoTreeIndentMarker",
                    with_expanders = true,
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander"
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "󰜌",
                    default = "*",
                    highlight = "NeoTreeFileIcon"
                },
                modified = {
                    symbol = "●",
                    highlight = "NeoTreeModified"
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = "NeoTreeFileName"
                },
                git_status = {
                    symbols = {
                        added = icons.git.added,
                        modified = icons.git.modified,
                        deleted = icons.git.removed,
                        renamed = icons.git.renamed,
                        untracked = icons.git.untracked,
                        ignored = icons.git.ignored,
                        unstaged = icons.git.unstaged,
                        staged = icons.git.staged,
                        conflict = icons.git.conflict
                    }
                },
                file_size = {
                    enabled = true,
                    required_width = 64
                },
                type = {
                    enabled = true,
                    required_width = 122
                },
                last_modified = {
                    enabled = true,
                    required_width = 88
                },
                created = {
                    enabled = true,
                    required_width = 110
                },
                symlink_target = {
                    enabled = false
                }
            },
            window = {
                position = "left",
                width = 35,
                mapping_options = {
                    noremap = true,
                    nowait = true
                }
            },
            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = true
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false
                },
                group_empty_dirs = false,
                hijack_netrw_behavior = "open_default",
                use_libuv_file_watcher = false,
                window = {
                    mappings = {
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["H"] = "toggle_hidden",
                        ["/"] = "fuzzy_finder",
                        ["D"] = "fuzzy_finder_directory",
                        ["#"] = "fuzzy_sorter",
                        ["f"] = "filter_on_submit",
                        ["<c-x>"] = "clear_filter",
                        ["[g"] = "prev_git_modified",
                        ["]g"] = "next_git_modified"
                    }
                }
            },
            buffers = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false
                },
                group_empty_dirs = true,
                show_unloaded = true
            },
            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["A"] = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["ga"] = "git_add_file",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gg"] = "git_commit_and_push"
                    }
                }
            }
        })
    end
}
