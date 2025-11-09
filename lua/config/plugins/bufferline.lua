-- Modern bufferline with slant separators and catppuccin integration
return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim",
  },
  version = "*",
  event = "VeryLazy",
  keys = {
    { "<leader>bP", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bU", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "gb", "<CMD>BufferLinePick<CR>", desc = "Pick buffer" },
    { "<leader>ts", "<CMD>BufferLinePickClose<CR>", desc = "Pick close buffer" },
    { "]B", "<CMD>BufferLineMoveNext<CR>", desc = "Move buffer next" },
    { "[B", "<CMD>BufferLineMovePrev<CR>", desc = "Move buffer prev" },
    { "<leader>bs", "<CMD>BufferLineSortByDirectory<CR>", desc = "Sort buffers by directory" },
  },
  opts = {
    options = {
      mode = "buffers",
      themable = true,
      numbers = "none",
      close_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      right_mouse_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      left_mouse_command = "buffer %d",
      middle_mouse_command = nil,
      indicator = {
        icon = "▎",
        style = "icon",
      },
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 25,
      max_prefix_length = 25,
      truncate_names = true,
      tab_size = 20,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      show_tab_indicators = true,
      show_duplicate_prefix = true,
      persist_buffer_sort = true,
      separator_style = "slant",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      hover = {
        enabled = true,
        delay = 150,
        reveal = { "close" },
      },
      sort_by = "insert_after_current",
      offsets = {
        {
          filetype = "neo-tree",
          text = "  File Explorer",
          text_align = "left",
          separator = true,
        },
      },
      custom_filter = function(buf_number)
        if vim.bo[buf_number].filetype ~= "oil" and vim.fn.bufname(buf_number) ~= "" then
          return true
        end
        return false
      end,
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd("BufAdd", {
      callback = function()
        vim.schedule(function()
          pcall(vim.cmd, "BufferLineSortByDirectory")
        end)
      end,
    })
  end,
}
