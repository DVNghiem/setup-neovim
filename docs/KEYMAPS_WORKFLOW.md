# Neovim Keymaps by Workflow

> Organized by common development workflows and tasks

## 🚀 Getting Started

### First Time Setup
```
Leader key: <Space>
To find any keymap: <leader>fk (Telescope keymaps search)
To see this help: Open this file!
```

---

## 📁 File & Project Management

### Opening Files
```
<C-p>           → Quick file finder (Telescope)
<leader>ff      → Find files
<leader>fr      → Recent files
<leader>fb      → Find in open buffers
<leader>e       → Toggle file explorer (Neo-tree)
<leader>fp      → Switch projects
```

### Saving & Quitting
```
<C-s>           → Save (works in insert/normal mode)
<leader>w       → Save file
<leader>wa      → Save all files
<leader>q       → Quit
<leader>wq      → Save and quit
<leader>Q       → Force quit (no save)
```

---

## 🔍 Searching & Finding

### Text Search
```
<C-f>           → Search text in project (live grep)
<leader>fg      → Find text (Telescope)
<leader>fw      → Find word under cursor
<leader>/       → Start search
<leader>nh      → Clear search highlights
```

### Advanced Replace
```
<leader>sr      → Replace in files (Spectre)
<leader>sw      → Replace current word
<leader>sp      → Replace in current file
<leader>rw      → Replace word under cursor
```

### Code Search
```
<leader>fs      → Find symbols
<leader>ft      → Find treesitter symbols
<leader>fe      → Find diagnostics/errors
<leader>fh      → Find help/documentation
```

---

## 💻 Code Navigation

### Jump to Definition/References
```
gd              → Go to definition
gD              → Go to declaration
gi              → Go to implementation
gr              → Show references
gt              → Go to type definition
K               → Show hover documentation
<C-k>           → Signature help
```

### Navigate Diagnostics
```
[d              → Previous diagnostic
]d              → Next diagnostic
<leader>e       → Show line diagnostics
<leader>dl      → Diagnostics list
<leader>xx      → Toggle diagnostics panel (Trouble)
<leader>xX      → Buffer diagnostics
```

### Symbol Navigation
```
<leader>so      → Toggle symbols outline
<leader>cs      → Symbols in Trouble panel
```

---

## ✏️ Code Editing

### Smart Editing
```
<leader>ca      → Code actions (quick fixes)
<leader>cr      → Rename symbol
<leader>cf      → Format code
<leader>fm      → Format with conform.nvim
```

### Comments
```
<leader>/       → Toggle comment (line/selection)
gcc             → Comment line
gc              → Comment selection (visual mode)
```

### Refactoring
```
<leader>re      → Extract (visual)
<leader>rf      → Extract to file (visual)
<leader>rv      → Extract variable (visual)
<leader>ri      → Inline variable
<leader>rI      → Inline function
<leader>rb      → Extract block
```

### Text Manipulation
```
<leader>d       → Duplicate line/selection
<leader>dup     → Duplicate
<C-a>           → Select all
U               → Redo
dd              → Delete line
x               → Delete char (no yank)
p (visual)      → Paste without yanking
```

### Moving Code
```
J (visual)      → Move selection down
K (visual)      → Move selection up
< (visual)      → Indent left
> (visual)      → Indent right
```

---

## 🤖 AI & Documentation

### Copilot Chat
```
<leader>ccp     → Toggle Copilot Chat
<leader>ccq     → Quick chat
<leader>cce     → Explain code
<leader>ccf     → Fix code
<leader>cco     → Optimize code
<leader>ccr     → Review code
<leader>cct     → Generate tests
<leader>ccd     → Generate docs
<leader>ccn     → Better variable names
<leader>cci     → Simplify code
```

### Auto Documentation (Neogen)
```
<leader>ng      → Generate documentation
<leader>nf      → Generate function docs
<leader>nc      → Generate class docs
<leader>nt      → Generate type docs
```

---

## 🌿 Git Workflow

### Git UI
```
<leader>gg      → Open Neogit (Git UI)
<leader>lg      → Open LazyGit
<leader>gc      → Git commit
<leader>gp      → Git push
<leader>gl      → Git pull
<leader>gai     → Generate AI commit message
```

### Hunk Operations
```
]h              → Next hunk
[h              → Previous hunk
<leader>hs      → Stage hunk
<leader>hr      → Reset hunk
<leader>hS      → Stage buffer
<leader>hR      → Reset buffer
<leader>hu      → Undo stage hunk
<leader>hp      → Preview hunk
```

### Diff & Blame
```
<leader>hb      → Blame line (full)
<leader>hB      → Toggle line blame
<leader>hd      → Diff this
<leader>gdo     → Open Diffview
<leader>gdc     → Close Diffview
<leader>gdh     → File history
```

---

## 📋 Window & Buffer Management

