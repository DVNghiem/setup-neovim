-- ============================================================================
-- STREAMLINED KEYMAPS - World-Class Neovim Configuration
-- ============================================================================
-- Leader keys are set in init.lua before lazy loads

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- ============================================================================
-- ESSENTIAL MAPPINGS (No Conflicts)
-- ============================================================================

-- Quick exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode" })

-- Better line navigation
keymap.set({ "n", "v" }, "H", "^", { desc = "Go to line start" })
keymap.set({ "n", "v" }, "L", "$", { desc = "Go to line end" })

-- Enhanced movement (5 lines at a time)
keymap.set("n", "<A-j>", "5j", { desc = "Move down 5 lines" })
keymap.set("n", "<A-k>", "5k", { desc = "Move up 5 lines" })

-- Better scrolling (centered)
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
keymap.set("n", "n", "nzz", { desc = "Next search (centered)" })
keymap.set("n", "N", "Nzz", { desc = "Previous search (centered)" })

-- Window navigation (NO CONFLICTS with completion)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Quick save
keymap.set({ "n", "i" }, "<C-s>", "<ESC>:w<CR>", { desc = "Save file" })

-- ============================================================================
-- LEADER KEY GROUPS (Organized & Discoverable)
-- ============================================================================

-- FIND (Telescope) - <leader>f
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find text (grep)" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
keymap.set("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", { desc = "Find colorscheme" })
keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find word under cursor" })

-- Quick access (common operations)
keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })

-- LSP - <leader>l (Defined in lsp.lua on_attach)
-- la = code action, lr = rename, lf = format, ld = diagnostics, etc.

-- GIT - <leader>g
keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Git blame line" })
keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Git diff" })
keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
keymap.set("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })

-- BUFFERS - <leader>b
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Close other buffers" })

-- Quick buffer navigation
keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- WINDOWS - <leader>w
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Equal window size" })
keymap.set("n", "<leader>wq", "<cmd>close<cr>", { desc = "Close window" })
keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })

-- Window resizing
keymap.set("n", "<C-Left>", ":vertical resize -5<CR>", { desc = "Decrease width" })
keymap.set("n", "<C-Right>", ":vertical resize +5<CR>", { desc = "Increase width" })
keymap.set("n", "<C-Up>", ":resize +5<CR>", { desc = "Increase height" })
keymap.set("n", "<C-Down>", ":resize -5<CR>", { desc = "Decrease height" })

-- TOGGLES/TERMINAL - <leader>t
keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float terminal" })
keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Horizontal terminal" })
keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Vertical terminal" })
keymap.set("n", "<leader>tz", "<cmd>ZenMode<cr>", { desc = "Zen mode" })
keymap.set("n", "<leader>tw", function() vim.wo.wrap = not vim.wo.wrap end, { desc = "Toggle wrap" })

-- Terminal mode mappings
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal left window" })
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal down window" })
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal up window" })
keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal right window" })

-- CODE - <leader>c
keymap.set("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" })
keymap.set("n", "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Format buffer" })

-- DIAGNOSTICS/TROUBLE - <leader>x
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap.set("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols (Trouble)" })
keymap.set("n", "<leader>xl", "<cmd>Trouble lsp toggle<cr>", { desc = "LSP definitions/references" })
keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list" })

-- SEARCH/REPLACE - <leader>s
keymap.set("n", "<leader>sh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word under cursor" })
keymap.set("v", "<leader>sr", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace in selection" })

-- REFACTOR - <leader>r (if refactoring plugin is installed)
keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Extract function" })
keymap.set("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "Extract to file" })
keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "Extract variable" })
keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "Inline variable" })
keymap.set("n", "<leader>rI", ":Refactor inline_func", { desc = "Inline function" })
keymap.set("n", "<leader>rb", ":Refactor extract_block", { desc = "Extract block" })

-- ============================================================================
-- EDITING ENHANCEMENTS
-- ============================================================================

-- Better text editing
keymap.set("n", "x", '"_x', { desc = "Delete char without yank" })
keymap.set("v", "p", '"_dP', { desc = "Paste without yank" })
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Visual mode enhancements
keymap.set("v", "<", "<gv", { desc = "Indent left (keep selection)" })
keymap.set("v", ">", ">gv", { desc = "Indent right (keep selection)" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Quick duplicate
keymap.set("n", "<leader>dd", "yyp", { desc = "Duplicate line" })
keymap.set("v", "<leader>d", "y`>p", { desc = "Duplicate selection" })

-- Better undo/redo
keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Commenting (via comment plugin)
keymap.set("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
keymap.set("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Increment/decrement
keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })

-- ============================================================================
-- FILE EXPLORER
-- ============================================================================

keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

-- ============================================================================
-- TABS (Simplified)
-- ============================================================================

keymap.set("n", "<leader>to", "<cmd>tabnew<cr>", { desc = "New tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<cr>", { desc = "Next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<cr>", { desc = "Previous tab" })

-- ============================================================================
-- QUICKFIX/LOCATION LIST
-- ============================================================================

keymap.set("n", "[q", ":cprev<CR>", { desc = "Previous quickfix" })
keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })
keymap.set("n", "[l", ":lprev<CR>", { desc = "Previous location" })
keymap.set("n", "]l", ":lnext<CR>", { desc = "Next location" })

-- ============================================================================
-- HELP
-- ============================================================================

keymap.set("n", "<F1>", "<cmd>Cheatsheet<cr>", { desc = "Cheatsheet" })
keymap.set("n", "<leader>?", "<cmd>WhichKey<cr>", { desc = "Show all keymaps" })
