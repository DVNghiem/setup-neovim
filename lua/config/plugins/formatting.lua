return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" }, -- Changed to only load when saving for faster file opening
    dependencies = {
        "zapling/mason-conform.nvim",
    },
    config = function()
      -- Setup mason-conform to auto-install formatters
      require("mason-conform").setup()
      
      local conform = require("conform")
  
      conform.setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
          -- rust: uses rustfmt via rust-analyzer
          -- go: uses gofmt/goimports via gopls
        },
        -- format_on_save = {f,
        --   lsp_fallback = false,
        --   async = false,
        --   timeout_ms = 1000,
        -- },
      })
  
      vim.keymap.set({ "n", "v" }, "<leader>fm", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format file" })
    end,
  }
  
