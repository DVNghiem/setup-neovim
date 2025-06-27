return {
  -- Primary theme optimized for long coding sessions with smooth animations
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- storm, moon, night, day
        light_style = "day",
        transparent = true, -- Enhanced transparency for smoother feel
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "transparent", -- Transparent sidebars for seamless look
          floats = "transparent", -- Transparent floating windows
        },
        sidebars = { "qf", "help", "neo-tree" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false, -- Disabled for smoother visual experience
        lualine_bold = false,
        
        --- Enhanced colors for smooth UI experience
        on_colors = function(colors)
          -- Warmer, eye-friendly colors for long sessions
          colors.bg = "NONE" -- Full transparency
          colors.bg_dark = "NONE"
          colors.bg_float = "NONE"
          colors.bg_sidebar = "NONE"
          colors.comment = "#565f89"
          colors.border = "#565f89"
        end,
        
        on_highlights = function(highlights, colors)
          -- Smooth transparency and rounded borders throughout
          highlights.Normal = { bg = colors.none }
          highlights.NormalFloat = { bg = colors.none }
          highlights.FloatBorder = { bg = colors.none, fg = "#7aa2f7" } -- Soft blue borders
          highlights.NeoTreeNormal = { bg = colors.none }
          highlights.NeoTreeNormalNC = { bg = colors.none }
          
          -- Enhanced visual elements with smooth, rounded appearance
          highlights.CursorLine = { bg = "#2a2b3a" } -- Softer highlight
          highlights.ColorColumn = { bg = "#2a2b3a" }
          highlights.Visual = { bg = "#364A82" }
          highlights.Search = { bg = "#ff9e3b", fg = colors.bg }
          highlights.IncSearch = { bg = "#f7768e", fg = colors.bg }
          
          -- Smooth completion menu with rounded feel
          highlights.Pmenu = { bg = "#1e2030", fg = colors.fg, blend = 15 }
          highlights.PmenuSel = { bg = "#364A82", fg = colors.fg, bold = true }
          highlights.PmenuSbar = { bg = "#1e2030" }
          highlights.PmenuThumb = { bg = "#7aa2f7" } -- Smooth scrollbar
          highlights.PmenuBorder = { bg = colors.none, fg = "#7aa2f7" }
          
          -- Enhanced window separators with softer appearance
          highlights.WinSeparator = { fg = "#3b4261", bg = colors.none }
          highlights.VertSplit = { fg = "#3b4261", bg = colors.none }
          highlights.StatusLine = { bg = colors.none, fg = colors.fg }
          highlights.StatusLineNC = { bg = colors.none, fg = colors.comment }
          
          -- Smooth tab line integration with fluid borders
          highlights.TabLine = { bg = colors.none, fg = colors.comment }
          highlights.TabLineFill = { bg = colors.none }
          highlights.TabLineSel = { bg = "#364A82", fg = colors.fg, bold = true }
          
          -- Enhanced title bar highlights with smooth styling
          highlights.WinBar = { bg = colors.none, fg = colors.fg, bold = true }
          highlights.WinBarNC = { bg = colors.none, fg = colors.comment }
          
          -- Smooth diagnostic highlights
          highlights.DiagnosticError = { fg = "#f7768e" }
          highlights.DiagnosticWarn = { fg = "#e0af68" }
          highlights.DiagnosticInfo = { fg = "#7aa2f7" }
          highlights.DiagnosticHint = { fg = "#1abc9c" }
          
          -- Rounded floating window styles
          highlights.NormalFloat = { bg = "#1e2030", fg = colors.fg }
          highlights.FloatTitle = { bg = "#7aa2f7", fg = "#1a1b26", bold = true }
          
          -- Smooth selection and cursor styling
          highlights.Cursor = { bg = "#c0caf5", fg = "#1a1b26" }
          highlights.lCursor = { bg = "#c0caf5", fg = "#1a1b26" }
          highlights.CursorIM = { bg = "#c0caf5", fg = "#1a1b26" }
        end,
      })
      
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  
  -- Alternative themes for variety
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = true,
        telescope = true,
        harpoon = true,
        mason = true,
        noice = true,
        which_key = true,
      },
    },
  },
  
  -- Keep your original theme as backup
  {
    "DVNghiem/dracula-vim",
    lazy = true,
    config = function()
      vim.cmd([[colorscheme dracula_pro]])
      vim.o.background = "dark"
      vim.o.termguicolors = true
    end,
  },
  
  -- High contrast theme for tired eyes
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    config = function()
      require('vscode').setup({
        transparent = false,
        italic_comments = true,
        disable_nvimtree_bg = true,
        color_overrides = {
          vscLineNumber = '#5A5A5A',
        },
        group_overrides = {
          Cursor = { fg='#515052', bg='#AEAFAD', bold=true },
        }
      })
    end,
  },
}
