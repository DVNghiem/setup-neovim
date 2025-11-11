return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup {
      options = {
        theme = "dracula",
        component_separators = "",
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },

      tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "buffers",
            show_filename_only = true,
            hide_filename_extension = false,
            show_modified_status = true,

            symbols = {
              modified = " ●",
              alternate_file = "",
              directory = "",
            },

            buffers_color = {
              active = { fg = "#F8F8F2", bg = "#44475A", gui = "bold" },
              inactive = { fg = "#6272A4", bg = "#282A36" },
            },

            fmt = function(name, context)
              local close_btn = context.bufnr and "  " .. "" or ""
              return " " .. name .. close_btn
            end,
          }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "tabs" },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = { modified = "●", readonly = "", newfile = "[New]" }
          }
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },

      extensions = { "neo-tree", "lazy", "trouble", "mason" },
    }

  end,
}