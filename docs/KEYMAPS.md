# Neovim Keymaps Documentation

> **Note**: Leader key is `<Space>` by default

## Table of Contents

- [Basic Navigation](#basic-navigation)
- [File Operations](#file-operations)
- [Window Management](#window-management)
- [Tab Management](#tab-management)
- [Buffer Management](#buffer-management)
- [Text Editing](#text-editing)
- [Search and Replace](#search-and-replace)
- [LSP (Language Server Protocol)](#lsp-language-server-protocol)
- [Code Actions and Refactoring](#code-actions-and-refactoring)
- [Diagnostics](#diagnostics)
- [Git Operations](#git-operations)
- [Telescope (Fuzzy Finder)](#telescope-fuzzy-finder)
- [Terminal](#terminal)
- [AI and Copilot](#ai-and-copilot)
- [UI Toggles](#ui-toggles)
- [Folding](#folding)
- [Miscellaneous](#miscellaneous)

---

## Basic Navigation

### Insert Mode Exit
| Key | Description |
|-----|-------------|
| `jk` / `JK` | Exit insert mode |
| `kj` | Exit insert mode |

### Movement
| Key | Mode | Description |
|-----|------|-------------|
| `<Alt-j>` | Normal | Move down 5 lines |
| `<Alt-k>` | Normal | Move up 5 lines |
| `H` | Normal/Visual | Go to beginning of line |
| `L` | Normal/Visual | Go to end of line |
| `<Left>` | Normal/Insert | Smart left navigation (moves to previous line end) |

### Scrolling
| Key | Description |
|-----|-------------|
| `<C-d>` | Scroll down and center |
| `<C-u>` | Scroll up and center |
| `n` | Next search result (centered) |
| `N` | Previous search result (centered) |

### Navigation Between Windows
| Key | Description |
|-----|-------------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to lower window |
| `<C-k>` | Move to upper window |
| `<C-l>` | Move to right window |

---

## File Operations

### Save
| Key | Mode | Description |
|-----|------|-------------|
| `<C-s>` | Normal/Insert | Save file |
| `<leader>w` | Normal | Save file |
| `<leader>wa` | Normal | Save all files |
| `<leader>W` | Normal | Save all files |
| `<C-w>s` | Normal | Save file (Ctrl+W+S) |
| `<C-w><C-w>` | Normal | Save file (Double Ctrl+W) |

### Quit
| Key | Description |
|-----|-------------|
| `<leader>q` | Quit current window |
| `<leader>qa` | Quit all |
| `<leader>wq` | Save and quit |
| `<leader>Q` | Force quit without saving |
| `<leader>QA` | Force quit all without saving |

### File Browser
| Key | Description |
|-----|-------------|
| `<leader>e` | Toggle Neo-tree file explorer |

---

## Window Management

### Split Windows
| Key | Description |
|-----|-------------|
| `<leader>sv` | Split window vertically |
| `<leader>sh` | Split window horizontally |
| `<leader>se` | Make splits equal size |
| `<leader>sx` | Close current split |
| `<leader>so` | Close all other windows |

### Resize Windows
| Key | Description |
|-----|-------------|
| `<C-Left>` | Resize window left (decrease width) |
| `<C-Right>` | Resize window right (increase width) |
| `<C-Up>` | Resize window up (increase height) |
| `<C-Down>` | Resize window down (decrease height) |

---

## Tab Management

| Key | Description |
|-----|-------------|
| `<leader>to` | Open new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Go to next tab |
| `<leader>tp` | Go to previous tab |
| `<leader>tf` | Open current buffer in new tab |
| `<Tab>` | Next tab |
| `<S-Tab>` | Previous tab |

---

## Buffer Management

### Navigation
| Key | Description |
|-----|-------------|
| `[b` | Previous buffer |
| `]b` | Next buffer |
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |

### Buffer Operations
| Key | Description |
|-----|-------------|
| `<leader>bd` | Pick and close buffer |
| `<leader>bD` | Close other buffers |
| `<leader>bo` | Close other buffers |
| `<leader>bl` | Close left buffers |
| `<leader>br` | Close right buffers |
| `<leader>bP` | Toggle pin buffer |
| `<leader>bb` | Cycle buffer border styles |

---

## Text Editing

### Basic Operations
| Key | Mode | Description |
|-----|------|-------------|
| `<C-a>` | Normal | Select all |
| `x` | Normal | Delete character without yanking |
| `dw` | Normal | Delete word backward |
| `p` | Visual | Paste without yanking |
| `U` | Normal | Redo |

### Increment/Decrement
| Key | Description |
|-----|-------------|
| `<leader>+` / `+` | Increment number |
| `<leader>-` / `-` | Decrement number |

### Duplication
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>d` | Normal | Duplicate current line |
| `<leader>d` | Visual | Duplicate selection |
| `<leader>dup` | Normal | Duplicate line |
| `<leader>dup` | Visual | Duplicate selection |

### Indentation
| Key | Mode | Description |
|-----|------|-------------|
| `<` | Visual | Indent left and keep selection |
| `>` | Visual | Indent right and keep selection |
| `<Tab>` | Visual | Indent right |
| `<S-Tab>` | Visual | Indent left |

### Move Lines
| Key | Mode | Description |
|-----|------|-------------|
| `J` | Visual | Move selection down |
| `K` | Visual | Move selection up |

### Commenting
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>/` | Normal | Toggle comment on current line |
| `<leader>/` | Visual | Toggle comment on selection |

---

## Search and Replace

### Search
| Key | Description |
|-----|-------------|
| `<leader>nh` | Clear search highlights |
| `<leader>/` | Search |
| `<C-f>` | Find text (Telescope live grep) |

### Replace
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>rw` | Normal | Replace word under cursor in file |
| `<leader>rv` | Visual | Replace in visual selection |

### Spectre (Advanced Replace)
| Key | Description |
|-----|-------------|
| `<leader>sr` | Replace in files (Spectre) |
| `<leader>sw` | Replace current word (Spectre) |
| `<leader>sp` | Replace in current file (Spectre) |

---

## LSP (Language Server Protocol)

### Navigation
| Key | Description |
|-----|-------------|
| `gD` | Go to declaration |
| `gd` | Go to definition |
| `gi` | Go to implementation |
| `gr` | Show references |
| `gt` | Go to type definition |
| `K` | Show hover information |
| `<C-k>` | Show signature help |

### Workspace
| Key | Description |
|-----|-------------|
| `<leader>wa` | Add workspace folder |
| `<leader>wr` | Remove workspace folder |
| `<leader>wl` | List workspace folders |

### Symbols
| Key | Description |
|-----|-------------|
| `<leader>so` | Toggle symbols outline |
| `<leader>cs` | Symbols (Trouble) |

---

## Code Actions and Refactoring

### LSP Code Actions
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ca` | Normal/Visual | See available code actions |
| `<leader>cr` | Normal | Smart rename |
| `<leader>cf` | Normal | Format code |

### Refactoring
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>re` | Visual | Refactor extract |
| `<leader>rf` | Visual | Refactor extract to file |
| `<leader>rv` | Visual | Refactor extract variable |
| `<leader>ri` | Normal/Visual | Refactor inline variable |
| `<leader>rI` | Normal | Refactor inline function |
| `<leader>rb` | Normal | Refactor extract block |
| `<leader>rbf` | Normal | Refactor extract block to file |

---

## Diagnostics

### Navigation
| Key | Description |
|-----|-------------|
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |
| `<leader>e` | Show line diagnostics |
| `<leader>dl` | Open diagnostics list |

### Trouble (Diagnostics Panel)
| Key | Description |
|-----|-------------|
| `<leader>xx` | Diagnostics (Trouble) |
| `<leader>xX` | Buffer Diagnostics (Trouble) |
| `<leader>cl` | LSP Definitions/references (Trouble) |
| `<leader>xL` | Location List (Trouble) |
| `<leader>xQ` | Quickfix List (Trouble) |

### List Navigation
| Key | Description |
|-----|-------------|
| `[q` | Previous quickfix |
| `]q` | Next quickfix |
| `[l` | Previous location list |
| `]l` | Next location list |

---

## Git Operations

### Gitsigns (Hunk Operations)
| Key | Mode | Description |
|-----|------|-------------|
| `]h` | Normal | Next hunk |
| `[h` | Normal | Previous hunk |
| `<leader>hs` | Normal/Visual | Stage hunk |
| `<leader>hr` | Normal/Visual | Reset hunk |
| `<leader>hS` | Normal | Stage buffer |
| `<leader>hR` | Normal | Reset buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Blame line (full) |
| `<leader>hB` | Normal | Toggle current line blame |
| `<leader>hd` | Normal | Diff this |
| `<leader>hD` | Normal | Diff this ~ |
| `ih` | Operator/Visual | Gitsigns select hunk |

### Git UI
| Key | Description |
|-----|-------------|
| `<leader>lg` | Open LazyGit |
| `<leader>gg` | Open Neogit |
| `<leader>gc` | Git Commit |
| `<leader>gp` | Git Push |
| `<leader>gl` | Git Pull |
| `<leader>gai` | Generate AI commit message |
| `<leader>gdo` | Open Diffview |
| `<leader>gdc` | Close Diffview |
| `<leader>gdh` | File history |

---

## Telescope (Fuzzy Finder)

### File Search
| Key | Description |
|-----|-------------|
| `<leader>ff` | Find files |
| `<C-p>` | Find files |
| `<leader>fr` | Find recent files |
| `<leader>fb` | Find buffers |
| `<leader>fd` | File browser |

### Text Search
| Key | Description |
|-----|-------------|
| `<leader>fg` | Find text (live grep) |
| `<C-f>` | Find text (live grep) |
| `<leader>fw` | Find word under cursor |

### Code Navigation
| Key | Description |
|-----|-------------|
| `<leader>fs` | Find symbols |
| `<leader>ft` | Find treesitter symbols |
| `<leader>fe` | Find diagnostics |

### Utilities
| Key | Description |
|-----|-------------|
| `<leader>fh` | Find help |
| `<leader>fc` | Find colorscheme |
| `<leader>fk` | Find keymaps |
| `<leader>fp` | Find projects |
| `<leader>fm` | Find marks |
| `<leader>fj` | Find jumplist |
| `<leader>fl` | Find location list |
| `<leader>fq` | Find quickfix |

---

## Terminal

### Toggle Terminal
| Key | Description |
|-----|-------------|
| `<leader>tt` | Toggle terminal |
| `<leader>tf` | Float terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |
| `<leader>tg` | LazyGit terminal |
| `<leader>tp` | Python terminal |
| `<leader>tn` | Node terminal |
| `<C-\>` | Toggle terminal |

### Terminal Mode
| Key | Description |
|-----|-------------|
| `<Esc>` | Exit terminal mode |
| `<C-w>h` | Terminal left window |
| `<C-w>j` | Terminal down window |
| `<C-w>k` | Terminal up window |
| `<C-w>l` | Terminal right window |

---

## AI and Copilot

### Copilot Chat
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ccp` | Normal | Toggle Copilot Chat |
| `<leader>ccx` | Normal | Reset Copilot Chat |
| `<leader>ccs` | Normal | Stop Copilot Chat |
| `<leader>ccq` | Normal | Quick chat |

### Quick Actions
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cce` | Normal/Visual | Explain code |
| `<leader>ccr` | Normal/Visual | Review code |
| `<leader>ccf` | Normal/Visual | Fix code |
| `<leader>cco` | Normal/Visual | Optimize code |
| `<leader>ccd` | Normal/Visual | Generate docs |
| `<leader>cct` | Normal/Visual | Generate tests |

### Code Improvement
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ccn` | Normal/Visual | Better variable names |
| `<leader>ccS` | Normal/Visual | Summarize code |
| `<leader>cci` | Normal/Visual | Simplify code |
| `<leader>ccC` | Normal/Visual | Make code concise |
| `<leader>ccE` | Normal/Visual | Ergonomic review |

### Documentation Generation (Neogen)
| Key | Description |
|-----|-------------|
| `<leader>ng` | Generate documentation |
| `<leader>nf` | Generate function docs |
| `<leader>nc` | Generate class docs |
| `<leader>nt` | Generate type docs |
| `<leader>nF` | Generate file docs |

---

## UI Toggles

### Transparency and Visual Effects
| Key | Description |
|-----|-------------|
| `<leader>tt` | Toggle transparency |
| `<leader>tc` | Clear UI transparency |
| `<leader>tb` | Toggle breadcrumb bar |
| `<leader>ti` | Toggle file info bar |
| `<leader>ub` | Toggle window transparency |
| `<leader>us` | Toggle smooth scrolling |
| `<leader>uc` | Toggle cursor line / Toggle cmdline height |
| `<leader>z` | Toggle Zen mode |

### Notifications
| Key | Description |
|-----|-------------|
| `<leader>nd` | Dismiss notifications |
| `<leader>nh` | Show notification history |
| `<leader>nl` | Show last notification |
| `<leader>na` | Show all notifications |

### Noice (UI Enhancement)
| Key | Mode | Description |
|-----|------|-------------|
| `<S-Enter>` | Command | Redirect cmdline |

---

## Folding

| Key | Description |
|-----|-------------|
| `<leader>fo` | Open fold |
| `<leader>fc` | Close fold |
| `<leader>fa` | Toggle fold |
| `<leader>fA` | Toggle all folds |

---

## Miscellaneous

### Session Management
| Key | Description |
|-----|-------------|
| Available via lazy-loading | Session persistence enabled |

### Health and Productivity
| Key | Description |
|-----|-------------|
| `<leader>br` | Health break reminder |

### Harpoon (Quick File Navigation)
| Key | Description |
|-----|-------------|
| `<leader>ha` | Add file to harpoon |
| `<leader>hh` | Toggle harpoon menu |
| `<leader>hn` | Go to next harpoon mark |

### Leap (Enhanced Navigation)
| Key | Mode | Description |
|-----|------|-------------|
| `gl` | Normal/Visual/Operator | Leap forward |
| `gL` | Normal/Visual/Operator | Leap backward |
| `gx` | Normal/Visual/Operator | Leap from window |

### Python Virtual Environment
| Key | Description |
|-----|-------------|
| Configured via venv-selector plugin | Virtual environment selection |

---

## Special Notes

### Leader Key
The leader key is set to `<Space>` (spacebar).

### Mode Indicators
- **Normal**: Default Vim mode for navigation and commands
- **Insert**: Text insertion mode
- **Visual**: Text selection mode
- **Command**: Command-line mode (`:`)
- **Terminal**: Terminal emulator mode

### Smart Features
- Auto-save functionality with `<C-s>` works in both normal and insert mode
- Smart left navigation moves to previous line end when at start of line
- Paste in visual mode doesn't yank the replaced text
- Center screen after scrolling and search navigation
- Window transparency and smooth scrolling can be toggled

### Plugin-Specific Keymaps
Many keymaps are provided by plugins and will only work when the respective plugin is loaded. The configuration uses lazy-loading for optimal performance.

---

## Quick Reference Card

### Most Used Commands
```
# Essential
<Space>     → Leader key
jk/kj       → Exit insert mode
<C-s>       → Save file
<C-p>       → Find files
<leader>e   → Toggle file explorer

# Navigation
gd          → Go to definition
gr          → Show references
K           → Show hover info
<C-h/j/k/l> → Navigate windows

# Git
<leader>gg  → Open Neogit
<leader>hs  → Stage hunk
<leader>hp  → Preview hunk

# Search
<C-f>       → Find text
<leader>sr  → Replace in files

# Code
<leader>ca  → Code actions
<leader>cr  → Rename
<leader>cf  → Format
```

---

**Last Updated**: 2025-11-09
**Configuration**: Neovim with Lazy.nvim plugin manager
