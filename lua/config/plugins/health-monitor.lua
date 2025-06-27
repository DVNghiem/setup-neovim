return {
  -- Eye strain reduction and break reminders
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
      },
    },
  },
  
  -- Dim inactive portions of code
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    opts = {
      dimming = {
        alpha = 0.25,
        color = { "Normal", "#ffffff" },
        term_bg = "#000000",
        inactive = false,
      },
      context = 10,
      treesitter = true,
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {},
    },
  },
  
  -- Smooth scrolling for eye comfort
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require('neoscroll').setup({
        mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                    '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = "quadratic",
        pre_hook = nil,
        post_hook = nil,
        performance_mode = false,
      })
    end,
  },
  
  -- Eye strain reduction with auto dark/light mode
  {
    "f-person/auto-dark-mode.nvim",
    event = "VeryLazy",
    config = function()
      require('auto-dark-mode').setup({
        update_interval = 1000,
        set_dark_mode = function()
          vim.api.nvim_set_option("background", "dark")
          vim.cmd("colorscheme tokyonight-night")
        end,
        set_light_mode = function()
          vim.api.nvim_set_option("background", "light")
          vim.cmd("colorscheme tokyonight-day")
        end,
      })
    end,
  },
  
  -- Break reminder and productivity tracker - DISABLED to prevent j/k lag
  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   event = "VeryLazy",
  --   opts = {
  --     enabled = false,  -- Disabled - was causing j/k key lag warnings
  --   },
  -- },
      --   max_time = 1000,
      --   max_count = 3,
      --   disable_mouse = false,
      --   hint = true,
      --   notification = true,
      --   allow_different_key = false,
      --   resetting_keys = {
      --     ["1"] = { "n", "x" },
      --     ["2"] = { "n", "x" },
      --     ["3"] = { "n", "x" },
      --     ["4"] = { "n", "x" },
      --     ["5"] = { "n", "x" },
      --     ["6"] = { "n", "x" },
      --     ["7"] = { "n", "x" },
      --     ["8"] = { "n", "x" },
      --     ["9"] = { "n", "x" },
      --     ["c"] = { "n" },
      --     ["C"] = { "n" },
      --     ["d"] = { "n" },
      --     ["x"] = { "n" },
      --     ["X"] = { "n" },
      --     ["y"] = { "n" },
      --     ["Y"] = { "n" },
      --     ["p"] = { "n" },
      --     ["P"] = { "n" },
      --   },
      --   restricted_keys = {
      --     ["h"] = { "n", "x" },
      --     ["j"] = { "n", "x" },
      --     ["k"] = { "n", "x" },
      --     ["l"] = { "n", "x" },
      --     ["-"] = { "n", "x" },
      --     ["+"] = { "n", "x" },
      --     ["gj"] = { "n", "x" },
      --     ["gk"] = { "n", "x" },
      --     ["<CR>"] = { "n", "x" },
      --     ["<C-M>"] = { "n", "x" },
      --     ["<C-N>"] = { "n", "x" },
      --     ["<C-P>"] = { "n", "x" },
      --   },
      --   disabled_keys = {
      --     ["<Up>"] = { "n", "x" },
      --     ["<Down>"] = { "n", "x" },
      --     ["<Left>"] = {},  -- Allow for our smart navigation
      --     ["<Right>"] = { "n", "x" },
      --   },
      -- },
  
  -- Distraction-free writing
  {
    "junegunn/goyo.vim",
    cmd = "Goyo",
    config = function()
      vim.g.goyo_width = 120
      vim.g.goyo_height = "85%"
      vim.g.goyo_linenr = 1
    end,
  },
}
