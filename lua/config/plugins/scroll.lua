return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  keys = {
    "<C-u>", "<C-d>", "<C-b>", "<C-f>",
    "<C-y>", "<C-e>",
    "zt", "zz", "zb",
  },
  config = function()
    local neoscroll = require("neoscroll")
    local cfg = require("neoscroll.config")

    -- Easing function (sine + quadratic)
    local ease = function(t)
      return t < 0.5 and 2 * t * t or -1 + (4 - 2 * t) * t
    end

    -- KEYMAP
    local map = {
      ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 160, easing = ease }) end,
      ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 160, easing = ease }) end,
      ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 300, easing = ease }) end,
      ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 300, easing = ease }) end,
      ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor = false, duration = 50 }) end,
      ["<C-e>"] = function() neoscroll.scroll( 0.1, { move_cursor = false, duration = 50 }) end,
      ["zt"]    = function() neoscroll.zt({ half_win_duration = 150 }) end,
      ["zz"]    = function() neoscroll.zz({ half_win_duration = 150 }) end,
      ["zb"]    = function() neoscroll.zb({ half_win_duration = 150 }) end,
    }

    for key, func in pairs(map) do
      vim.keymap.set({"n", "v"}, key, func, { silent = true })
    end

    neoscroll.setup({
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = true,
      cursor_scrolls_alone = false,
      easing = ease,
      pre_hook = function()
        vim.cmd("silent! nohlsearch")
      end,
      post_hook = nil,
      performance_mode = false,
      ignored_events = {
        "WinScrolled", "CursorMoved", "CursorMovedI",
      },
    })
  end,
}