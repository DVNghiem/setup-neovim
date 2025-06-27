return {
  -- Enhanced which-key for better discoverability
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        operators = { gc = "Comments" },
        key_labels = {
          ["<space>"] = "SPC",
          ["<cr>"] = "RET",
          ["<tab>"] = "TAB",
        },
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
        },
        popup_mappings = {
          scroll_down = "<c-d>",
          scroll_up = "<c-u>",
        },
        window = {
          border = "rounded",
          position = "bottom",
          margin = { 1, 0, 1, 0 },
          padding = { 2, 2, 2, 2 },
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
        ignore_missing = true,
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
        show_help = true,
        show_keys = true,
        triggers = "auto",
        triggers_blacklist = {
          i = { "j", "k" },
          v = { "j", "k" },
        },
        triggers_nowait = {
          "`",
          "'",
          "g`",
          "g'",
          '"',
          "<c-r>",
          "z=",
        },
        disable = {
          buftypes = {},
          filetypes = { "TelescopePrompt" },
        },
      })
      
      -- Register group names for better organization
      wk.register({
        ["<leader>"] = {
          b = { name = "Buffers" },
          c = { name = "Code" },
          d = { name = "Debug" },
          f = { name = "File/Find" },
          g = { name = "Git" },
          h = { name = "Help/Harpoon" },
          l = { name = "LSP" },
          n = { name = "Neotree/Notes" },
          p = { name = "Project" },
          q = { name = "Quit/Quickfix" },
          r = { name = "Replace/Refactor" },
          s = { name = "Search/Session" },
          t = { name = "Terminal/Toggle" },
          u = { name = "UI/Undo" },
          v = { name = "Vim" },
          w = { name = "Window/Workspace" },
          x = { name = "Diagnostics/Trouble" },
          z = { name = "Zen/Focus" },
        },
      })
    end,
  },
  
  -- Better navigation with leap
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = { "tpope/vim-repeat" },
    config = function()
      require('leap').create_default_mappings()
      -- Set leap highlight groups
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
      vim.api.nvim_set_hl(0, 'LeapMatch', {
        fg = 'white',
        bold = true,
        nocombine = true,
      })
      
      -- Make leap labels more visible
      require('leap').opts.highlight_unlabeled_phase_one_targets = true
    end,
  },
  
  -- Enhanced marks for quick navigation
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
      require'marks'.setup {
        default_mappings = true,
        builtin_marks = { ".", "<", ">", "^" },
        cyclic = true,
        force_write_shada = false,
        refresh_interval = 250,
        sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
        excluded_filetypes = {},
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world",
          annotate = false,
        },
        mappings = {}
      }
    end,
  },
  
  -- Better window management
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    event = "VeryLazy",
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup({
        autowidth = {
          enable = true,
          winwidth = 5,
          filetype = {
            help = 2,
          },
        },
        ignore = {
          buftype = { "quickfix" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo" }
        },
        animation = {
          enable = true,
          duration = 300,
          fps = 30,
          easing = "in_out_sine"
        }
      })
    end,
    keys = {
      { "<C-w>z", "<cmd>WindowsMaximize<cr>", desc = "Maximize window" },
      { "<C-w>=", "<cmd>WindowsEqualize<cr>", desc = "Equalize windows" },
    },
  },
  
  -- Better quickfix and location list navigation
  {
    "yorickpeterse/nvim-pqf",
    event = "VeryLazy",
    config = function()
      require('pqf').setup({
        signs = {
          error = "E",
          warning = "W",
          info = "I",
          hint = "H"
        },
        show_multiple_lines = false,
        max_filename_length = 0,
      })
    end,
  },
  
  -- Smart column marker for code style
  {
    "Bekaboo/deadcolumn.nvim",
    event = "VeryLazy",
    config = function()
      require('deadcolumn').setup({
        scope = 'line',
        modes = function(mode)
          return mode:find('^[ictRss\x13]') ~= nil
        end,
        blending = {
          threshold = 0.75,
          colorcode = '#000000',
          hlgroup = { 'Normal', 'bg' },
        },
        warning = {
          alpha = 0.4,
          offset = 0,
          colorcode = '#FF0000',
          hlgroup = { 'Error', 'bg' },
        },
        extra = {
          follow_tw = nil,
        },
      })
    end,
  },
  
  -- Better split/join for long lines
  {
    "Wansmer/treesj",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = "VeryLazy",
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
        check_syntax_error = true,
        max_join_length = 120,
        cursor_behavior = 'hold',
        notify = true,
        dot_repeat = true,
        on_error = nil,
      })
    end,
    keys = {
      { "<leader>m", "<cmd>TSJToggle<cr>", desc = "Toggle Treesitter Join" },
    },
  },
  
  -- Enhanced surrounds
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
        aliases = {
          ["a"] = ">",
          ["b"] = ")",
          ["B"] = "}",
          ["r"] = "]",
          ["q"] = { '"', "'", "`" },
          ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
        },
        highlight = {
          duration = 500,
        },
        move_cursor = "begin",
        indent_lines = function(start, stop)
          local b = vim.bo
          return b.equalprg ~= "" or b.indentexpr ~= "" or b.cindent or b.smartindent or b.autoindent
        end,
      })
    end,
  },
}
