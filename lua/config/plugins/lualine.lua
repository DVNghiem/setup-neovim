return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup {
      options = {
        theme = "catppuccin",
        component_separators = "",
        section_separators = { left = "", right = "" },
        globalstatus = true,
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