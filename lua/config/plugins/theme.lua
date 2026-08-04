return {
  "folke/tokyonight.nvim",
  priority = 1000,
  lazy = false,

  config = function()
    require("tokyonight").setup({
      style = "night",
      transparent = false,
      terminal_colors = true,

      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        booleans = { bold = true, italic = true },
        types = { bold = true },
      },

      on_colors = function(colors) end,
      on_highlights = function(highlights, colors)
        -- Bold, high-contrast keywords for easy detection
        highlights.Keyword = { fg = colors.magenta, bold = true }
        highlights.Conditional = { fg = colors.magenta, bold = true }
        highlights.Loop = { fg = colors.magenta, bold = true }
        highlights.Operator = { fg = colors.pink, bold = true }

        -- Bold functions and types for clarity
        highlights.Function = { fg = colors.blue, bold = true }
        highlights.Type = { fg = colors.teal, bold = true }
        highlights.TypeDef = { fg = colors.teal, bold = true }

        -- High-contrast strings and numbers
        highlights.String = { fg = colors.green }
        highlights.Number = { fg = colors.peach }

        -- Bold comments for quick identification
        highlights.Comment = { fg = colors.comments, italic = true }
        highlights.Todo = { fg = colors.yellow, bold = true }

        -- Eye comfort: softer but visible background highlights
        highlights.LineNr = { fg = colors.dark3 }
        highlights.CursorLineNr = { fg = colors.fg, bold = true }
      end,

      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = { enabled = true },
        telescope = { enabled = true, style = "nvchad" },
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
        },
        dashboard = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        markdown = true,
        neogit = true,
        semantic_tokens = true,
        hop = true,
        bufferline = true,
        which_key = true,
        barbecue = {
          dim_dirname = true,
          bold_basename = true,
          dim_context = false,
          alt_background = false,
        },
        flash = true,
        noice = true,
        mason = true,
        aerial = true,
        dap = true,
        dap_ui = true,
        navic = { enabled = true, custom_bg = "NONE" },
        overseer = true,
      },
    })

    vim.cmd.colorscheme("tokyonight")

    -- Custom highlights for Tokyo Night Moon palette
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#292e42" })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7aa2f7", bg = "NONE" })
    vim.api.nvim_set_hl(0, "MatchParen", {
      fg = "#ff9e64",
      bg = "#3b4261",
      bold = true,
    })
  end,
}
