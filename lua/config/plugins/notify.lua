return {
  -- Disable nvim-notify to prevent compatibility issues
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },
  
  -- Simple custom notification system
  {
    dir = vim.fn.stdpath("config"),
    name = "simple-notifications",
    priority = 1000,
    config = function()
      -- Ultra-simple notification function that never fails
      local function safe_notify(msg, level, opts)
        level = level or vim.log.levels.INFO
        opts = opts or {}
        
        local level_str = level == vim.log.levels.ERROR and "ERROR" or
                         level == vim.log.levels.WARN and "WARN" or "INFO"
        local title = opts.title and ("[" .. opts.title .. "] ") or ""
        
        -- Always use print to avoid any compatibility issues
        print(string.format("%s%s: %s", title, level_str, msg))
      end
      
      -- Override vim.notify with our ultra-safe function
      vim.notify = safe_notify
      
      -- Health notification functions
      _G.health_notify = {
        break_reminder = function()
          safe_notify("🧘 Time for a break! Your eyes and posture will thank you.", vim.log.levels.INFO, {
            title = "Health Break"
          })
        end,
        
        hydration = function()
          safe_notify("💧 Stay hydrated! Time for a water break.", vim.log.levels.INFO, {
            title = "Hydration"
          })
        end,
        
        posture = function()
          safe_notify("🪑 Check your posture! Sit up straight and adjust your monitor.", vim.log.levels.WARN, {
            title = "Posture Check"
          })
        end,
        
        eye_rest = function()
          safe_notify("👀 20-20-20 Rule: Look at something 20 feet away for 20 seconds!", vim.log.levels.INFO, {
            title = "Eye Health"
          })
        end
      }
      
      -- Setup periodic health reminders using vim timers (more stable)
      vim.defer_fn(function()
        -- Break reminder every hour (3600000ms)
        vim.fn.timer_start(3600000, function()
          _G.health_notify.break_reminder()
        end, { ['repeat'] = -1 })
        
        -- Hydration every 30 minutes (1800000ms)
        vim.fn.timer_start(1800000, function()
          _G.health_notify.hydration()
        end, { ['repeat'] = -1 })
        
        -- Posture check every 45 minutes (2700000ms)
        vim.fn.timer_start(2700000, function()
          _G.health_notify.posture()
        end, { ['repeat'] = -1 })
        
        -- Eye rest every 20 minutes (1200000ms)
        vim.fn.timer_start(1200000, function()
          _G.health_notify.eye_rest()
        end, { ['repeat'] = -1 })
        
        safe_notify("Health monitoring started! Automatic reminders enabled.", vim.log.levels.INFO, {
          title = "Health System"
        })
      end, 10000) -- Start after 10 seconds
      
      -- Notification shortcuts
      vim.keymap.set("n", "<leader>nd", function()
        safe_notify("Notifications are handled by simple print system", vim.log.levels.INFO, {
          title = "System Info"
        })
      end, { desc = "Show notification info" })
      
      vim.keymap.set("n", "<leader>nh", function()
        safe_notify("Health reminders: Break every hour, hydration every 30min, posture every 45min, eye rest every 20min", vim.log.levels.INFO, {
          title = "Health Schedule"
        })
      end, { desc = "Show health schedule" })
      
      -- Test notification
      safe_notify("Simple notification system loaded successfully!", vim.log.levels.INFO, {
        title = "System Ready"
      })
    end,
  },
}
