return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, 
  lazy = false,  
  
  config = function()
    require("catppuccin").setup({
      -- flavor: latte, frappe, macchiato, mocha
      flavour = "mocha", 
      
      transparent_background = false,
      
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
      
      color_overrides = {},
      custom_highlights = {},
      
      integrations = {
        -- Core integrations
        cmp = true,                    -- nvim-cmp
        gitsigns = true,               -- gitsigns
        nvimtree = true,               -- nvim-tree
        treesitter = true,             -- treesitter
        notify = true,                 -- notify
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        
        -- Telescope - fuzzy finder
        telescope = {
          enabled = true,
          style = "nvchad",            -- nvchad style đẹp hơn
        },
        
        -- Lualine - statusline
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
        
        -- Dashboard/Alpha
        dashboard = true,
        
        -- Indent guides
        indent_blankline = {
          enabled = true,
          scope_color = "lavender",   
          colored_indent_levels = true,
        },
        
        -- Markdown
        markdown = true,
        
        -- Neogit
        neogit = true,
        
        -- Semantic highlighting
        semantic_tokens = true,
        
        -- Hop (navigation)
        hop = true,

        bufferline = true,
        
        -- Which-key
        which_key = true,
        
        -- Barbecue (breadcrumbs)
        barbecue = {
          dim_dirname = true,
          bold_basename = true,
          dim_context = false,
          alt_background = false,
        },
        
        -- Flash (jump)
        flash = true,
        
        -- Noice
        noice = true,
        
        -- Mason
        mason = true,
        
        -- Aerial
        aerial = true,
        
        -- DAP UI
        dap = true,
        dap_ui = true,
        
        -- Navic
        navic = {
          enabled = true,
          custom_bg = "NONE",
        },
        
        -- Overseer
        overseer = true,
      },
    })
    
    vim.cmd.colorscheme("catppuccin")
    
    local colors = require("catppuccin.palettes").get_palette("mocha")
    
    vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.surface0 })
    
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.blue, bg = colors.none })
    
    vim.api.nvim_set_hl(0, "MatchParen", { 
      fg = colors.peach, 
      bg = colors.surface1,
      bold = true 
    })
  end,
}
