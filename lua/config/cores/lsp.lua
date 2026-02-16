-- LSP Configuration Module
local M = {}

-- Cache frequently used vim APIs for better performance
local keymap = vim.keymap
local diagnostic = vim.diagnostic
local lsp = vim.lsp
local api = vim.api

-- Configuration constants optimized for backend development
local UPDATETIME = 500  -- Faster response for backend debugging
local DIAGNOSTIC_SIGNS = {
  Error = "󰅚 ",
  Warn = "󰀪 ",
  Hint = "󰌶 ",
  Info = " "
}

-- Backend-specific LSP server configurations
local BACKEND_LSP_CONFIGS = {
  -- Go development
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          shadow = true,
          fieldalignment = true,
          nilness = true,
        },
        staticcheck = true,
        gofumpt = true,
        usePlaceholders = true,
        completeUnimported = true,
        experimentalPostfixCompletions = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  -- Python development
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          autoImportCompletions = true,
          diagnosticMode = "workspace",
        },
      },
    },
  },
  -- Node.js/TypeScript
  tsserver = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  -- Rust development
  rust_analyzer = {
    -- Intentionally minimal here: full config in lua/config/cores/lang/rust.lua
    settings = {},
  },
}

-- Backend-focused keymap definitions
local LSP_KEYMAPS = {
  -- Core navigation
  { "n", "gr", "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
  { "n", "gD", vim.lsp.buf.declaration, "Go to declaration" },
  { "n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions" },
  { "n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
  { "n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
  
  -- Code actions and refactoring (essential for backend)
  { { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions" },
  { "n", "<leader>rn", vim.lsp.buf.rename, "Smart rename" },
  { "n", "<leader>rf", "<cmd>Telescope lsp_references<CR>", "Find all references" },
  
  -- Diagnostics (critical for backend debugging)
  { "n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
  { "n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics" },
  { "n", "<leader>dw", "<cmd>Telescope diagnostics<CR>", "Show workspace diagnostics" },
  { "n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic" },
  { "n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic" },
  { "n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, "Go to previous error" },
  { "n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "Go to next error" },
  
  -- Documentation and help
  { "n", "K", vim.lsp.buf.hover, "Show documentation" },
  { "n", "<leader>K", vim.lsp.buf.signature_help, "Show signature help" },
  
  -- Workspace management (important for backend projects)
  { "n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
  { "n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
  { "n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List workspace folders" },
  
  -- LSP control
  { "n", "<leader>rs", ":LspRestart<CR>", "Restart LSP" },
  { "n", "<leader>li", ":LspInfo<CR>", "LSP Info" },
  { "n", "<leader>ll", ":LspLog<CR>", "LSP Log" },
  
  -- Inlay hints toggle (useful for complex backend code)
  { "n", "<leader>ih", function() 
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end
    end, "Toggle inlay hints" },
}

-- Enhanced diagnostic configuration for backend development
local function setup_diagnostics()
  -- Configure diagnostic display with backend-focused settings
  diagnostic.config({
    virtual_text = false,  -- Disable inline error messages
    signs = true,  -- Keep signs in the sign column
    underline = true,  -- Enable underline to show errors
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = true,  -- Allow focusing for backend error investigation
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      header = "",
      format = function(diagnostic)
        -- Enhanced formatting for backend diagnostics
        local code = diagnostic.code and string.format(" [%s]", diagnostic.code) or ""
        local source = diagnostic.source and string.format(" (%s)", diagnostic.source) or ""
        return string.format("%s%s%s", diagnostic.message, code, source)
      end,
    },
  })

  -- Setup diagnostic signs with backend-appropriate styling
  for type, icon in pairs(DIAGNOSTIC_SIGNS) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { 
      text = icon, 
      texthl = hl, 
      numhl = hl,
      linehl = "", -- Don't highlight entire line to avoid distraction
    })
  end

  -- Set up diagnostic severity levels for backend development
  vim.diagnostic.severity.HINT = 4
  vim.diagnostic.severity.INFO = 3
  vim.diagnostic.severity.WARN = 2
  vim.diagnostic.severity.ERROR = 1
end

-- Backend-optimized LSP settings
local function setup_global_settings()
  vim.o.updatetime = UPDATETIME
  
  -- Enhanced completion settings for backend development
  vim.o.completeopt = "menu,menuone,noselect,longest"
  
  -- Better folding for large backend files
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldenable = false  -- Start with folds open
  vim.o.foldlevel = 99
  
  -- Enhanced search for backend codebases
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.hlsearch = true
  vim.o.incsearch = true
  
  -- Better file handling for large backend projects
  vim.o.hidden = true
  vim.o.backup = false
  vim.o.writebackup = false
  vim.o.swapfile = false
  vim.o.undofile = true
  vim.o.undodir = vim.fn.expand("~/.config/nvim/undo")
  
  -- Performance optimizations for large files
  vim.o.synmaxcol = 300  -- Limit syntax highlighting for long lines
  -- vim.o.lazyredraw = true  -- Disabled: conflicts with noice.nvim
  
  -- Enable inlay hints globally (disabled by default for performance, toggle with <leader>ih)
  -- if lsp.inlay_hint and lsp.inlay_hint.enable then
  --   lsp.inlay_hint.enable(true)
  -- end
  
  -- Set up LSP handlers for better backend development experience
  lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
    border = "rounded",
    max_width = 80,
    max_height = 20,
  })
  
  lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
    border = "rounded",
    max_width = 80,
    max_height = 15,
  })
  
  -- Configure LSP logging for debugging
  if vim.env.NVIM_LSP_DEBUG then
    vim.lsp.set_log_level("debug")
  else
    vim.lsp.set_log_level("off")
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

-- Enhanced LspAttach autocmd optimized for backend development
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
      
      -- Enable inlay hints only when toggled (off by default for performance)
      -- if client.server_capabilities.inlayHintProvider and lsp.inlay_hint then
      --   lsp.inlay_hint.enable(true, { bufnr = bufnr })
      -- end
      
      -- Auto show diagnostics on cursor move
      local diag_float_group = api.nvim_create_augroup('DiagnosticFloat', { clear = false })
      api.nvim_create_autocmd({ 'CursorHold' }, {
        buffer = bufnr,
        group = diag_float_group,
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
          }
          vim.diagnostic.open_float(nil, opts)
        end
      })
      
      -- Enable document highlighting for backend code navigation
      if client.server_capabilities.documentHighlightProvider then
        local highlight_group = api.nvim_create_augroup('LspDocumentHighlight', { clear = false })
        api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = bufnr,
          group = highlight_group,
          callback = vim.lsp.buf.document_highlight,
        })
        api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = bufnr,
          group = highlight_group,
          callback = vim.lsp.buf.clear_references,
        })
      end
      
      -- Enhanced semantic tokens for backend languages
      if client.server_capabilities.semanticTokensProvider then
        client.server_capabilities.semanticTokensProvider.full = true
      end
      
      -- Backend-specific server configurations
      local server_name = client.name
      if BACKEND_LSP_CONFIGS[server_name] then
        -- Apply backend-specific settings if available
        if client.config and client.config.settings then
          vim.tbl_deep_extend("force", client.config.settings, BACKEND_LSP_CONFIGS[server_name].settings or {})
        end
      end
      
      -- Set up code lens for supported backends (refresh only on buffer enter/save)
      if client.server_capabilities.codeLensProvider then
        api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
          buffer = bufnr,
          callback = function()
            vim.lsp.codelens.refresh()
          end,
        })
        
        -- Add codelens keymap
        keymap.set('n', '<leader>cl', vim.lsp.codelens.run, { buffer = bufnr, desc = "Run code lens" })
      end
      
      -- Enhanced workspace symbol support for large backend projects
      if client.server_capabilities.workspaceSymbolProvider then
        keymap.set('n', '<leader>ws', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', 
                  { buffer = bufnr, desc = "Search workspace symbols" })
      end
      
      -- Language-specific optimizations
      local filetype = vim.bo[bufnr].filetype
      if filetype == "go" then
        -- Go-specific optimizations
        keymap.set('n', '<leader>gt', '<cmd>!go test .<CR>', { buffer = bufnr, desc = "Run Go tests" })
        keymap.set('n', '<leader>gb', '<cmd>!go build<CR>', { buffer = bufnr, desc = "Build Go project" })
      elseif filetype == "python" then
        -- Python-specific optimizations
        keymap.set('n', '<leader>pt', '<cmd>!python -m pytest<CR>', { buffer = bufnr, desc = "Run Python tests" })
      elseif filetype == "rust" then
        -- Rust-specific optimizations
        keymap.set('n', '<leader>rt', '<cmd>!cargo test<CR>', { buffer = bufnr, desc = "Run Cargo tests" })
        keymap.set('n', '<leader>rb', '<cmd>!cargo build<CR>', { buffer = bufnr, desc = "Cargo build" })
        keymap.set('n', '<leader>rr', '<cmd>!cargo run<CR>', { buffer = bufnr, desc = "Cargo run" })
      end
    end,
  })
