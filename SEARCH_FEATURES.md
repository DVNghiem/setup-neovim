# Enhanced Search Features - VS Code Style

This configuration has been optimized to provide a VS Code-like search experience with the following features:

## 🔍 Key Search Improvements

### 1. Advanced Search & Replace
- **Spectre**: Enhanced find/replace with visual interface
- **Grug-Far**: Advanced search/replace panel similar to VS Code
- **Search-Replace**: Quick find/replace functionality

### 2. VS Code-like Search Options
- **Case Sensitivity Toggle**: `<leader>stc`
- **Whole Word Search**: `<leader>stw` 
- **Regex Search**: `<leader>str`
- **Include Hidden Files**: `<leader>sth`
- **Include Gitignore Files**: `<leader>sti`
- **Search Status Display**: `<leader>sts`

### 3. Enhanced Telescope Integration
- **Live Grep with Arguments**: Advanced search with options
- **File Type Specific Search**: Search within specific languages
- **File Browser Integration**: Enhanced file navigation
- **Better Layout**: VS Code-like layout and styling

### 4. Quick Search Shortcuts (VS Code Style)
- `<Ctrl-f>`: Search in current buffer
- `<Ctrl-Shift-f>`: Search in entire workspace
- `<Ctrl-h>`: Find and replace in buffer
- `<Ctrl-Shift-h>`: Find and replace in workspace

## 🎯 Search Keymaps

### Core Search Functions
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fw` - Find word under cursor
- `<leader>fo` - Find recent files
- `<leader>/` - Advanced live grep with options

### Search Options (VS Code-like toggles)
- `<leader>stc` - Toggle case sensitivity
- `<leader>stw` - Toggle whole word matching
- `<leader>str` - Toggle regex mode
- `<leader>sth` - Toggle hidden files
- `<leader>sti` - Toggle gitignore files
- `<leader>sts` - Show current search status

### File Type Specific Search
- `<leader>sfl` - Search Lua files
- `<leader>sfp` - Search Python files  
- `<leader>sfj` - Search JavaScript/TypeScript files
- `<leader>sfg` - Search Go files
- `<leader>sfr` - Search Rust files
- `<leader>sfc` - Search C/C++ files
- `<leader>sfh` - Search HTML files
- `<leader>sfs` - Search CSS files
- `<leader>sfm` - Search Markdown files

### Advanced Search & Replace
- `<leader>sr` - Open Spectre (project-wide search/replace)
- `<leader>sw` - Search current word with Spectre
- `<leader>sp` - Search in current file with Spectre
- `<leader>sf` - Open Grug-Far (advanced search UI)
- `<leader>sb` - Search box (incremental)
- `<leader>sR` - Search & replace box

### Git Integration
- `<leader>gf` - Find git files
- `<leader>gc` - Git commits
- `<leader>gb` - Git branches
- `<leader>gs` - Git status

### LSP Integration
- `<leader>ld` - LSP definitions
- `<leader>lr` - LSP references
- `<leader>li` - LSP implementations
- `<leader>ls` - Document symbols
- `<leader>lw` - Workspace symbols

## 🛠️ Enhanced Features

### 1. Smart Search Configuration
- Automatically adjusts search parameters based on toggles
- Visual status indicators for current search mode
- Context-aware search suggestions

### 2. Better UI/UX
- VS Code-like layout with preview panes
- Proper file icons and syntax highlighting
- Smooth animations and transitions

### 3. Performance Optimizations
- Fast ripgrep integration
- Efficient file filtering
- Smart caching for recent searches

### 4. Search Panel Features
- Include/exclude file patterns
- Advanced regex support  
- Multi-line search and replace
- Search history

## 📋 Available Commands

- `:SearchToggleCase` - Toggle case sensitivity
- `:SearchToggleWord` - Toggle whole word matching
- `:SearchToggleRegex` - Toggle regex mode
- `:SearchToggleHidden` - Toggle hidden files
- `:SearchToggleIgnore` - Toggle gitignore files
- `:SearchStatus` - Show current search configuration
- `:SearchInFiles <filetype>` - Search in specific file types

## 🎨 Visual Indicators

The search status is displayed in the format: `🔍[options]`
- `Aa` - Case sensitive / `aa` - Case insensitive
- `W` - Whole word matching
- `.*` - Regex mode enabled
- `H` - Include hidden files
- `I` - Include gitignore files

## 🚀 Usage Tips

1. **Quick Search**: Use `<Ctrl-Shift-f>` for instant workspace search
2. **File Type Search**: Use `<leader>sf<filetype>` for targeted searches
3. **Advanced Replace**: Use `<leader>sf` for complex find/replace operations
4. **Toggle Options**: Change search behavior with `<leader>st<option>`
5. **Visual Search**: Select text and use `<leader>/` to search for it

This configuration provides a comprehensive search experience that rivals VS Code's search functionality while maintaining the power and flexibility of Neovim.
