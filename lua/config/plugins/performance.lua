return {
  -- Performance monitoring and startup optimization
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
      vim.g.startuptime_exe_args = { '+let g:auto_session_enabled = 0' }
    end,
  },
  
  -- Better lazy loading and performance
  {
    "lewis6991/impatient.nvim",
    priority = 1000,
    config = function()
      require('impatient').enable_profile()
    end,
  },
  
  -- Memory usage monitoring
  {
    "jbyuki/venn.nvim",
    cmd = "VBox",
    config = function()
      -- Memory monitoring function
      local function show_memory_usage()
        local mem_usage = vim.fn.luaeval("collectgarbage('count')")
        local mem_mb = mem_usage / 1024
        vim.notify(string.format("Memory usage: %.2f MB", mem_mb), vim.log.levels.INFO, {
          title = "Performance Monitor",
          timeout = 3000,
        })
      end
      
      -- Memory cleanup function
      local function cleanup_memory()
        collectgarbage("collect")
        local mem_usage = vim.fn.luaeval("collectgarbage('count')")
        local mem_mb = mem_usage / 1024
        vim.notify(string.format("Memory cleaned! Current usage: %.2f MB", mem_mb), vim.log.levels.INFO, {
          title = "Memory Cleanup",
          timeout = 3000,
        })
      end
      
      -- Auto memory cleanup for long sessions
      local cleanup_timer = vim.loop.new_timer()
      cleanup_timer:start(1800000, 1800000, vim.schedule_wrap(function() -- Every 30 minutes
        cleanup_memory()
      end))
      
      vim.keymap.set("n", "<leader>pm", show_memory_usage, { desc = "Show memory usage" })
      vim.keymap.set("n", "<leader>pc", cleanup_memory, { desc = "Cleanup memory" })
    end,
  },
  
  -- File size and performance warnings
  {
    "LunarVim/bigfile.nvim",
    event = "BufReadPre",
    opts = {
      filesize = 2, -- Size in MB
      pattern = { "*" },
      features = {
        "indent_blankline",
        "illuminate",
        "lsp",
        "treesitter",
        "syntax",
        "matchparen",
        "vimopts",
        "filetype",
      },
    },
    config = function(_, opts)
      require("bigfile").setup(opts)
      
      -- Custom handler for large files
      vim.api.nvim_create_autocmd("BufReadPre", {
        pattern = "*",
        callback = function()
          local file_size = vim.fn.getfsize(vim.fn.expand("%"))
          if file_size > 2097152 then -- 2MB
            vim.notify("Large file detected! Some features disabled for better performance.", vim.log.levels.WARN, {
              title = "Performance Mode",
              timeout = 5000,
            })
            
            -- Additional optimizations for large files
            vim.opt_local.foldmethod = "manual"
            vim.opt_local.spell = false
            vim.opt_local.wrap = false
            vim.opt_local.relativenumber = false
            vim.opt_local.cursorline = false
            vim.opt_local.cursorcolumn = false
          end
        end,
      })
    end,
  },
  
  -- Better buffer management for performance
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
      { "<leader>bd", "<cmd>Bdelete<cr>", desc = "Delete buffer (safe)" },
      { "<leader>bD", "<cmd>Bwipeout<cr>", desc = "Wipeout buffer" },
    },
  },
  
  -- Session size monitoring and optimization
  {
    "gennaro-tedesco/nvim-peekup",
    cmd = "PeekupOpen",
    config = function()
      require('nvim-peekup.config').on_keystroke["delay"] = 100
      require('nvim-peekup.config').on_keystroke["autoclose"] = true
    end,
    keys = {
      { '<leader>"', "<cmd>PeekupOpen<cr>", desc = "Peek registers" },
    },
  },
  
  -- Workspace health monitoring
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true },
    },
  },
  
  -- Custom performance dashboard
  {
    dir = vim.fn.stdpath("config"),
    name = "performance-dashboard",
    config = function()
      -- Create performance monitoring commands
      vim.api.nvim_create_user_command("PerfDashboard", function()
        local stats = {
          memory = vim.fn.luaeval("collectgarbage('count')") / 1024,
          buffers = #vim.api.nvim_list_bufs(),
          windows = #vim.api.nvim_list_wins(),
          startup_time = vim.g.startup_time or "Unknown",
          session_time = os.time() - (vim.g.nvim_start_time or os.time()),
        }
        
        local lines = {
          "📊 Neovim Performance Dashboard",
          "═══════════════════════════════",
          string.format("💾 Memory Usage: %.2f MB", stats.memory),
          string.format("📄 Open Buffers: %d", stats.buffers),
          string.format("🪟 Open Windows: %d", stats.windows),
          string.format("⚡ Startup Time: %s", stats.startup_time),
          string.format("⏰ Session Time: %d minutes", math.floor(stats.session_time / 60)),
          "",
          "💡 Tips for better performance:",
          "• Close unused buffers with <leader>bd",
          "• Use <leader>pc to cleanup memory",
          "• Take breaks every hour!",
        }
        
        -- Create a new buffer for the dashboard
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.api.nvim_buf_set_option(buf, "modifiable", false)
        vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
        
        -- Open in a new window
        vim.cmd("vnew")
        vim.api.nvim_win_set_buf(0, buf)
        vim.api.nvim_win_set_option(0, "number", false)
        vim.api.nvim_win_set_option(0, "relativenumber", false)
        vim.api.nvim_win_set_option(0, "cursorline", false)
        
        -- Auto-close on any key
        vim.keymap.set("n", "<buffer>", "<cmd>q<cr>", { buffer = buf })
      end, { desc = "Show performance dashboard" })
      
      vim.keymap.set("n", "<leader>pd", "<cmd>PerfDashboard<cr>", { desc = "Performance dashboard" })
      
      -- Auto performance warnings
      local function check_performance()
        local memory = vim.fn.luaeval("collectgarbage('count')") / 1024
        local buffers = #vim.api.nvim_list_bufs()
        
        if memory > 100 then -- 100MB
          vim.notify(string.format("High memory usage: %.1f MB. Consider cleaning up.", memory), 
                     vim.log.levels.WARN, { title = "Performance Warning" })
        end
        
        if buffers > 50 then
          vim.notify(string.format("Many buffers open: %d. Consider closing some.", buffers), 
                     vim.log.levels.WARN, { title = "Performance Warning" })
        end
      end
      
      -- Check performance every 10 minutes
      local perf_timer = vim.loop.new_timer()
      perf_timer:start(600000, 600000, vim.schedule_wrap(check_performance))
    end,
  },
  
  -- Smart window management for performance
  {
    "sindrets/winshift.nvim",
    cmd = "WinShift",
    opts = {
      highlight_moving_win = true,
      focused_hl_group = "Visual",
      moving_win_options = {
        wrap = false,
        cursorline = false,
        cursorcolumn = false,
        colorcolumn = "",
      },
    },
    keys = {
      { "<C-W><C-M>", "<cmd>WinShift<cr>", desc = "Enter WinShift mode" },
      { "<C-W>X", "<cmd>WinShift swap<cr>", desc = "Swap windows" },
    },
  },
}
