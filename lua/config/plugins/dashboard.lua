return {
  "nvimdev/dashboard-nvim",
  lazy = false, -- Dashboard shouldn't be lazy-loaded to properly handle stdin
  dependencies = { 
    "nvim-tree/nvim-web-devicons", -- For file type icons
    "folke/persistence.nvim", -- For session management
    "nvim-telescope/telescope.nvim", -- For file operations
  },
  opts = function()
    -- Icon fallback system for better compatibility
    local function get_safe_icon(preferred, fallback)
      -- Check if we have proper icon font support
      local has_nerd_font = vim.fn.has("gui_running") == 1 or 
                            vim.env.TERM_PROGRAM == "iTerm.app" or
                            vim.env.TERM_PROGRAM == "WezTerm" or
                            string.match(vim.env.TERM or "", "kitty") or
                            string.match(vim.env.TERM or "", "alacritty")
      
      return has_nerd_font and preferred or fallback
    end

    -- Safe icon definitions
    local icons = {
      file = get_safe_icon("", "f"),
      new = get_safe_icon("", "+"),
      recent = get_safe_icon("", "r"),
      project = get_safe_icon("", "p"), 
      session = get_safe_icon("", "s"),
      search = get_safe_icon("", "/"),
      symbols = get_safe_icon("", "y"),
      diagnostics = get_safe_icon("", "!"),
      health = get_safe_icon("", "h"),
      focus = get_safe_icon("", "z"),
      performance = get_safe_icon("", "m"),
      help = get_safe_icon("", "?"),
      plugin = get_safe_icon("", "l"),
      system = get_safe_icon("", "c"),
      quit = get_safe_icon("", "q"),
    }

    -- Ensure web-devicons is properly loaded
    local function setup_icons()
      local has_devicons, devicons = pcall(require, "nvim-web-devicons")
      if has_devicons then
        devicons.setup({
          override = {
            default_icon = {
              icon = "",
              name = "Default",
            },
          },
          default = true,
        })
      end
    end

    -- Call icon setup
    setup_icons()

    local logo = [[
      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                          
      🚀 BACKEND DEVELOPMENT POWERHOUSE 🚀              
                                                          
      � Built for server-side excellence & health        
         🧘 Your coding companion that scales            
    ]]

    logo = string.rep("\n", 6) .. logo .. "\n\n"

    -- Enhanced backend development shortcuts
    local opts = {
      theme = "doom",
      hide = {
        statusline = false, -- Let lualine handle this
        tabline = false,
        winbar = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        -- Backend-focused action center
        center = {
          -- Core file operations
          { 
            action = 'Telescope find_files', 
            desc = " Find Files", 
            icon = icons.file, 
            key = "f",
            key_format = "  %s"
          },
          { 
            action = "ene | startinsert", 
            desc = " New File", 
            icon = icons.new, 
            key = "n",
            key_format = "  %s"
          },
          { 
            action = 'Telescope oldfiles', 
            desc = " Recent Files", 
            icon = icons.recent, 
            key = "r",
            key_format = "  %s"
          },
          
          -- Project & workspace management
          { 
            action = 'Telescope projects', 
            desc = " Projects", 
            icon = icons.project, 
            key = "p",
            key_format = "  %s"
          },
          { 
            action = 'lua require("persistence").load()', 
            desc = " Restore Session", 
            icon = icons.session, 
            key = "s",
            key_format = "  %s"
          },
          
          -- Backend development tools
          { 
            action = 'Telescope live_grep', 
            desc = " Search Code", 
            icon = icons.search, 
            key = "g",
            key_format = "  %s"
          },
          { 
            action = 'Telescope lsp_workspace_symbols', 
            desc = " Find Symbols", 
            icon = icons.symbols, 
            key = "y",
            key_format = "  %s"
          },
          { 
            action = 'Telescope diagnostics', 
            desc = " Diagnostics", 
            icon = icons.diagnostics, 
            key = "d",
            key_format = "  %s"
          },
          
          -- Health & productivity
          { 
            action = 'HealthDashboard', 
            desc = " Health Stats", 
            icon = icons.health, 
            key = "h",
            key_format = "  %s"
          },
          { 
            action = function()
              local ok, health = pcall(require, "developer-health")
              if ok and health and health.start_focus_session then
                health.start_focus_session()
              else
                -- Fallback to command if module isn't available
                vim.cmd("FocusSession")
              end
            end, 
            desc = " Focus Session", 
            icon = icons.focus, 
            key = "z",
            key_format = "  %s"
          },
          
          -- Backend performance
          { 
            action = 'PerfDashboard', 
            desc = " Performance", 
            icon = icons.performance, 
            key = "m",
            key_format = "  %s"
          },
          
          -- Help & configuration
          { 
            action = 'CheatSheet', 
            desc = " Cheatsheet", 
            icon = icons.help, 
            key = "?",
            key_format = "  %s"
          },
          { 
            action = 'Lazy', 
            desc = " Plugin Manager", 
            icon = icons.plugin, 
            key = "l",
            key_format = "  %s"
          },
          { 
            action = 'checkhealth', 
            desc = " System Health", 
            icon = icons.system, 
            key = "c",
            key_format = "  %s"
          },
          
          -- Exit
          { 
            action = function() vim.api.nvim_input("<cmd>qa<cr>") end, 
            desc = " Quit", 
            icon = icons.quit, 
            key = "q",
            key_format = "  %s"
          },
        },
        
        -- Enhanced footer with backend development stats
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          
          -- Get current time for personalized greeting
          local hour = tonumber(os.date("%H"))
          local greeting = "Good "
          if hour < 6 then
            greeting = greeting .. "night, early bird!"
          elseif hour < 12 then
            greeting = greeting .. "morning, dev!"
          elseif hour < 17 then
            greeting = greeting .. "afternoon, coder!"
          elseif hour < 21 then
            greeting = greeting .. "evening, architect!"
          else
            greeting = greeting .. "night, night owl!"
          end
          
          -- Backend development tips
          local tips = {
            "Tip: Use 'h' for health dashboard, 'z' for focus sessions",
            "Tip: 'g' for code search, 'y' for symbol navigation", 
            "Tip: Take breaks every hour for optimal performance",
            "Tip: Check 'm' for performance monitoring",
            "Tip: 'd' shows diagnostics across your codebase",
            "Tip: Focus sessions boost productivity by 40%",
            "Tip: Stay hydrated - your brain needs water to code!",
            "Tip: Good posture = better coding endurance",
          }
          
          local random_tip = tips[math.random(#tips)]
          
          -- Memory usage
          local memory_usage = math.floor(vim.fn.luaeval("collectgarbage('count')") / 1024 * 100) / 100
          
          -- Simple, safe footer
          return {
            "",
            greeting,
            string.format("Loaded %d/%d plugins in %sms | Memory: %sMB", 
                         stats.loaded, stats.count, ms, memory_usage),
            "",
            random_tip,
            "",
            "Ready for backend development excellence!",
          }
        end,
      },
    }

    -- Optimize button spacing for better readability
    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      if not button.key_format then
        button.key_format = "  %s"
      end
    end

    -- Handle dashboard restoration after lazy closes
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end

    -- Backend-specific startup optimizations
    vim.api.nvim_create_autocmd("User", {
      pattern = "DashboardLoaded",
      callback = function()
        -- Pre-warm commonly used backend tools
        vim.schedule(function()
          -- Silently prepare telescope for faster first use
          pcall(require, "telescope")
          -- Pre-load LSP configurations
          pcall(require, "lspconfig")
          -- Ensure health monitoring is ready
          pcall(require, "developer-health")
        end)
      end,
    })

    -- Add dashboard refresh command for backend development
    vim.api.nvim_create_user_command("DashboardRefresh", function()
      vim.cmd("Dashboard")
    end, { desc = "Refresh dashboard" })

    -- Quick dashboard access keymap
    vim.keymap.set("n", "<leader>db", "<cmd>Dashboard<cr>", { desc = "Open Dashboard" })

    -- Enhanced dashboard startup optimization for backend development
    local function setup_dashboard_enhancements()
      -- Ensure all dashboard commands are available
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Delay to ensure all plugins are loaded
          vim.defer_fn(function()
            -- Register fallback commands if plugins haven't loaded yet
            if not pcall(vim.cmd, "command HealthDashboard") then
              vim.api.nvim_create_user_command("HealthDashboard", function()
                vim.notify("Health dashboard is loading... Please try again in a moment.", vim.log.levels.INFO)
              end, { desc = "Health dashboard" })
            end
            
            if not pcall(vim.cmd, "command FocusSession") then
              vim.api.nvim_create_user_command("FocusSession", function()
                vim.notify("Starting a 25-minute focus session! 🍅", vim.log.levels.INFO)
                -- Simple timer implementation
                local timer = vim.loop.new_timer()
                timer:start(25 * 60 * 1000, 0, vim.schedule_wrap(function()
                  vim.notify("🎉 Focus session complete! Time for a break.", vim.log.levels.WARN)
                  timer:close()
                end))
              end, { desc = "Start focus session" })
            end
            
            if not pcall(vim.cmd, "command CheatSheet") then
              vim.api.nvim_create_user_command("CheatSheet", function()
                vim.notify("Cheatsheet is loading... Press <F1> for help.", vim.log.levels.INFO)
              end, { desc = "Show cheatsheet" })
            end
            
            -- Backend-specific dashboard enhancements
            vim.api.nvim_create_user_command("BackendSetup", function()
              local lines = {
                "🚀 Backend Development Quick Setup",
                "═════════════════════════════════",
                "",
                "📋 Essential Commands:",
                "• :Mason - Install LSP servers",
                "• :Copilot setup - AI assistance",
                "• :checkhealth - System diagnostics",
                "",
                "🔧 Backend Tools:",
                "• <leader>lg - Live grep in code",
                "• <leader>sy - Search symbols",
                "• <leader>xx - Show diagnostics",
                "• <leader>ca - Code actions",
                "",
                "🧘 Health Features:",
                "• <leader>hd - Health dashboard",
                "• <leader>hf - Focus session",
                "• <leader>hb - Log break",
                "",
                "⚡ Performance:",
                "• <leader>pd - Performance monitor",
                "• <leader>pm - Memory usage",
                "",
                "Press 'q' to close this help."
              }
              
              local buf = vim.api.nvim_create_buf(false, true)
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
              vim.api.nvim_buf_set_option(buf, "modifiable", false)
              vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
              
              vim.cmd("vnew")
              vim.api.nvim_win_set_buf(0, buf)
              vim.api.nvim_win_set_option(0, "number", false)
              vim.api.nvim_win_set_option(0, "relativenumber", false)
              
              vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = buf })
              vim.keymap.set("n", "<Esc>", "<cmd>q<cr>", { buffer = buf })
            end, { desc = "Backend development setup guide" })
            
            -- Add to dashboard
            vim.keymap.set("n", "<leader>bs", "<cmd>BackendSetup<cr>", { desc = "Backend setup guide" })
            
            -- Font and icon diagnostic command
            vim.api.nvim_create_user_command("CheckIcons", function()
              local lines = {
                "🔧 Icon & Font Diagnostic",
                "═══════════════════════",
                "",
                "Terminal Info:",
                "• TERM: " .. (vim.env.TERM or "unknown"),
                "• TERM_PROGRAM: " .. (vim.env.TERM_PROGRAM or "unknown"),
                "",
                "Icon Test:",
                "• File:      " .. icons.file,
                "• Project:   " .. icons.project, 
                "• Search:    " .. icons.search,
                "• Health:    " .. icons.health,
                "",
                "Recommendations:",
                "• Install a Nerd Font (FiraCode Nerd Font recommended)",
                "• Set terminal font to your Nerd Font",
                "• Restart terminal after font change",
                "",
                "Popular Nerd Fonts:",
                "• FiraCode Nerd Font",
                "• JetBrainsMono Nerd Font", 
                "• Hack Nerd Font",
                "",
                "Press 'q' to close"
              }
              
              local buf = vim.api.nvim_create_buf(false, true)
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
              vim.api.nvim_buf_set_option(buf, "modifiable", false)
              vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
              
              vim.cmd("vnew")
              vim.api.nvim_win_set_buf(0, buf)
              vim.api.nvim_win_set_option(0, "number", false)
              vim.api.nvim_win_set_option(0, "relativenumber", false)
              
              vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = buf })
              vim.keymap.set("n", "<Esc>", "<cmd>q<cr>", { buffer = buf })
            end, { desc = "Check icon and font setup" })

            -- Add keymap for quick icon check
            vim.keymap.set("n", "<leader>ic", "<cmd>CheckIcons<cr>", { desc = "Check icons" })
            
          end, 1000) -- Wait 1 second for plugins to load
        end,
      })
    end

    -- Auto-refresh dashboard on configuration changes
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "**/dashboard.lua",
      callback = function()
        vim.schedule(function()
          -- Reload dashboard config
          package.loaded["config.plugins.dashboard"] = nil
          require("config.plugins.dashboard")
          vim.notify("Dashboard configuration reloaded!", vim.log.levels.INFO)
        end)
      end,
    })

    -- Dashboard performance monitoring
    local dashboard_start_time = vim.loop.hrtime()
    vim.api.nvim_create_autocmd("User", {
      pattern = "DashboardReady",
      callback = function()
        local load_time = (vim.loop.hrtime() - dashboard_start_time) / 1000000
        if load_time > 100 then -- If dashboard takes more than 100ms
          vim.notify(string.format("Dashboard loaded in %.1fms - consider optimizing", load_time), vim.log.levels.WARN)
        end
      end,
    })

    -- Ensure web-devicons is properly loaded
    local function setup_icons()
      local has_devicons, devicons = pcall(require, "nvim-web-devicons")
      if has_devicons then
        devicons.setup({
          override = {
            default_icon = {
              icon = "",
              name = "Default",
            },
          },
          default = true,
        })
      end
    end

    -- Call icon setup
    setup_icons()

    -- Setup enhancements
    setup_dashboard_enhancements()

    return opts
  end,
}