### Windows
```
<C-h/j/k/l>     → Navigate between windows
<leader>sv      → Split vertical
<leader>sh      → Split horizontal
<leader>se      → Equal size splits
<leader>sx      → Close split
<leader>so      → Close other windows
```

### Resize Windows
```
<C-Left>        → Decrease width
<C-Right>       → Increase width
<C-Up>          → Increase height
<C-Down>        → Decrease height
```

### Buffers
```
<S-h>           → Previous buffer
<S-l>           → Next buffer
[b              → Previous buffer
]b              → Next buffer
<leader>bd      → Delete buffer
<leader>bo      → Close other buffers
<leader>bP      → Pin/unpin buffer
```

### Tabs
```
<Tab>           → Next tab
<S-Tab>         → Previous tab
<leader>to      → New tab
<leader>tx      → Close tab
<leader>tn/tp   → Next/Previous tab
```

---

## 💬 Terminal & Commands

### Terminal
```
<leader>tt      → Toggle terminal
<leader>tf      → Float terminal
<leader>th      → Horizontal terminal
<leader>tv      → Vertical terminal
<leader>tg      → LazyGit in terminal
<Esc>           → Exit terminal mode
```

### Quick Commands
```
:               → Command mode
<leader>fk      → Find keymaps
<leader>fh      → Find help
```

---

## 🎨 UI & Visual

### Toggles
```
<leader>z       → Zen mode (distraction-free)
<leader>tt      → Toggle transparency
<leader>ub      → Window transparency
<leader>uc      → Cursor line / cmdline
<leader>nd      → Dismiss notifications
<leader>nh      → Notification history
```

### Visual Effects
```
<leader>tb      → Toggle breadcrumb bar
<leader>ti      → Toggle file info bar
<leader>bb      → Cycle buffer styles
```

---

## ⚡ Quick Movement

### Faster Navigation
```
H               → Beginning of line
L               → End of line
<Alt-j>         → Move down 5 lines
<Alt-k>         → Move up 5 lines
<C-d>           → Scroll down (centered)
<C-u>           → Scroll up (centered)
n/N             → Next/prev search (centered)
```

### Leap (Jump to any location)
```
gl              → Leap forward
gL              → Leap backward
gx              → Leap from window
```

### Quick Lists
```
[q / ]q         → Previous/Next quickfix
[l / ]l         → Previous/Next location
```

---

## 🔥 Power User Tips

### Essential Insert Mode
```
jk / kj / JK    → Exit insert mode (faster than ESC)
<C-s>           → Save and stay in insert mode
```

### Number Operations
```
+ / -           → Increment/decrement number
<leader>+ / -   → Same as above
```

### Folding
```
<leader>fo      → Open fold
<leader>fc      → Close fold
<leader>fa      → Toggle fold
```

### Health & Breaks
```
<leader>br      → Health break reminder
```

---

## 🎯 My Daily Workflow

### Morning Startup
```
1. <Space>e          → Open file tree
2. <Space>fp         → Switch to project
3. <C-p>             → Open file
4. <Space>gg         → Check git status
```

### Coding Session
```
1. gd                → Navigate to code
2. K                 → Read docs
3. <Space>ca         → Quick fixes
4. <Space>/          → Comment code
5. <C-s>             → Save often
```

### Git Commit
```
1. <Space>hp         → Preview changes
2. <Space>hs         → Stage hunks
3. <Space>gai        → Generate commit message
4. <Space>gg         → Open Neogit
5. Commit & push
```

### Code Review
```
1. <Space>xx         → Check diagnostics
2. <Space>ccr        → AI review
3. <Space>cf         → Format
4. <Space>wa         → Save all
```

### Finding Issues
```
1. <C-f>             → Search error message
2. <Space>fe         → Find all diagnostics
3. [d / ]d           → Jump through errors
4. <Space>ca         → Apply fixes
```

---

## 📖 Learning Path

### Week 1: Basics
- Master: `jk`, `<C-s>`, `<C-p>`, `<Space>e`
- Learn: Window navigation (`<C-h/j/k/l>`)
- Practice: Buffer switching (`<S-h>`, `<S-l>`)

### Week 2: Code Navigation
- Master: `gd`, `gr`, `K`
- Learn: `[d`, `]d`, `<Space>xx`
- Practice: `<Space>ca`, `<Space>cr`

### Week 3: Git & Search
- Master: `<Space>gg`, `<Space>hp`, `<Space>hs`
- Learn: `<C-f>`, `<Space>sr`
- Practice: `<Space>gai`

### Week 4: AI & Advanced
- Master: `<Space>ccp`, `<Space>cce`
- Learn: Refactoring keymaps
- Practice: Custom workflows

---

**Pro Tip**: Don't try to learn all keymaps at once! Focus on one workflow at a time.

**Remember**: Press `<Space>fk` anytime to search for keymaps interactively!
