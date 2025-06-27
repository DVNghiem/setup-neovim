return {
  -- Developer health and ergonomics monitoring
  {
    dir = vim.fn.stdpath("config"),
    name = "developer-health",
    event = "VeryLazy",
    config = function()
      -- Store session start time
      vim.g.nvim_start_time = vim.g.nvim_start_time or os.time()
      
      -- Health tracking variables
      local health_state = {
        last_break = os.time(),
        coding_streak = 0,
        breaks_taken = 0,
        water_reminders = 0,
        posture_checks = 0,
      }
      
      -- Save health data
      local function save_health_data()
        local data_file = vim.fn.stdpath("data") .. "/health_stats.json"
        local data = vim.fn.json_encode(health_state)
        vim.fn.writefile({data}, data_file)
      end
      
      -- Load health data
      local function load_health_data()
        local data_file = vim.fn.stdpath("data") .. "/health_stats.json"
        if vim.fn.filereadable(data_file) == 1 then
          local data = vim.fn.readfile(data_file)[1]
          health_state = vim.fn.json_decode(data)
        end
      end
      
      -- Health dashboard
      local function show_health_dashboard()
        local session_time = os.time() - vim.g.nvim_start_time
        local hours = math.floor(session_time / 3600)
        local minutes = math.floor((session_time % 3600) / 60)
        
        local lines = {
          "🧘 Developer Health Dashboard",
          "════════════════════════════",
          string.format("⏰ Session Time: %dh %dm", hours, minutes),
          string.format("☕ Breaks Taken: %d", health_state.breaks_taken),
          string.format("💧 Water Reminders: %d", health_state.water_reminders),
          string.format("🪑 Posture Checks: %d", health_state.posture_checks),
          "",
          "📋 Health Guidelines:",
          "• Take a 5-minute break every hour",
          "• Follow 20-20-20 rule for eyes",
          "• Stay hydrated (8 glasses/day)",
          "• Check posture regularly",
          "• Stretch your hands and neck",
          "",
          "🎯 Recommended Actions:",
        }
        
        -- Add personalized recommendations
        if session_time > 3600 and health_state.breaks_taken == 0 then
          table.insert(lines, "⚠️  You need a break! Step away from the screen.")
        end
        
        if health_state.water_reminders < math.floor(session_time / 1800) then
          table.insert(lines, "💧 Time to drink some water!")
        end
        
        if health_state.posture_checks < math.floor(session_time / 2700) then
          table.insert(lines, "🪑 Check your posture and adjust your setup.")
        end
        
        -- Create buffer and display
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.api.nvim_buf_set_option(buf, "modifiable", false)
        vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
        
        vim.cmd("vnew")
        vim.api.nvim_win_set_buf(0, buf)
        vim.api.nvim_win_set_option(0, "number", false)
        vim.api.nvim_win_set_option(0, "relativenumber", false)
        
        vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = buf })
      end
      
      -- Manual break logging
      local function log_break()
        health_state.breaks_taken = health_state.breaks_taken + 1
        health_state.last_break = os.time()
        save_health_data()
        vim.notify("Break logged! 🧘 Good job taking care of yourself.", vim.log.levels.INFO, {
          title = "Health Tracker",
          timeout = 3000,
        })
      end
      
      -- Quick stretch reminder
      local function quick_stretch()
        local stretches = {
          "🤲 Stretch your fingers and make fists 10 times",
          "🙆 Roll your shoulders backward 5 times",
          "👀 Look away from screen and blink slowly 10 times",
          "🧘 Take 3 deep breaths",
          "💆 Gently massage your temples",
          "🤸 Stretch your neck left and right",
          "👐 Stretch your arms above your head",
        }
        
        local stretch = stretches[math.random(#stretches)]
        vim.notify(stretch, vim.log.levels.INFO, {
          title = "Quick Stretch",
          timeout = 8000,
        })
      end
      
      -- Pomodoro-style timer
      local function start_focus_session(duration)
        duration = duration or 25 -- 25 minutes default
        local start_time = os.time()
        
        vim.notify(string.format("🍅 Focus session started! %d minutes of deep work.", duration), 
                   vim.log.levels.INFO, { title = "Focus Mode" })
        
        -- Timer for focus session end
        local focus_timer = vim.loop.new_timer()
        focus_timer:start(duration * 60 * 1000, 0, vim.schedule_wrap(function()
          vim.notify("🎉 Focus session complete! Time for a 5-minute break.", 
                     vim.log.levels.WARN, { title = "Break Time!" })
          focus_timer:stop()
          focus_timer:close()
        end))
      end
      
      -- Eye strain reduction
      local function reduce_brightness()
        vim.notify("💡 Consider reducing screen brightness or using dark mode for eye comfort.", 
                   vim.log.levels.INFO, { title = "Eye Care" })
      end
      
      -- Automated health reminders
      local function setup_health_timers()
        -- Hydration reminder (every 30 minutes)
        local hydration_timer = vim.loop.new_timer()
        hydration_timer:start(1800000, 1800000, vim.schedule_wrap(function()
          health_state.water_reminders = health_state.water_reminders + 1
          save_health_data()
          vim.notify("💧 Hydration check! Time for a glass of water.", vim.log.levels.INFO, {
            title = "Health Reminder",
            timeout = 5000,
          })
        end))
        
        -- Posture reminder (every 45 minutes)
        local posture_timer = vim.loop.new_timer()
        posture_timer:start(2700000, 2700000, vim.schedule_wrap(function()
          health_state.posture_checks = health_state.posture_checks + 1
          save_health_data()
          vim.notify("🪑 Posture check! Sit up straight and adjust your monitor.", vim.log.levels.WARN, {
            title = "Ergonomics",
            timeout = 5000,
          })
        end))
        
        -- Break reminder (every hour)
        local break_timer = vim.loop.new_timer()
        break_timer:start(3600000, 3600000, vim.schedule_wrap(function()
          local time_since_break = os.time() - health_state.last_break
          if time_since_break > 3600 then -- More than 1 hour
            vim.notify("🧘 Break time! You've been coding for over an hour. Take a 5-10 minute break.", 
                       vim.log.levels.ERROR, { title = "Mandatory Break!" })
          end
        end))
        
        -- Eye strain reminder (every 20 minutes - 20-20-20 rule)
        local eye_timer = vim.loop.new_timer()
        eye_timer:start(1200000, 1200000, vim.schedule_wrap(function()
          vim.notify("👀 20-20-20 Rule: Look at something 20 feet away for 20 seconds!", 
                     vim.log.levels.INFO, { title = "Eye Health" })
        end))
      end
      
      -- Load data and start timers
      load_health_data()
      vim.defer_fn(setup_health_timers, 5000)
      
      -- Auto-save health data periodically and on exit
      -- Temporarily disabled to prevent j/k key lag
      -- local save_timer = vim.loop.new_timer()
      -- save_timer:start(300000, 300000, vim.schedule_wrap(save_health_data)) -- Every 5 minutes
      
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = save_health_data
      })
      
      -- Create user commands
      vim.api.nvim_create_user_command("HealthDashboard", show_health_dashboard, { desc = "Show health dashboard" })
      vim.api.nvim_create_user_command("LogBreak", log_break, { desc = "Log a break" })
      vim.api.nvim_create_user_command("QuickStretch", quick_stretch, { desc = "Get a quick stretch reminder" })
      vim.api.nvim_create_user_command("FocusSession", function(opts)
        local duration = tonumber(opts.args) or 25
        start_focus_session(duration)
      end, { desc = "Start focus session", nargs = "?" })
      
      -- Key mappings
      vim.keymap.set("n", "<leader>hd", show_health_dashboard, { desc = "Health dashboard" })
      vim.keymap.set("n", "<leader>hb", log_break, { desc = "Log break" })
      vim.keymap.set("n", "<leader>hs", quick_stretch, { desc = "Quick stretch" })
      vim.keymap.set("n", "<leader>hf", function() start_focus_session() end, { desc = "Start focus session" })
      
      -- Welcome message with health tips
      vim.defer_fn(function()
        vim.notify("💪 Welcome to your health-conscious coding environment!\n" ..
                  "Use <leader>h* for health commands. Take care of yourself!", 
                  vim.log.levels.INFO, { title = "Health Monitor Active" })
      end, 2000)
    end,
  },
  
  -- Smart lighting adjustment (if supported)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Time-based theme switching for eye comfort
      local function auto_theme_switch()
        local hour = tonumber(os.date("%H"))
        
        if hour >= 20 or hour <= 6 then
          -- Night mode - darker theme
          vim.cmd("colorscheme tokyonight-night")
          vim.opt.background = "dark"
        elseif hour >= 7 and hour <= 17 then
          -- Day mode - lighter theme
          vim.cmd("colorscheme tokyonight-day")
          vim.opt.background = "light"
        else
          -- Evening mode - medium theme
          vim.cmd("colorscheme tokyonight-moon")
          vim.opt.background = "dark"
        end
      end
      
      -- Auto-switch theme based on time
      auto_theme_switch()
      
      -- Set up timer to check every hour
      local theme_timer = vim.loop.new_timer()
      theme_timer:start(3600000, 3600000, vim.schedule_wrap(auto_theme_switch))
      
      -- Manual theme switching
      vim.keymap.set("n", "<leader>td", function()
        vim.cmd("colorscheme tokyonight-day")
        vim.opt.background = "light"
        vim.notify("Switched to day theme for better daylight visibility", vim.log.levels.INFO)
      end, { desc = "Day theme" })
      
      vim.keymap.set("n", "<leader>tn", function()
        vim.cmd("colorscheme tokyonight-night")
        vim.opt.background = "dark"
        vim.notify("Switched to night theme for reduced eye strain", vim.log.levels.INFO)
      end, { desc = "Night theme" })
    end,
  },
}
