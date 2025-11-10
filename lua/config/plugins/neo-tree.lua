return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree reveal toggle left<CR>", desc = "Toggle NeoTree" },
    { "<leader>E", "<cmd>Neotree focus left<CR>", desc = "Focus NeoTree" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      config = function()
        require("window-picker").setup({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            bo = {
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              buftype = { "terminal", "quickfix" },
            },
          },
        })
      end,
    },
  },

  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,

  config = function()
    require("neo-tree").setup({
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf", "edgy" },

      default_component_configs = {
        container = { enable_character_fade = true },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = true,
          expander_collapsed = "▸",
          expander_expanded = "▾",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "󰉋",
          folder_open = "󰝰",
          folder_empty = "󰉋",
          folder_empty_open = "󰝰",
          default = "󰈙",
        },
        modified = { symbol = "●" },
        name = { trailing_slash = true, use_git_status_colors = true },
        git_status = {
          symbols = {
            added = "",
            deleted = "",
            modified = "",
            renamed = "󰁕",
            untracked = "",
            ignored = "◌",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },

      window = {
        position = "left",
        width = 36,
        mapping_options = { noremap = true, nowait = true },
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["o"] = "open",
          ["<CR>"] = "open",
          ["<esc>"] = "cancel",
          ["t"] = "open_tabnew",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
          ["a"] = { "add", config = { show_path = "relative" } },
          ["A"] = "add_directory",
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy",
          ["m"] = "move",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["H"] = "toggle_hidden",
          ["."] = "set_root",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          ["i"] = "show_file_details",
        },
      },

      nesting_rules = {
        ["py"] = { "__init__.py" },
        ["js"] = { ".js", ".jsx", ".ts", ".tsx" },
      },

      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_hidden = true,
          hide_by_name = { "node_modules", ".git", "__pycache__", "venv", ".venv" },
          never_show = { ".DS_Store", "thumbs.db" },
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = false,
        window = {
          mappings = {
            ["/"] = "noop", 
            ["f"] = "fuzzy_finder",
            ["F"] = "clear_filter",
          },
        },
      },

      buffers = {
        follow_current_file = { enabled = true, leave_dirs_open = false},
        group_empty_dirs = true,
        show_unloaded = true,
        window = { mappings = { ["bd"] = "buffer_delete" } },
      },

      git_status = {
        window = { position = "float" },
      },
	  follow_current_file = {
		enabled = true,
		leave_dirs_open = false, 
		},

    })

    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#282A36" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#282A36" })
    vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = "#6272A4", bg = "#282A36" })
    vim.api.nvim_set_hl(0, "NeoTreeFloatTitle", { fg = "#F8F8F2", bg = "#6272A4" })
    vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#44475A" })
    vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#50FA7B" })
    vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#FFB86C" })
    vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#FF5555" })
  end,
}