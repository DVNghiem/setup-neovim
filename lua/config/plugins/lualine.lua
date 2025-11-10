-- ~/.config/nvim/lua/plugins/lualine.lua
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

      -- TABLINE SIÊU ĐẸP + NÚT × + BO TRÒN
      tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "buffers",
            show_filename_only = true,
            hide_filename_extension = false,
            show_modified_status = true,

            -- NÚT × ĐỎ ĐẸP NHƯ VSCode
            symbols = {
              modified = " ●",
              alternate_file = "",
              directory = "",
            },

            -- BO TRÒN + MÀU DRACULA CHUẨN
            buffers_color = {
              active = { fg = "#F8F8F2", bg = "#44475A", gui = "bold" },
              inactive = { fg = "#6272A4", bg = "#282A36" },
            },

            -- NÚT × CLICK LÀ TẮT BUFFER
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
        lualine_b = { "branch" },
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