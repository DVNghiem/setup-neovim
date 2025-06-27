# 🚀 Installation & Setup Guide

## Quick Setup

1. **Restart Neovim** to trigger plugin installation:
   ```bash
   nvim
   ```

2. **Wait for plugins to install** - You'll see the Lazy plugin manager installing everything

3. **Once complete, press `<F1>`** to see your complete cheatsheet

## 🎯 First Steps After Installation

### 1. Test Your Health Dashboard
```
<leader>hd
```
This shows your health tracking dashboard.

### 2. Start Your First Focus Session
```
<leader>hf
```
Begin a 25-minute focused coding session.

### 3. Try Copilot Chat (after it installs)
```
<leader>ccp
```
Open AI-powered code assistance.

### 4. Explore Zen Mode
```
<leader>z
```
Enter distraction-free coding mode.

## 🛠️ If You Encounter Issues

### Missing Dependencies
Some plugins might need additional tools. Install them as needed:

```bash
# For better search
sudo apt install ripgrep fd-find

# For language servers (optional)
npm install -g pyright typescript-language-server

# For better terminal integration
sudo apt install tmux
```

### Plugin Conflicts
If any plugins conflict with your existing setup:

1. Check `:Lazy` to see plugin status
2. Use `:Lazy clean` to remove unused plugins
3. Use `:Lazy sync` to update all plugins

### Performance Issues
If startup feels slow:

1. Run `:StartupTime` to analyze performance
2. Check `:Lazy profile` for plugin loading times
3. Use `<leader>pd` for performance dashboard

## 🎨 Customization

### Adjust Health Reminder Timings
Edit `lua/config/plugins/developer-health.lua`:

```lua
-- Change reminder intervals (in milliseconds)
hydration_timer:start(1800000, 1800000, ...) -- 30 minutes
posture_timer:start(2700000, 2700000, ...)   -- 45 minutes
break_timer:start(3600000, 3600000, ...)     -- 60 minutes
eye_timer:start(1200000, 1200000, ...)       -- 20 minutes
```

### Modify Theme Auto-Switching
Edit `lua/config/plugins/developer-health.lua` in the theme switching function to adjust time thresholds.

### Change Notification Style
Edit `lua/config/plugins/notify.lua` to customize notification appearance and behavior.

## 📋 Daily Workflow

### Morning Routine
1. Open Neovim
2. Check health dashboard: `<leader>hd`
3. Restore session: `<leader>ss`
4. Start focus session: `<leader>hf`

### During Work
- Take breaks when reminded
- Use Copilot Chat for assistance: `<leader>ccp`
- Switch to zen mode for deep work: `<leader>z`
- Monitor performance: `<leader>pd`

### End of Day
1. Check health stats: `<leader>hd`
2. Log final break: `<leader>hb`
3. Session auto-saves on exit

## 🆘 Emergency Commands

If you ever get lost:

- `<F1>` - Complete cheatsheet
- `<leader>help` - Quick emergency help
- `<leader>?` - Full feature guide

## 🌟 Pro Tips

1. **Learn the health shortcuts first** - they're the most important for long sessions
2. **Customize reminder timings** to match your personal rhythm
3. **Use focus sessions** - they dramatically improve productivity
4. **Don't ignore break reminders** - they're scientifically designed for your wellbeing
5. **Keep the cheatsheet handy** - there are many features to discover

## 🔧 Advanced Configuration

For power users who want to dig deeper:

- `lua/config/cores/base-setup.lua` - Core Neovim settings
- `lua/config/cores/keymaps.lua` - All keybinding customizations
- `lua/config/plugins/` - Individual plugin configurations

## 📞 Support

If you run into issues:

1. Check `:checkhealth` for system issues
2. Use `:Lazy log` to see plugin installation logs  
3. Try `:Lazy restore` to reset to working state

Remember: This configuration is designed to help you code better and healthier. Take your time to learn it, and don't hesitate to customize it to your needs!

Happy coding! 💪🚀
