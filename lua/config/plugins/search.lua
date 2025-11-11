return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = {
          "filename_first",  
          shorten = { len = 3, exclude = {1, -1} },
        },

        get_selection_window = function()
          return 0
        end,

        prompt_prefix = " ",
        selection_caret = "➤ ",
        entry_prefix = "  ",

        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.6,
            results_width = 0.4,
          },
          width = 0.75,
          height = 0.85,
        },

        sorting_strategy = "ascending",

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<CR>"] = actions.select_default,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          },
          n = {
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["q"] = actions.close,
          },
        },

        file_ignore_patterns = {
          "node_modules/",
          ".git/",
          "%.pyc$",
          "__pycache__/",
        },
      },

      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
          path_display = { "filename_first" },
        },
      },
    })

    telescope.load_extension("fzf")
  end,
}