end

-- Backend development utility functions
local function setup_backend_utilities()
  -- Create commands for common backend development tasks
  api.nvim_create_user_command('LspWorkspaceAdd', function()
    vim.lsp.buf.add_workspace_folder()
  end, { desc = 'Add folder to workspace' })

  api.nvim_create_user_command('LspWorkspaceList', function()
    vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = 'List workspace folders' })

  api.nvim_create_user_command('LspWorkspaceRemove', function()
    vim.lsp.buf.remove_workspace_folder()
  end, { desc = 'Remove folder from workspace' })

  -- Backend-specific diagnostic filtering
  api.nvim_create_user_command('LspDiagnosticsToggle', function()
    if vim.diagnostic.is_disabled() then
      vim.diagnostic.enable()
      vim.notify("Diagnostics enabled")
    else
      vim.diagnostic.disable()
      vim.notify("Diagnostics disabled")
    end
  end, { desc = 'Toggle LSP diagnostics' })

  -- Enhanced symbol search for large backend projects
  api.nvim_create_user_command('LspSymbolSearch', function(opts)
    require('telescope.builtin').lsp_workspace_symbols({
      query = opts.args,
      symbols = { "class", "function", "method", "interface", "struct", "enum" }
    })
  end, { nargs = '?', desc = 'Search backend symbols' })
