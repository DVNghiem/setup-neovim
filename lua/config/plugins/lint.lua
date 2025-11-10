return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      python = { "ruff" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
      go = { "golangcilint" },
      rust = { "clippy" },
      lua = { "luacheck" },
      sh = { "shellcheck" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "LintStarted",
      callback = function()
        vim.notify(" Linting...", vim.log.levels.INFO, { title = "nvim-lint" })
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "LintDone",
      callback = function()
        vim.notify(" Linted", vim.log.levels.INFO, { title = "nvim-lint" })
      end,
    })
  end,
}