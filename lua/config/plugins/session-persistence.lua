return {
  -- Enhanced session management for long coding sessions
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
  
  -- Auto-save disabled to prevent j/k key lag - using manual auto-save in base-setup.lua instead
  -- {
  --   "okuuva/auto-save.nvim",
  --   event = { "InsertLeave", "TextChanged" },
  --   opts = {
  --     enabled = false,  -- Disabled to prevent key lag
  --   },
  -- },
      -- Auto-save plugin disabled - causing j/k key lag
      -- condition = function(buf)
      --   local fn = vim.fn
      --   local utils = require("auto-save.utils.data")
      --   
      --   if fn.getbufvar(buf, "&modifiable") == 1 and
      --      utils.not_in(fn.getbufvar(buf, "&filetype"), {}) and
      --      fn.bufname(buf) ~= "" then
      --     return true
      --   end
      --   return false
      -- end,
      -- write_all_buffers = false,
      -- debounce_delay = 135,
      -- callbacks = {
      --   enabling = nil,
      --   disabling = nil,
      --   before_asserting_save = nil,
      --   before_saving = nil,
      --   after_saving = function()
      --     -- Custom auto-save notification (replaces deprecated execution_message)
      --     vim.notify("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"), vim.log.levels.INFO, {
      --       title = "Auto-Save",
      --       timeout = 1250,
      --     })
      --     
      --     -- Notify when auto-saving large files
      --     local file_size = vim.fn.getfsize(vim.fn.expand("%"))
      --     if file_size > 1024 * 1024 then -- 1MB
      --       vim.notify("Large file auto-saved: " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
      --     end
      --   end
      -- },
    -- },
  -- },
}
