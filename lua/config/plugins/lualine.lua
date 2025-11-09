return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    -- Modern bubble theme with rounded separators
    local function get_lualine_theme()
      local colors = {
        blue = "#89b4fa",
        cyan = "#89dceb",
        black = "#000000",
        white = "#cdd6f4",
        red = "#f38ba8",
        violet = "#cba6f7",
        green = "#a6e3a1",
        yellow = "#f9e2af",
        pink = "#f5c2e7",
        grey = "#313244",
        darkgrey = "#181825",
      }

      return {
        normal = {
          a = { bg = colors.blue, fg = colors.black, gui = "bold" },
          b = { bg = colors.grey, fg = colors.white },
          c = { bg = "NONE", fg = colors.white },
        },
        insert = {
          a = { bg = colors.green, fg = colors.black, gui = "bold" },
          b = { bg = colors.grey, fg = colors.white },
          c = { bg = "NONE", fg = colors.white },
        },
        visual = {
          a = { bg = colors.violet, fg = colors.black, gui = "bold" },
          b = { bg = colors.grey, fg = colors.white },
          c = { bg = "NONE", fg = colors.white },
        },
        replace = {
          a = { bg = colors.red, fg = colors.black, gui = "bold" },
          b = { bg = colors.grey, fg = colors.white },
          c = { bg = "NONE", fg = colors.white },
        },
        command = {
          a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
          b = { bg = colors.grey, fg = colors.white },
          c = { bg = "NONE", fg = colors.white },
        },
        inactive = {
          a = { bg = "NONE", fg = colors.grey, gui = "bold" },
          b = { bg = "NONE", fg = colors.grey },
          c = { bg = "NONE", fg = colors.grey },
        },
      }
    end

    lualine.setup({
      options = {
        theme = get_lualine_theme(),
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
          },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
          },
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            shorting_target = 40,
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = " [No Name]",
              newfile = " ",
            },
          },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#f9e2af" },
          },
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
          { "filetype", icon_only = false, padding = { left = 1, right = 1 } },
        },
        lualine_y = {
          {
            "progress",
            padding = { left = 1, right = 1 },
          },
        },
        lualine_z = {
          {
            "location",
            padding = { left = 1, right = 1 },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
