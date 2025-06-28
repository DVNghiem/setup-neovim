-- LSP Configuration Module
-- Optimized for performance and maintainability

local M = {}

-- Cache frequently used vim APIs for better performance
local keymap = vim.keymap
local diagnostic = vim.diagnostic
local lsp = vim.lsp
local api = vim.api

-- Configuration constants
local UPDATETIME = 1000
local DIAGNOSTIC_SIGNS = {
  Error = "󰅚 ",
  Warn = "󰀪 ",
  Hint = "󰌶 ",
  Info = " "
}

-- Keymap definitions for better organization
local LSP_KEYMAPS = {
  { "n", "gr", "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
  { "n", "gD", vim.lsp.buf.declaration, "Go to declaration" },
  { "n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions" },
  { "n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
  { "n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
  { { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions" },
  { "n", "<leader>rn", vim.lsp.buf.rename, "Smart rename" },
  { "n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
  { "n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics" },
  { "n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic" },
  { "n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic" },
  { "n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor" },
  { "n", "<leader>rs", ":LspRestart<CR>", "Restart LSP" },
}

-- Global diagnostic configuration
local function setup_diagnostics()
  -- Configure diagnostic display with improved settings
  diagnostic.config({
    virtual_text = {
      source = "if_many",
      spacing = 4,
      prefix = "●",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
    },
  })

  -- Setup diagnostic signs
  for type, icon in pairs(DIAGNOSTIC_SIGNS) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

-- Global LSP settings
local function setup_global_settings()
  vim.o.updatetime = UPDATETIME
  
  -- Enable inlay hints globally (with version check)
  if lsp.inlay_hint and lsp.inlay_hint.enable then
    lsp.inlay_hint.enable(true)
  end
end

-- Global diagnostic keymaps (available everywhere)
local function setup_global_keymaps()
  local opts = { noremap = true, silent = true }
  
  keymap.set('n', '<space>d', diagnostic.open_float, opts)
  keymap.set('n', '[d', diagnostic.goto_prev, opts)
  keymap.set('n', ']d', diagnostic.goto_next, opts)
end

-- Optimized keymap setup function
local function setup_buffer_keymaps(bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  
  -- Set up all LSP keymaps efficiently
  for _, keymap_config in ipairs(LSP_KEYMAPS) do
    local modes, key, command, desc = keymap_config[1], keymap_config[2], keymap_config[3], keymap_config[4]
    opts.desc = desc
    keymap.set(modes, key, command, opts)
  end
end

-- Enhanced LspAttach autocmd with better error handling
local function setup_lsp_attach()
  api.nvim_create_autocmd('LspAttach', {
    group = api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(ev)
      local bufnr = ev.buf
      local client = lsp.get_client_by_id(ev.data.client_id)
      
      if not client then
        return
      end
      
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
      
      -- Setup buffer-local keymaps
      setup_buffer_keymaps(bufnr)
      
      -- Client-specific optimizations
      if client.server_capabilities.documentFormattingProvider then
        -- Add format on save if supported
        api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
      
      -- Enable inlay hints for this buffer if supported
      if client.server_capabilities.inlayHintProvider and lsp.inlay_hint then
        lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end,
  })
end

-- Main setup function
function M.setup()
  setup_global_settings()
  setup_diagnostics()
  setup_global_keymaps()
  setup_lsp_attach()
end

-- Initialize if called directly
M.setup()

return M