end


-- Enhanced setup function with backend optimizations
function M.setup(opts)
  opts = opts or {}
  
  -- Apply user configuration overrides
  if opts.updatetime then
    UPDATETIME = opts.updatetime
  end
  
  if opts.backend_configs then
    vim.tbl_deep_extend("force", BACKEND_LSP_CONFIGS, opts.backend_configs)
  end
  
  setup_global_settings()
  setup_diagnostics()
  setup_global_keymaps()
  setup_lsp_attach()
  setup_backend_utilities()
  
  -- Set up backend-specific autocommands
  api.nvim_create_autocmd("FileType", {
    pattern = { "go", "python", "rust", "typescript", "javascript" },
    callback = function()
      -- Enable additional features for backend languages
      vim.opt_local.number = true
      vim.opt_local.relativenumber = true
      vim.opt_local.signcolumn = "yes:2"  -- More space for backend diagnostics
      vim.opt_local.colorcolumn = "80,120"  -- Backend code guidelines
      
      -- Language-specific settings
      local ft = vim.bo.filetype
      if ft == "go" then
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = false
      elseif ft == "python" then
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
      elseif ft == "rust" then
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
      end
    end,
  })
end

-- Initialize with backend-optimized defaults
M.setup({
  enable_performance_monitoring = false,  -- Can be enabled for debugging
})

return M
