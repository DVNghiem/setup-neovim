# Neovim Keymaps Cheat Sheet
**Version 2.0** - Print-Friendly Reference Card | Leader: `<Space>`

---

## 🔥 Top 30 Essential Commands

| Key | Action | Key | Action |
|-----|--------|-----|--------|
| `jk`/`kj` | Exit insert | `<C-s>` | Save file |
| `<C-p>` | Find files | `<C-f>` | Search text |
| `<leader>e` | File tree | `<leader>gg` | Git UI |
| `gd` | Go to def | `gr` | References |
| `K` | Docs | `<leader>ca` | Code actions |
| `<leader>cr` | Rename | `<leader>cf` | Format |
| `<leader>/` | Comment | `<leader>hp` | Preview hunk |
| `[d` / `]d` | Diagnostics | `<leader>xx` | Error panel |
| `<S-h>` | Prev buffer | `<S-l>` | Next buffer |
| `<C-h/j/k/l>` | Navigate windows | `<leader>bd` | Close buffer |
| `<leader>sv` | Split V | `<leader>sh` | Split H |
| `<leader>tt` | Terminal | `<leader>z` | Zen mode |
| `<leader>ff` | Find files | `<leader>fb` | Buffers |
| `<leader>ccp` | AI Chat | `<leader>cce` | AI Explain |
| `<leader>hs` | Stage hunk | `<leader>hr` | Reset hunk |

---

## 📁 Files & Navigation

### Files
```
<C-p>           Find files          <leader>ff      Find files (alt)
<leader>fr      Recent files        <leader>e       Toggle tree
<C-s>           Save                <leader>w       Save (alt)
<leader>q       Quit                <leader>wq      Save & quit
```

### Navigation
```
gd              Definition          gr              References
gi              Implementation      gt              Type definition
K               Hover docs          <C-k>           Signature
<C-h/j/k/l>     Move windows        H/L             Start/End line
<C-d/u>         Scroll half page    [d / ]d         Diagnostics
```

---

## 💻 Code Editing

### LSP
```
<leader>ca      Code actions        <leader>cr      Rename
<leader>cf      Format              <leader>e       Show diagnostic
<leader>xx      Diagnostics panel   <leader>dl      Diagnostic list
```

### Text
```
<leader>/       Comment             <leader>d       Duplicate
gcc             Comment line        gc (visual)     Comment selection
J/K (visual)    Move up/down        </> (visual)    Indent
<C-a>           Select all          U               Redo
```

### Refactor
```
<leader>re      Extract             <leader>rv      Extract var
<leader>ri      Inline var          <leader>rf      Extract to file
```

---

## 🌿 Git

### Quick Actions
```
<leader>gg      Neogit              <leader>lg      LazyGit
<leader>hp      Preview hunk        <leader>hs      Stage hunk
<leader>hr      Reset hunk          <leader>hb      Blame line
[h / ]h         Prev/Next hunk      <leader>gai     AI commit
```

---

## 🔍 Search

### Find
```
<C-f>           Search text         <leader>fg      Live grep
<leader>fw      Word under cursor   <leader>fb      Buffers
<leader>fh      Help                <leader>fk      Keymaps
```

### Replace
```
<leader>sr      Replace in files    <leader>sw      Replace word
<leader>rw      Replace under cursor
```

---

## 🪟 Windows & Buffers

### Windows
```
<leader>sv      Split vertical      <leader>sh      Split horizontal
<leader>sx      Close split         <leader>se      Equal size
<C-Left/Right>  Resize width        <C-Up/Down>     Resize height
```

### Buffers
```
<S-h> / <S-l>   Prev/Next buffer    [b / ]b         Prev/Next (alt)
<leader>bd      Close buffer        <leader>bo      Close others
<leader>bP      Pin buffer
```

### Tabs
```
<Tab>           Next tab            <S-Tab>         Prev tab
<leader>to      New tab             <leader>tx      Close tab
```

---

## 🤖 AI & Copilot

```
<leader>ccp     Toggle chat         <leader>cce     Explain
<leader>ccf     Fix code            <leader>cco     Optimize
<leader>cct     Gen tests           <leader>ccd     Gen docs
<leader>ccr     Review              <leader>ccn     Better names
```

---

## 💬 Terminal

```
<leader>tt      Toggle              <leader>tf      Float
<leader>tg      LazyGit term        <Esc>           Exit term mode
```

---

## ⚡ Quick Moves

```
H               Line start          L               Line end
<Alt-j/k>       Move 5 lines        <C-d/u>         Half page
gl              Leap forward        gL              Leap backward
```

---

## 🎨 UI

```
<leader>z       Zen mode            <leader>nd      Dismiss notify
<leader>tt      Transparency        <leader>uc      Cursor line
```

---

## 📝 Folding

```
<leader>fo      Open fold           <leader>fc      Close fold
<leader>fa      Toggle fold         <leader>fA      Toggle all
```

---

## 🎯 My Daily Top 10

1. `<Space>e` - File tree
2. `<C-p>` - Find files  
3. `gd` - Go to definition
4. `<leader>ca` - Code actions
5. `<C-s>` - Save
6. `<leader>/` - Comment
7. `<leader>gg` - Git
8. `<S-h/l>` - Switch buffers
9. `<leader>xx` - Errors
10. `<C-f>` - Search text

---

## 💡 Pro Tips

- **Learn gradually**: Master 5-10 keymaps per week
- **Muscle memory**: Use `<Space>fk` to discover keymaps
- **Customize**: Edit `lua/config/cores/keymaps.lua`
- **Insert mode**: `jk` is faster than `<Esc>`
- **Save often**: `<C-s>` works in any mode

---

## 🆘 Help

```
<leader>fk      Search keymaps      <leader>fh      Help docs
:help           Vim help            :checkhealth    System check
```

---

**Print this page and keep it handy!**  
**More details**: `~/.config/nvim/docs/`

Last Updated: 2025-11-09
