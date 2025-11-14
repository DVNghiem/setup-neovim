return {
  -- MASON + TOOLS
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        },
        border = "rounded",
      }
    },
  },

  -- MASON + LSP BRIDGE
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls", "pyright", "rust_analyzer", "gopls", "jdtls",
        "ts_ls", "html", "cssls", "tailwindcss", "emmet_ls",
      },
      automatic_installation = true,
    },
  },

  -- MASON + FORMATTER/LINTER
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = {
        "black", "isort", "pylint",
        "prettier", "stylua", "eslint_d",
        "ruff", "mypy", "flake8",
      },
      auto_update = true,
      run_on_start = true,
    },
  },

  -- FIDGET – LSP STATUS UI
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          winblend = 0,
          border = "rounded",
        },
      },
    },
  },

  -- LSP SAGA – LSP UI + ACTIONS
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    opts = {
      lightbulb = { enable = true, sign = true, virtual_text = false },
      symbol_in_winbar = { enable = false },
      code_action = {
        num_shortcut = true,
        show_server_name = true,
        extend_gitsigns = true,
        keys = { quit = "q", exec = "<CR>" },
      },
      rename = { quit = "<C-c>", exec = "<CR>", in_select = true },
      ui = {
        border = "rounded",
        devicon = true,
        title = true,
        expand = "⊞",
        collapse = "⊟",
        code_action = "💡",
        colors = {
          normal_bg = "#1e1e2e",
        },
      },
    },
    keys = {
      { "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "Goto Definition" },
      { "gr", "<cmd>Lspsaga finder<CR>", desc = "References + Definition" },
      { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Doc" },
      { "<leader>ca", "<cmd>Lspsaga code_action<CR>", mode = { "n", "v" }, desc = "Code Action" },
      { "<leader>rn", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
      { "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
      { "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Prev Diagnostic" },
      { "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
    },
  },

  -- GOTO PREVIEW – PREVIEW DEFINITIONS IN FLOATING WINDOWS
  {
    "rmagatti/goto-preview",
    dependencies = { "nvim-telescope/telescope.nvim" }, -- optional nhưng nên có
    event = "LspAttach",
    keys = {
      { "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Preview definition" },
      { "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = "Preview implementation" },
      { "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", desc = "Preview references" },
      { "gP",  "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "Close all previews" },
    },
    config = function()
      local goto_preview = require("goto-preview")

      goto_preview.setup({
        width = 100,                
        height = 18,               
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        default_mappings = false,  
        debug = false,
        opacity = 5,                
        resizing_mappings = false,
        post_open_hook = function(buf, win)
          vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "", {
            callback = function()
              goto_preview.close_all_win()
            end,
            nowait = true,
            silent = true,
          })
          vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
            callback = function()
              goto_preview.close_all_win()
            end,
            nowait = true,
            silent = true,
          })

          vim.api.nvim_win_set_config(win, { focusable = true })
          vim.api.nvim_create_autocmd("WinLeave", {
            buffer = buf,
            once = true,
            callback = function()
              pcall(goto_preview.close_all_win)
            end,
          })

          vim.wo[win].winblend = 10
          vim.wo[win].winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
        end,

        post_close_hook = nil,

        references = {
          telescope = require("telescope.themes").get_dropdown({}),
        },

        focus_on_open = true,

        dismiss_on_move = false,
      })

      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#8BE9FD", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e1e" })
    end,
  },
  -- LSP CONFIG BASE SETUP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "lspsaga.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neoconf.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- ICON DIAGNOSTIC
      local signs = { Error = "✘", Warn = "▲", Hint = "💡", Info = "ℹ" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- LSP ATTACH – KEYMAP
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
      end

      local servers = {
        lua_ls = {
          settings = { Lua = { diagnostics = { globals = { "vim" } } } }
        },
        pyright = {
          settings = { python = { analysis = { typeCheckingMode = "basic" } } }
        },
        rust_analyzer = {},
        gopls = {},
        jdtls = {},
        ts_ls = {},
      }

      for server, config in pairs(servers) do
        lspconfig[server].setup(vim.tbl_deep_extend("force", {
          capabilities = capabilities,
          on_attach = on_attach,
        }, config))
      end
    end,
  },
}