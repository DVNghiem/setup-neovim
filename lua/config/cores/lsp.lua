-- LSP Configuration Module
-- Optimized for performance and maintainability

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
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "cargo-clippy",
        },
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
        inlayHints = {
          bindingModeHints = {
            enable = false,
          },
          chainingHints = {
            enable = true,
          },
          closingBraceHints = {
            enable = true,
            minLines = 25,
          },
          closureReturnTypeHints = {
            enable = "never",
          },
          lifetimeElisionHints = {
            enable = "never",
            useParameterNames = false,
          },
          maxLength = 25,
          parameterHints = {
            enable = true,
          },
          reborrowHints = {
            enable = "never",
          },
          renderColons = true,
          typeHints = {
            enable = true,
            hideClosureInitialization = false,
            hideNamedConstructor = false,
          },
        },
      },
    },
  },
  -- Java development
  jdtls = {
    settings = {
      java = {
        eclipse = {
          downloadSources = true,
        },
        configuration = {
          updateBuildConfiguration = "interactive",
        },
        maven = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        format = {
          enabled = true,
        },
        signatureHelp = { enabled = true },
        completion = {
          favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
          },
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          },
        },
      },
    },
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
  
  -- Formatting - NOTE: Removed LSP formatting keymaps, use conform.nvim instead (<leader>fm)
  -- { "n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format buffer" },
  -- { "v", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format selection" },
  
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
    virtual_text = {
      source = "always",  -- Always show source for backend debugging
      spacing = 4,
      prefix = "●",
      severity_sort = true,
      format = function(diagnostic)
        -- Show error codes for backend debugging
        if diagnostic.code then
          return string.format("%s [%s]", diagnostic.message, diagnostic.code)
        end
        return diagnostic.message
      end,
    },
    signs = false,  -- Disabled to remove sign column highlights
    underline = false,  -- Disabled to remove underline highlights
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
  
  -- Enable inlay hints globally with backend focus
  if lsp.inlay_hint and lsp.inlay_hint.enable then
    lsp.inlay_hint.enable(true)
  end
  
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
  vim.lsp.set_log_level("off")  -- Reduce noise in production
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
      
      -- Backend-specific client optimizations
      -- NOTE: Auto-format on save is DISABLED here - using stevearc/conform.nvim instead
      -- if client.server_capabilities.documentFormattingProvider then
      --   -- Smart format on save for backend files
      --   api.nvim_create_autocmd("BufWritePre", {
      --     buffer = bufnr,
      --     group = api.nvim_create_augroup('LspFormatting', { clear = false }),
      --     callback = function()
      --       -- Only format if the file type is supported and file is not too large
      --       local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
      --       if file_size < 1024 * 1024 then  -- Less than 1MB
      --         vim.lsp.buf.format({ 
      --           bufnr = bufnr,
      --           timeout_ms = 2000,  -- Reasonable timeout for backend files
      --           async = false,
      --         })
      --       end
      --     end,
      --   })
      -- end
      
      -- Enable inlay hints for supported backends
      if client.server_capabilities.inlayHintProvider and lsp.inlay_hint then
        lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
      
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
      
      -- Set up code lens for supported backends (useful for Spring Boot, etc.)
      if client.server_capabilities.codeLensProvider then
        api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
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
      elseif filetype == "java" then
        -- Java-specific optimizations
        keymap.set('n', '<leader>jt', '<cmd>!mvn test<CR>', { buffer = bufnr, desc = "Run Maven tests" })
        keymap.set('n', '<leader>jb', '<cmd>!mvn compile<CR>', { buffer = bufnr, desc = "Maven compile" })
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

-- Performance monitoring for backend development
local function setup_performance_monitoring()
  -- Track LSP performance for large backend codebases
  local function log_lsp_performance(method, start_time)
    local end_time = vim.loop.hrtime()
    local duration = (end_time - start_time) / 1000000  -- Convert to milliseconds
    if duration > 1000 then  -- Log if operation takes more than 1 second
      vim.notify(string.format("LSP %s took %.2fms", method, duration), vim.log.levels.WARN)
    end
  end

  -- Monitor slow LSP operations
  local original_request = lsp.buf_request
  lsp.buf_request = function(bufnr, method, params, handler)
    local start_time = vim.loop.hrtime()
    local new_handler = handler
    if handler then
      new_handler = function(...)
        log_lsp_performance(method, start_time)
        return handler(...)
      end
    end
    return original_request(bufnr, method, params, new_handler)
  end
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
  
  if opts.enable_performance_monitoring then
    setup_performance_monitoring()
  end
  
  -- Set up backend-specific autocommands
  api.nvim_create_autocmd("FileType", {
    pattern = { "go", "python", "java", "rust", "typescript", "javascript" },
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
      elseif ft == "java" then
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
