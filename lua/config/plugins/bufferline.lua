-- Enhanced bufferline with smooth animations and transparency
return {
  "akinsho/bufferline.nvim",
  dependencies = { 
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim", -- Ensure theme loads first
  },
  version = "*",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
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
      mode = "buffers", -- Better for multiple files
      themable = true,
      numbers = "none",
      close_command = function(n) require("mini.bufremove").delete(n, false) end,
      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      left_mouse_command = "buffer %d",
      middle_mouse_command = nil,
      indicator = {
        icon = "▎",
        style = "underline", -- More elegant than icon
      },
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 30,
      max_prefix_length = 30,
      truncate_names = true,
      tab_size = 21,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      show_duplicate_prefix = true,
      persist_buffer_sort = true,
      separator_style = "slope", -- Smooth sloped edges instead of rigid
      enforce_regular_tabs = true, -- More uniform appearance
      always_show_bufferline = true, -- Always show for consistency
      hover = {
        enabled = true,
        delay = 200,
        reveal = {'close'}
      },
      sort_by = 'insert_after_current',
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          text_align = "left",
          separator = true,
        },
      },
      custom_filter = function(buf_number, buf_numbers)
        -- filter out filetypes you don't want to see
        if vim.bo[buf_number].filetype ~= "oil" then
          return true
        end
        -- filter out by buffer name
        if vim.fn.bufname(buf_number) ~= "" then
          return true
        end
        -- filter out based on arbitrary rules
        -- e.g. filter out vim wiki buffer from tabline in your work repo
        if vim.fn.getcwd() == "/home/myusername/work" then
          return false
        end
        return true
      end,
    },
    -- highlights will be handled by the theme automatically
  },
  config = function(_, opts)
    -- Enhanced highlights for fluid, smooth appearance
    local highlights = {
      -- Active tab styling with smooth curves
      buffer_selected = {
        fg = "#c3ccdc",
        bg = "#364A82", -- Smoother blue background
        bold = true,
        italic = false,
      },
      -- Inactive tab styling with softer edges
      buffer_visible = {
        fg = "#7aa2f7",
        bg = "#2a2b3a", -- Softer background
      },
      buffer = {
        fg = "#565f89", 
        bg = "#1e2030", -- Smoother dark background
      },
      -- Smooth curved separators
      separator_selected = {
        fg = "#364A82",
        bg = "#364A82",
      },
      separator_visible = {
        fg = "#2a2b3a",
        bg = "#2a2b3a", 
      },
      separator = {
        fg = "#1e2030",
        bg = "#1e2030",
      },
      -- Smooth tab close styling
      close_button = {
        fg = "#7aa2f7",
        bg = "#1e2030",
      },
      close_button_visible = {
        fg = "#7aa2f7", 
        bg = "#2a2b3a",
      },
      close_button_selected = {
        fg = "#c3ccdc",
        bg = "#364A82",
      },
      -- Smooth modified indicator
      modified = {
        fg = "#e0af68", -- Warmer orange
        bg = "#1e2030",
      },
      modified_visible = {
        fg = "#e0af68",
        bg = "#2a2b3a", 
      },
      modified_selected = {
        fg = "#e0af68",
        bg = "#364A82",
      },
      -- Smooth duplicate name styling
      duplicate_selected = {
        fg = "#c3ccdc",
        bg = "#364A82",
        italic = true,
      },
      duplicate_visible = {
        fg = "#7aa2f7",
        bg = "#2a2b3a",
        italic = true,
      },
      duplicate = {
        fg = "#565f89",
        bg = "#1e2030", 
        italic = true,
      },
      -- Smooth indicator styling
      indicator_selected = {
        fg = "#7aa2f7",
        bg = "#364A82",
      },
      -- Smooth pick styling
      pick_selected = {
        fg = "#f7768e",
        bg = "#364A82",
        bold = true,
      },
      pick_visible = {
        fg = "#f7768e",
        bg = "#2a2b3a",
        bold = true,
      },
      pick = {
        fg = "#f7768e",
        bg = "#1e2030",
        bold = true,
      },
    }
    
    -- Try to get catppuccin highlights if available, otherwise use custom
    local ok, catppuccin = pcall(require, "catppuccin.groups.integrations.bufferline")
    if ok then
      opts.highlights = catppuccin.get()
    else
      opts.highlights = highlights
    end
    
    require("bufferline").setup(opts)
    
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd("BufAdd", {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
