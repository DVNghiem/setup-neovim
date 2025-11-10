return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  keys = {
    { "<leader>nd", "<cmd>Noice dismiss<CR>", desc = "Dismiss All Notifications" },
    { "<leader>nl", "<cmd>Noice last<CR>", desc = "Noice Last Message" },
    { "<leader>nh", "<cmd>Noice history<CR>", desc = "Noice History" },
  },
  config = function()
    require("noice").setup({
      views = {
        cmdline_popup = {
          border = { style = "rounded" },
          win_options = { winblend = 0 },
        },
        popupmenu = {
          border = { style = "rounded" },
          win_options = { winblend = 0 },
        },
        mini = {
          win_options = { winblend = 0 },
        },
      },

      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        format = {
          cmdline = { icon = " " },
          search_down = { icon = " down " },
          search_up = { icon = " up " },
          filter = { icon = " $ " },
          lua = { icon = " " },
          help = { icon = " " },
        },
      },

      messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },

      popupmenu = {
        enabled = true,
        backend = "nui",
      },

      notify = {
        enabled = true,
        view = "notify",
      },

      lsp = {
        progress = {
          enabled = true,
          view = "mini",
        },
        hover = { enabled = true },
        signature = { enabled = true },
        message = { enabled = true, view = "notify" },
        documentation = {
          view = "hover",
          opts = {
            border = { style = "rounded" },
            win_options = { winblend = 0 },
          },
        },
      },

      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },

      routes = {
        {
          filter = { event = "msg_show", find = "written" },
          view = "mini",
        },
        {
          filter = { event = "msg_show", find = "yanked" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", find = "more lines" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", find = "fewer lines" },
          opts = { skip = true },
        },
      },
    })

    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#6272A4" })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = "#F8F8F2", bg = "#6272A4" })
    vim.api.nvim_set_hl(0, "NoiceMini", { fg = "#F8F8F2", bg = "#282A36" })
    vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = "#8BE9FD" })
    vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = "#FFB86C" })
    vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = "#FF5555" })

    require("notify").setup({
      background_colour = "#282A36",
      fps = 60,
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 2000,
      top_down = false,
    })
  end,
}