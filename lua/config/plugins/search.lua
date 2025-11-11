return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = { mode = "fuzzy", multi_window = false },
      jump = { autojump = true },
      highlight = { backdrop = false },
      modes = {
        char = { enabled = true, jump_labels = true },
        search = { enabled = true },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },

  -- SPECTRE – REPLACE 
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = {
      open_cmd = "noswapfile vnew",
      live_update = true,
      highlight = { ui = "String", search = "DiffDelete", replace = "DiffAdd" },
    },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in Project (Spectre)" },
      { "<leader>sf", function() require("spectre").open_file_search() end, desc = "Replace in Current File" },
      { "<leader>sw", function() require("spectre").open_visual({select_word=true}) end, desc = "Replace Current Word" },
    },
  },

  -- TELESCOPE 
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-media-files.nvim",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help" },
      { "<leader>fm", "<cmd>Telescope media_files<CR>", desc = "Media Files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent Files" },
      { "<leader>fc", "<cmd>Telescope colorscheme<CR>", desc = "Colorscheme" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      { "<leader>f/", "<cmd>Telescope search_history<CR>", desc = "Search History" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local themes = require("telescope.themes")

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          entry_prefix = "   ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_ignore_patterns = { "node_modules", ".git/", "venv", "__pycache__" },
          path_display = { "filename_first" },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
            n = {
              ["q"] = actions.close,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
            },
          },
        },
        extensions = {
          fzf = { fuzzy = true, case_mode = "smart_case" },
          media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "webm", "pdf", "epub" },
            find_cmd = "rg",
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("media_files")
    end,
  },

  -- DRESSING – INPUT + SELECT 
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      vim.ui.select = function(...) require("lazy").load({ plugins = { "dressing.nvim" } }) vim.ui.select(...) end
      vim.ui.input = function(...) require("lazy").load({ plugins = { "dressing.nvim" } }) vim.ui.input(...) end
    end,
    opts = {
      input = { enabled = true, win_options = { winblend = 0 } },
      select = { enabled = true, backend = { "telescope", "nui", "builtin" } },
    },
  },

  -- WHICH-KEY
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay = 0,
      spec = {
        { "<leader>f", group = "file/find" },
        { "<leader>ff", desc = "Find Files" },
        { "<leader>fg", desc = "Live Grep" },
        { "<leader>fb", desc = "Buffers" },
        { "<leader>fr", desc = "Recent Files" },
        { "<leader>fm", desc = "Media Files" },
        { "<leader>sr", desc = "Replace in Project" },
        { "<leader>sw", desc = "Replace Word" },
      },
    },
  },
}