return {
  -- Modern catppuccin theme - beautiful, developer-friendly color palette
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha (mocha is the darkest)
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = { "bold" },
          keywords = { "italic" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = { "bold", "italic" },
          properties = {},
          types = { "bold" },
          operators = {},
        },
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
          },
        },
        custom_highlights = function(colors)
          return {
            -- Better transparency and modern look
            Normal = { bg = colors.none },
            NormalFloat = { bg = colors.none, fg = colors.text },
            FloatBorder = { bg = colors.none, fg = colors.blue },
            FloatTitle = { bg = colors.none, fg = colors.sapphire, style = { "bold" } },
            
            -- Neo-tree modern styling
            NeoTreeNormal = { bg = colors.none },
            NeoTreeNormalNC = { bg = colors.none },
            NeoTreeEndOfBuffer = { bg = colors.none },
            NeoTreeVertSplit = { bg = colors.none, fg = colors.none },
            NeoTreeWinSeparator = { bg = colors.none, fg = colors.surface0 },
            NeoTreeRootName = { fg = colors.blue, style = { "bold", "italic" } },
            NeoTreeGitModified = { fg = colors.yellow },
            NeoTreeGitAdded = { fg = colors.green },
            NeoTreeGitDeleted = { fg = colors.red },
            
            -- Better cursor line
            CursorLine = { bg = colors.surface0 },
            CursorLineNr = { fg = colors.lavender, style = { "bold" } },
            
            -- Telescope modern UI
            TelescopeBorder = { bg = colors.none, fg = colors.blue },
            TelescopePromptBorder = { bg = colors.none, fg = colors.blue },
            TelescopeResultsBorder = { bg = colors.none, fg = colors.blue },
            TelescopePreviewBorder = { bg = colors.none, fg = colors.blue },
            TelescopePromptTitle = { bg = colors.none, fg = colors.sapphire, style = { "bold" } },
            TelescopeResultsTitle = { bg = colors.none, fg = colors.sapphire, style = { "bold" } },
            TelescopePreviewTitle = { bg = colors.none, fg = colors.sapphire, style = { "bold" } },
            
            -- Better LSP highlights
            DiagnosticVirtualTextError = { bg = colors.none, fg = colors.red },
            DiagnosticVirtualTextWarn = { bg = colors.none, fg = colors.yellow },
            DiagnosticVirtualTextInfo = { bg = colors.none, fg = colors.sky },
            
            -- Smooth completion menu
            Pmenu = { bg = colors.surface0, fg = colors.text },
            PmenuSel = { bg = colors.blue, fg = colors.base, style = { "bold" } },
            PmenuSbar = { bg = colors.surface0 },
            PmenuThumb = { bg = colors.overlay0 },
            
            -- Smooth window separators
            WinSeparator = { fg = colors.surface0, bg = colors.none },
            VertSplit = { fg = colors.surface0, bg = colors.none },
            
            -- Status and tab lines
            StatusLine = { bg = colors.none, fg = colors.text },
            StatusLineNC = { bg = colors.none, fg = colors.overlay0 },
            TabLine = { bg = colors.none, fg = colors.overlay0 },
            TabLineFill = { bg = colors.none },
            TabLineSel = { bg = colors.surface0, fg = colors.text, style = { "bold" } },
            
            -- Enhanced winbar
            WinBar = { bg = colors.none, fg = colors.text, style = { "bold" } },
            WinBarNC = { bg = colors.none, fg = colors.overlay0 },
            
            -- Better visual and search
            Visual = { bg = colors.surface1, style = { "bold" } },
            Search = { bg = colors.yellow, fg = colors.base, style = { "bold" } },
            IncSearch = { bg = colors.red, fg = colors.base, style = { "bold" } },
            
            -- Git signs
            GitSignsAdd = { fg = colors.green },
            GitSignsChange = { fg = colors.yellow },
            GitSignsDelete = { fg = colors.red },
          }
        end,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = false,
          neotree = true,
          treesitter = true,
          notify = true,
          mini = {
            enabled = true,
            indentscope_color = "lavender",
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          telescope = {
            enabled = true,
            style = "nvchad",
          },
          harpoon = true,
          mason = true,
          noice = true,
          which_key = true,
          barbecue = {
            dim_dirname = true,
            bold_basename = true,
            dim_context = false,
            alt_background = false,
          },
          indent_blankline = {
            enabled = true,
            scope_color = "lavender",
            colored_indent_levels = true,
          },
          dashboard = true,
          lsp_trouble = true,
        },
      })
      
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
