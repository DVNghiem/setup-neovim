return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = true,
      },
      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = true,
          luasnip = true,
          throttle = 50,
        },
      },
      progress = {
        enabled = true,
        format = "lsp_progress",
        format_done = "lsp_progress_done",
        throttle = 1000 / 30,
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
    messages = {
      enabled = true,
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
      view_history = "messages",
      view_search = "virtualtext",
    },
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
      format = {
        cmdline = { pattern = "^:", icon = " ", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = " ", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖 " },
        input = {},
      },
    },
    popupmenu = {
      enabled = true,
      backend = "nui",
      kind_icons = {},
    },
    notify = {
      enabled = true,
      view = "notify",
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          find = "%d+L, %d+B",
        },
        opts = { skip = true },
      },
    },
    views = {
      cmdline_popup = {
        position = {
          row = "50%",
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = {
            Normal = "NormalFloat",
            FloatBorder = "FloatBorder",
          },
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = "50%",
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = {
            Normal = "NormalFloat",
            FloatBorder = "FloatBorder",
          },
        },
      },
    },
  },
  config = function(_, opts)
    require("noice").setup(opts)

    -- Better keymaps
    vim.keymap.set("n", "<leader>nl", function()
      require("noice").cmd("last")
    end, { desc = "Noice Last Message" })

    vim.keymap.set("n", "<leader>nh", function()
      require("noice").cmd("history")
    end, { desc = "Noice History" })

    vim.keymap.set("n", "<leader>na", function()
      require("noice").cmd("all")
    end, { desc = "Noice All" })

    vim.keymap.set("n", "<leader>nd", function()
      require("noice").cmd("dismiss")
    end, { desc = "Dismiss All Notifications" })

    vim.keymap.set("c", "<S-Enter>", function()
      require("noice").redirect(vim.fn.getcmdline())
    end, { desc = "Redirect Cmdline" })
  end,
}
