# Neovim Keymaps Quick Reference

> **Leader key**: `<Space>`

## Essential Commands

| Category | Key | Action |
|----------|-----|--------|
| **Exit Insert** | `jk` / `kj` | Back to normal mode |
| **Save** | `<C-s>` | Save current file |
| **Files** | `<C-p>` | Find files |
| **Files** | `<leader>e` | Toggle file tree |
| **Search** | `<C-f>` | Find text in project |
| **Quit** | `<leader>q` | Quit |

## Navigation

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between windows |
| `<S-h/l>` | Previous/Next buffer |
| `gd` | Go to definition |
| `gr` | Show references |
| `gi` | Go to implementation |
| `K` | Show documentation |
| `[d` / `]d` | Previous/Next diagnostic |
| `[h` / `]h` | Previous/Next git hunk |

## Window & Buffer Management

| Key | Action |
|-----|--------|
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<leader>sx` | Close split |
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Close other buffers |

## Code Editing

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ca` | Normal/Visual | Code actions |
| `<leader>cr` | Normal | Rename symbol |
| `<leader>cf` | Normal | Format code |
| `<leader>/` | Normal/Visual | Toggle comment |
| `<leader>d` | Normal/Visual | Duplicate line/selection |
| `gcc` | Normal | Comment line |
| `gc` | Visual | Comment selection |

## LSP & Diagnostics

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle diagnostics panel |
| `<leader>e` | Show line diagnostics |
| `<leader>dl` | Diagnostics list |
| `<leader>ca` | Code actions |

## Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Open Neogit |
| `<leader>lg` | Open LazyGit |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>gai` | AI commit message |

## Telescope (Search)

| Key | Action |
|-----|--------|
| `<leader>ff` / `<C-p>` | Find files |
| `<leader>fg` / `<C-f>` | Find text |
| `<leader>fb` | Find buffers |
| `<leader>fr` | Recent files |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |

## AI / Copilot

| Key | Action |
|-----|--------|
| `<leader>ccp` | Toggle Copilot Chat |
| `<leader>cce` | Explain code |
| `<leader>ccf` | Fix code |
| `<leader>cco` | Optimize code |
| `<leader>cct` | Generate tests |
| `<leader>ccd` | Generate docs |

## Terminal

| Key | Action |
|-----|--------|
| `<leader>tt` | Toggle terminal |
| `<leader>tf` | Float terminal |
| `<leader>tg` | LazyGit terminal |
| `<Esc>` | Exit terminal mode |

## Text Manipulation

| Key | Mode | Action |
|-----|------|--------|
| `J` / `K` | Visual | Move selection down/up |
| `<` / `>` | Visual | Indent left/right |
| `<C-a>` | Normal | Select all |
| `U` | Normal | Redo |
| `p` | Visual | Paste without yank |

## Refactoring

| Key | Mode | Action |
|-----|------|--------|
| `<leader>re` | Visual | Extract |
| `<leader>rf` | Visual | Extract to file |
| `<leader>rv` | Visual | Extract variable |
| `<leader>ri` | Normal/Visual | Inline variable |

## UI Toggles

| Key | Action |
|-----|--------|
| `<leader>z` | Zen mode |
| `<leader>tt` | Toggle transparency |
| `<leader>nd` | Dismiss notifications |

## Movement Shortcuts

| Key | Action |
|-----|--------|
| `H` | Start of line |
| `L` | End of line |
| `<C-d>` | Scroll down (centered) |
| `<C-u>` | Scroll up (centered) |
| `<Alt-j>` | Move down 5 lines |
| `<Alt-k>` | Move up 5 lines |

## Tab Management

| Key | Action |
|-----|--------|
| `<Tab>` | Next tab |
| `<S-Tab>` | Previous tab |
| `<leader>to` | New tab |
| `<leader>tx` | Close tab |

## Cheat Sheet

### My Top 20 Commands
1. `<Space>e` - File explorer
2. `<C-p>` - Find files
3. `<C-f>` - Search text
4. `<C-s>` - Save
5. `gd` - Go to definition
6. `<leader>ca` - Code actions
7. `<leader>cr` - Rename
8. `<leader>ff` - Format
9. `<leader>/` - Comment
10. `<leader>gg` - Git UI
11. `<S-h>` / `<S-l>` - Switch buffers
12. `<leader>xx` - Show errors
13. `K` - Documentation
14. `<leader>ccp` - AI Chat
15. `<leader>bd` - Close buffer
16. `<leader>sr` - Replace in files
17. `<leader>hp` - Preview git hunk
18. `[d` / `]d` - Jump diagnostics
19. `<leader>tt` - Terminal
20. `<leader>z` - Zen mode

---

**Tip**: Press `<leader>fk` to search keymaps interactively!
