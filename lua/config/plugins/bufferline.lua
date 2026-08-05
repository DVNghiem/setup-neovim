-- ponytail: minimal viable cokeline — expand sidebar only when needed
-- get_hex uses vim.api instead of cokeline.hlgroups (avoids parse-time require before plugin loads)
local function get_hex(group, attr)
  local hl = vim.api.nvim_get_hl_by_name(group, true)
  if not hl then return nil end
  local val = attr == "fg" and hl.foreground or hl.background
  if not val then return nil end
  return string.format("#%06x", val)
end

return {
  {
    "willothy/nvim-cokeline",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Plug>(cokeline-focus-next)", desc = "Next buffer" },
      { "<S-Tab>", "<Plug>(cokeline-focus-prev)", desc = "Prev buffer" },
      { "<leader>bp", "<Plug>(cokeline-pick-focus)", desc = "Pick buffer" },
      { "<leader>bc", "<Plug>(cokeline-pick-close)", desc = "Close buffer" },
      { "<leader>b1", "<Plug>(cokeline-focus-1)" },
      { "<leader>b2", "<Plug>(cokeline-focus-2)" },
      { "<leader>b3", "<Plug>(cokeline-focus-3)" },
      { "<leader>b4", "<Plug>(cokeline-focus-4)" },
      { "<leader>b5", "<Plug>(cokeline-focus-5)" },
    },
    opts = {
      show_if_buffers_are_at_least = 1,
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
        end,
        bg = get_hex("ColorColumn", "bg"),
      },
      rendering = {
        max_buffer_width = 30,
      },
      components = {
        {
          text = function(buffer) return (buffer.index ~= 1) and "▏" or "" end,
          fg = function() return get_hex("Normal", "fg") end,
        },
        {
          text = function(buffer) return buffer.index .. "." end,
          fg = function() return get_hex("Comment", "fg") end,
        },
        {
          text = function(buffer)
            if buffer.devicon then
              return buffer.devicon.icon
            end
            return ""
          end,
          fg = function(buffer)
            if buffer.devicon then
              return buffer.devicon.color
            end
            return ""
          end,
        },
        {
          text = function(buffer)
            local name = buffer.filename or ""
            return name
          end,
        },
        {
          text = function(buffer)
            return buffer.is_modified and " ●" or ""
          end,
          fg = function()
            return get_hex("DiagnosticOk", "fg") or get_hex("Normal", "fg")
          end,
          bold = true,
        },
        {
          text = " x",
          hl = {
            fg = function() return get_hex("Comment", "fg") end,
          },
          on_click = function(_, _, _, _, buffer)
            buffer:delete()
          end,
        },
        {
          text = " ",
        },
      },
      sidebar = {
        filetype = { "NvimTree", "neo-tree", "SidebarNvim" },
        components = {
          {
            text = function(buf) return buf.filetype end,
            fg = function() return get_hex("Normal", "fg") end,
            bg = function() return get_hex("Normal", "bg") end,
            bold = true,
          },
        },
      },
      mappings = {
        cycle_prev_next = false,
      },
    },
  },
}
