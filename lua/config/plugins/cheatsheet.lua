-- Ultimate Neovim Keymaps for Long Coding Sessions
-- ================================================

return {
  -- Interactive keymap helper and cheatsheet
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      
      -- Register all our custom groups
      wk.register({
        ["<leader>"] = {
          -- Health and wellness
          h = {
            name = "🧘 Health & Wellness",
            d = "Health dashboard",
            b = "Log break",
            s = "Quick stretch",
            f = "Focus session (25min)",
          },
          
          -- Performance monitoring
          p = {
            name = "⚡ Performance",
            d = "Performance dashboard",
            m = "Show memory usage",
            c = "Cleanup memory",
          },
          
          -- AI assistance
          cc = {
            name = "🤖 Copilot Chat",
            p = "Toggle chat",
            e = "Explain code",
            r = "Review code",
            f = "Fix code",
            o = "Optimize code",
            d = "Generate docs",
            t = "Generate tests",
            q = "Quick chat",
          },
          
          -- Theme and display
          t = {
            name = "🎨 Theme & Display",
            d = "Day theme",
            n = "Night theme",
            t = "Toggle terminal",
          },
          
          -- Notifications
          n = {
            name = "🔔 Notifications",
            d = "Dismiss notifications",
            h = "Notification history",
          },
          
          -- Workspace management
          w = {
            name = "🏢 Workspace",
            a = "Add workspace",
            r = "Remove workspace",
            l = "List workspaces",
            o = "Open workspace",
          },
          
          -- Session management
          s = {
            name = "💾 Session",
            s = "Restore session",
            S = "Select session",
            l = "Last session",
            d = "Don't save session",
          },
          
          -- Search and replace
          S = "🔍 Toggle Spectre (find/replace)",
          sw = "Search current word",
          sp = "Search in current file",
          
          -- Diagnostics and trouble
          x = {
            name = "🚨 Diagnostics",
            x = "Toggle diagnostics",
            X = "Buffer diagnostics",
            Q = "Quickfix list",
            L = "Location list",
          },
          
          -- Focus and zen modes
          z = "🧘 Toggle zen mode",
          
          -- Undo and history
          u = "📜 Toggle undo tree",
        },
        
        -- Quick navigation
        ["J"] = "Move down 5 lines",
        ["K"] = "Move up 5 lines",
        ["H"] = "Go to beginning of line",
        ["L"] = "Go to end of line",
        
        -- Buffer management
        ["<Tab>"] = "Next tab",
        ["<S-Tab>"] = "Previous tab",
        
        -- Window resizing
        ["<C-Left>"] = "Resize window left",
        ["<C-Right>"] = "Resize window right",
        ["<C-Up>"] = "Resize window up",
        ["<C-Down>"] = "Resize window down",
      })
      
      -- Create a comprehensive cheatsheet command
      vim.api.nvim_create_user_command("CheatSheet", function()
        local lines = {
          "🚀 ULTIMATE NEOVIM CHEATSHEET FOR LONG CODING SESSIONS",
          "══════════════════════════════════════════════════════",
          "",
          "🧘 HEALTH & WELLNESS:",
          "  <leader>hd  - Health dashboard (check your stats!)",
          "  <leader>hb  - Log a break (mark when you rest)",
          "  <leader>hs  - Quick stretch reminder",
          "  <leader>hf  - Start 25-min focus session",
          "",
          "⚡ PERFORMANCE MONITORING:",
          "  <leader>pd  - Performance dashboard",
          "  <leader>pm  - Show memory usage",
          "  <leader>pc  - Cleanup memory",
          "  :StartupTime - Analyze startup performance",
          "",
          "🤖 AI ASSISTANCE (Enhanced Copilot):",
          "  <C-l>       - Accept Copilot suggestion (insert mode)",
          "  <C-j/k>     - Next/Previous suggestion (insert mode)",
          "  <leader>ccp - Toggle Copilot Chat",
          "  <leader>cce - Explain selected code",
          "  <leader>ccr - Review code for issues",
          "  <leader>ccf - Fix code problems",
          "  <leader>cco - Optimize code",
          "  <leader>ccd - Generate documentation",
          "  <leader>cct - Generate tests",
          "  <leader>ccq - Quick chat with Copilot",
          "",
          "🏃 NAVIGATION & MOVEMENT:",
          "  jk/kj       - Exit insert mode (alternative to Esc)",
          "  J/K         - Move 5 lines down/up",
          "  H/L         - Go to start/end of line",
          "  <C-d/u>     - Scroll half page (centered)",
          "  s{char}{char} - Leap to any location (leap.nvim)",
          "",
          "💾 SESSION & WORKSPACE:",
          "  <leader>ss  - Restore session",
          "  <leader>sl  - Restore last session",
          "  <leader>wa  - Add workspace",
          "  <leader>wo  - Open workspace",
          "",
          "🔍 SEARCH & REPLACE:",
          "  <leader>S   - Toggle Spectre (project-wide find/replace)",
          "  <leader>sw  - Search current word",
          "  <leader>rw  - Replace word under cursor",
          "  <leader>nh  - Clear search highlights",
          "",
          "🚨 DIAGNOSTICS & DEBUGGING:",
          "  <leader>xx  - Toggle diagnostics (Trouble)",
          "  <leader>xX  - Buffer diagnostics",
          "  [q/]q       - Previous/Next quickfix",
          "  [l/]l       - Previous/Next location list",
          "",
          "📁 FILE MANAGEMENT:",
          "  -           - Open parent directory (Oil)",
          "  <leader>-   - Open parent directory (floating)",
          "  <leader>bd  - Delete buffer (safe)",
          "  <leader>ba  - Close all buffers except current",
          "",
          "🎨 THEMES & DISPLAY:",
          "  <leader>td  - Day theme (easier on eyes in daylight)",
          "  <leader>tn  - Night theme (reduced eye strain)",
          "  <leader>z   - Toggle zen mode (distraction-free)",
          "",
          "💡 PRODUCTIVITY TIPS:",
          "  • Use focus sessions (<leader>hf) for deep work",
          "  • Take breaks every hour (<leader>hb to log)",
          "  • Follow 20-20-20 rule for eye health",
          "  • Use zen mode for distraction-free coding",
          "  • Monitor performance with <leader>pd",
          "  • Auto-save is enabled - don't worry about losing work!",
          "",
          "🔔 NOTIFICATIONS:",
          "  <leader>nd  - Dismiss all notifications",
          "  <leader>nh  - Show notification history",
          "",
          "📜 HISTORY & UNDO:",
          "  <leader>u   - Toggle undo tree",
          "  U           - Redo (easier than Ctrl-R)",
          "",
          "⌨️  ERGONOMIC SHORTCUTS:",
          "  <C-s>       - Save file (works in any mode)",
          "  <leader>w   - Save file",
          "  <leader>wa  - Save all files",
          "  <leader>q   - Quit",
          "  <leader>Q   - Force quit",
          "",
          "🪟 WINDOW MANAGEMENT:",
          "  <C-h/j/k/l> - Navigate windows",
          "  <C-w>z      - Maximize current window",
          "  <C-w>=      - Equalize window sizes",
          "  <leader>sv  - Split vertically",
          "  <leader>sh  - Split horizontally",
          "",
          "💻 TERMINAL:",
          "  <leader>tt  - Toggle terminal",
          "  <Esc>       - Exit terminal mode",
          "",
          "Remember: Your health comes first! Take regular breaks! 💪",
        }
        
        -- Create buffer and display cheatsheet
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.api.nvim_buf_set_option(buf, "modifiable", false)
        vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
        
        vim.cmd("vnew")
        vim.api.nvim_win_set_buf(0, buf)
        vim.api.nvim_win_set_option(0, "number", false)
        vim.api.nvim_win_set_option(0, "relativenumber", false)
        vim.api.nvim_win_set_option(0, "wrap", true)
        
        vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = buf })
        vim.keymap.set("n", "<Esc>", "<cmd>q<cr>", { buffer = buf })
      end, { desc = "Show comprehensive cheatsheet" })
      
      -- Quick access to cheatsheet
      vim.keymap.set("n", "<leader>?", "<cmd>CheatSheet<cr>", { desc = "Show cheatsheet" })
      vim.keymap.set("n", "<F1>", "<cmd>CheatSheet<cr>", { desc = "Show cheatsheet" })
      
      -- Emergency help for when you're stuck
      vim.keymap.set("n", "<leader>help", function()
        vim.notify("🆘 QUICK HELP:\n" ..
                  "• <F1> or <leader>? - Full cheatsheet\n" ..
                  "• <leader>hd - Health dashboard\n" ..
                  "• <leader>pd - Performance info\n" ..
                  "• <leader>z - Zen mode\n" ..
                  "• <leader>hb - Log a break!", 
                  vim.log.levels.INFO, { 
                    title = "Emergency Help",
                    timeout = 10000 
                  })
      end, { desc = "Emergency help" })
    end,
  },
}
