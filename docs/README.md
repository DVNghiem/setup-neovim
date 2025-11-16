# Neovim Configuration Documentation

> **Version 2.0** - November 2025 Release

Welcome to the documentation for this Neovim setup! This directory contains comprehensive guides for all keymaps and configurations.

## 📚 Documentation Files

### Keymaps Documentation

1. **[KEYMAPS.md](./KEYMAPS.md)** - Complete Keymap Reference
   - Comprehensive, categorized list of all keymaps
   - Organized by functionality (Navigation, LSP, Git, etc.)
   - Includes descriptions and mode information
   - Best for: Finding specific keymaps or browsing all available shortcuts

2. **[KEYMAPS_QUICK.md](./KEYMAPS_QUICK.md)** - Quick Reference Card
   - Condensed cheat sheet format
   - Essential commands only
   - Top 20 most-used commands
   - Best for: Daily reference, printing, or quick lookup

3. **[KEYMAPS_WORKFLOW.md](./KEYMAPS_WORKFLOW.md)** - Workflow-Oriented Guide
   - Organized by common development workflows
   - Includes learning path and daily usage examples
   - Power user tips and productivity tricks
   - Best for: Learning effective workflows and improving productivity

## 🚀 Quick Start

### For New Users
1. Start with [KEYMAPS_WORKFLOW.md](./KEYMAPS_WORKFLOW.md) - "Week 1: Basics"
2. Keep [KEYMAPS_QUICK.md](./KEYMAPS_QUICK.md) open for reference
3. Use `<Space>fk` in Neovim to search keymaps interactively

### For Experienced Users
- Jump to [KEYMAPS.md](./KEYMAPS.md) for complete reference
- Use the Table of Contents to find specific categories

## 🔑 Essential Commands

### Remember These First
```
<Space>         → Leader key (used in most commands)
jk / kj         → Exit insert mode
<C-s>           → Save file
<C-p>           → Find files
<Space>e        → Toggle file explorer
<Space>fk       → Find keymaps (interactive search!)
```

## 📖 Learning Resources

### Interactive Discovery
The best way to learn keymaps is through Neovim itself:
- **Find Keymaps**: `<Space>fk` - Search all keymaps with Telescope
- **Help Tags**: `<Space>fh` - Search Neovim help documentation
- **Cheatsheet**: Use a plugin like `cheatsheet.nvim` if installed

### Documentation Structure

```
docs/
├── README.md                 → This file (overview)
├── KEYMAPS.md               → Complete reference (alphabetical by category)
├── KEYMAPS_QUICK.md         → Quick reference card
└── KEYMAPS_WORKFLOW.md      → Workflow-based guide
```

## 🎯 Finding What You Need

### I want to...

**Learn Neovim from scratch**
→ Read [KEYMAPS_WORKFLOW.md](./KEYMAPS_WORKFLOW.md) - Follow the learning path

**Find a specific keymap**
→ Use `<Space>fk` in Neovim OR search [KEYMAPS.md](./KEYMAPS.md)

**Get a quick reference**
→ Print or bookmark [KEYMAPS_QUICK.md](./KEYMAPS_QUICK.md)

**Improve my workflow**
→ Check workflow sections in [KEYMAPS_WORKFLOW.md](./KEYMAPS_WORKFLOW.md)

**See all LSP commands**
→ Go to "LSP" section in [KEYMAPS.md](./KEYMAPS.md)

**Learn Git integration**
→ Check "Git Workflow" in [KEYMAPS_WORKFLOW.md](./KEYMAPS_WORKFLOW.md)

## 🔧 Configuration Files

The keymaps are defined in these configuration files:

- **Core Keymaps**: `lua/config/cores/keymaps.lua`
- **LSP Keymaps**: `lua/config/cores/lsp.lua`
- **Plugin Keymaps**: `lua/config/plugins/*.lua`

To modify keymaps, edit these files and restart Neovim or run `:source %`

## 💡 Pro Tips

### Customize Your Keymaps
All keymaps use descriptive `desc` fields, making them:
- Searchable with `<Space>fk`
- Discoverable through which-key (if installed)
- Self-documenting

### Print a Cheat Sheet
```bash
# From your config directory
cat docs/KEYMAPS_QUICK.md | pandoc -o keymaps.pdf
# Or just print the markdown file directly
```

### Create Your Own Quick Reference
Extract your most-used commands from these docs and create a personal cheat sheet!

## 🌟 Highlights

### Most Powerful Features

**AI Integration**
- Copilot Chat for code explanation, fixes, and generation
- AI-powered commit messages
- Documentation generation

**Git Workflow**
- Visual git interfaces (Neogit, LazyGit)
- Inline hunk preview and staging
- Diffview for comprehensive diffs

**LSP Features**
- Go to definition, references, implementation
- Code actions and refactoring
- Inline diagnostics and quick fixes

**Telescope Integration**
- Fuzzy finding for files, text, symbols
- Live grep with preview
- Integrated with git, LSP, and more

## 📊 Statistics

This configuration includes:
- **300+** keymaps across all plugins
- **20+** plugin integrations
- **10+** different workflows covered
- **4** documentation files for different use cases

## 🤝 Contributing

Found an error or want to improve the docs?
1. Edit the relevant file in `docs/`
2. Keep formatting consistent
3. Update all related documentation
4. Test keymaps before documenting

## 🔗 Related Files

- **[../README.md](../README.md)** - Main configuration README
- **[../SETUP.md](../SETUP.md)** - Setup instructions
- **[../STATUS.md](../STATUS.md)** - Configuration status
- **[../FIXES.md](../FIXES.md)** - Known issues and fixes

## ⚡ Quick Navigation

From Neovim:
```vim
:e ~/.config/nvim/docs/KEYMAPS.md
:e ~/.config/nvim/docs/KEYMAPS_QUICK.md
:e ~/.config/nvim/docs/KEYMAPS_WORKFLOW.md
```

Or use telescope:
```
<Space>ff  → Then type: docs/
```

---

**Last Updated**: November 16, 2025  
**Version**: 2.0  
**Neovim Version**: Compatible with 0.9+  
**Plugin Manager**: Lazy.nvim

**Happy Coding! 🚀**
