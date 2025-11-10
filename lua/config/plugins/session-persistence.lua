return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
      pre_save = nil,
      save_empty = false,
    },
    keys = {
      { "<leader>ss", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>sS", function() require("persistence").select() end, desc = "Select Session" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>sd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
  
  -- Project management for switching contexts quickly
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "go.mod", "Cargo.toml", "pyproject.toml", "requirements.txt" },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = 'global',
        datapath = vim.fn.stdpath("data"),
      })
      
      -- Auto-load session when entering a project
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 then
            require("persistence").load()
          end
        end,
      })
    end,
  },
}
