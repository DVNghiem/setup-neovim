-- Simplified LSP core configuration
-- Main LSP setup is in config/plugins/lsp.lua
-- This file only contains essential shared settings

local M = {}

-- Cache frequently used vim APIs for better performance
local diagnostic = vim.diagnostic

-- Configuration constants
local DIAGNOSTIC_SIGNS = {
  Error = "󰅚 ",
  Warn = "󰀪 ",
  Hint = "󰌶 ",
  Info = " "
}

-- Enhanced diagnostic configuration
local function setup_diagnostics()
  diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = true,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      header = "",
      format = function(diagnostic)
        local code = diagnostic.code and string.format(" [%s]", diagnostic.code) or ""
        local source = diagnostic.source and string.format(" (%s)", diagnostic.source) or ""
        return string.format("%s%s%s", diagnostic.message, code, source)
      end,
    },
  })

  -- Setup diagnostic signs
  for type, icon in pairs(DIAGNOSTIC_SIGNS) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { 
      text = icon, 
      texthl = hl, 
      numhl = hl,
      linehl = "",
    })
  end
end

-- Initialize diagnostics
setup_diagnostics()

return M
