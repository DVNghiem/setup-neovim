-- Leader keys are set in init.lua before lazy loads
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  { { import = "config.plugins" } },
  {
    -- Performance optimizations
    performance = {
      cache = {
        enabled = true,
      },
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
    -- UI optimizations
    ui = {
      border = "rounded",
      icons = {
        cmd = "⌘",
        config = "🛠",
        event = "📅",
        ft = "📂",
        init = "⚙",
        keys = "🗝",
        plugin = "🔌",
        runtime = "💻",
        require = "🌙",
        source = "📄",
        start = "🚀",
        task = "📌",
        lazy = "💤 ",
      },
    },
    -- Better defaults for lazy loading
    defaults = {
      lazy = true, -- Lazy load by default
      version = false, -- Don't use versions by default
    },
    -- Install missing plugins on startup
    install = {
      missing = true,
      colorscheme = { "tokyonight", "habamax" },
    },
    -- Check for updates but don't auto-update
    checker = {
      enabled = false,
      notify = false,
    },
    -- Change detection
    change_detection = {
      enabled = true,
      notify = false, -- Don't spam notifications
    },
    -- Profiling support
    profiling = {
      loader = false,
      require = false,
    },
  }
)