-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = ","  -- Local leader for specialized functions

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Quick exit insert mode (essential for comfort)
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "JK", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })

-- Enhanced movement (crucial for long sessions) - using Alt keys to avoid conflicts
keymap.set('n', '<A-j>', '5j', { noremap = true, silent = true, desc = "Move down 5 lines" })
keymap.set('n', '<A-k>', '5k', { noremap = true, silent = true, desc = "Move up 5 lines" })

-- Better line navigation
keymap.set('n', 'H', '^', { desc = "Go to beginning of line" })
keymap.set('n', 'L', '$', { desc = "Go to end of line" })
keymap.set('v', 'H', '^', { desc = "Go to beginning of line" })
keymap.set('v', 'L', '$', { desc = "Go to end of line" })

-- Quick word movement
keymap.set('n', '<S-h>', 'b', { desc = "Previous word" })
keymap.set('n', '<S-l>', 'w', { desc = "Next word" })

-- Better scrolling
keymap.set('n', '<C-d>', '<C-d>zz', { desc = "Scroll down and center" })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = "Scroll up and center" })
keymap.set('n', 'n', 'nzz', { desc = "Next search result (centered)" })
keymap.set('n', 'N', 'Nzz', { desc = "Previous search result (centered)" })


-- Search and replace (enhanced)
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>/", function()
	require('telescope').extensions.live_grep_args.live_grep_args()
end, { desc = "🔍 Advanced search" })
keymap.set("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word under cursor" })
keymap.set("v", "<leader>r", ":s/", { desc = "Replace in selection" })

-- Advanced search patterns
keymap.set("n", "<leader>sc", "/\\c", { desc = "Case insensitive search" })
keymap.set("n", "<leader>sC", "/\\C", { desc = "Case sensitive search" })
keymap.set("n", "<leader>sw", "/\\<\\><Left><Left>", { desc = "Whole word search" })

-- Search utilities
keymap.set("n", "<leader>sl", ":set list!<CR>", { desc = "Toggle whitespace visibility" })
keymap.set("n", "<leader>sn", ":set number!<CR>", { desc = "Toggle line numbers" })
keymap.set("n", "<leader>sr", ":set relativenumber!<CR>", { desc = "Toggle relative numbers" })

-- Quick increment/decrement
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })

-- Enhanced window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>so", "<C-w>o", { desc = "Close all other windows" })

-- Smart window resizing
keymap.set("n", "<C-Left>", ":vertical resize -5<CR>", { desc = "Resize window left" })
keymap.set("n", "<C-Right>", ":vertical resize +5<CR>", { desc = "Resize window right" })
keymap.set("n", "<C-Up>", ":resize +5<CR>", { desc = "Resize window up" })
keymap.set("n", "<C-Down>", ":resize -5<CR>", { desc = "Resize window down" })

-- Enhanced tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
keymap.set("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Previous tab" })

-- Quick save and exit (essential for long sessions)
keymap.set("n", "<c-s>", ":w<cr>", { desc = "Save file" })
keymap.set("i", "<c-s>", "<ESC>:w<cr>", { desc = "Save file from insert mode" })
keymap.set("n", "<leader>w", ":w<cr>", { desc = "Save file" })
keymap.set("n", "<leader>wa", ":wa<cr>", { desc = "Save all files" })

-- Ctrl+W save functionality (with timeout to preserve window management)
-- In normal mode: Ctrl+W followed by 's' saves, otherwise falls back to window commands
keymap.set("n", "<C-w>s", ":w<cr>", { desc = "Save file (Ctrl+W+S)" })
-- Alternative: Double Ctrl+W to save (preserves single Ctrl+W for window management)
keymap.set("n", "<C-w><C-w>", ":w<cr>", { desc = "Save file (Double Ctrl+W)" })
-- In insert mode: Ctrl+W saves immediately
keymap.set("i", "<C-w>", "<ESC>:w<cr>a", { desc = "Save file from insert mode and continue editing" })

keymap.set("n", "<leader>q", ":q<cr>", { desc = "Quit" })
keymap.set("n", "<leader>qa", ":qa<cr>", { desc = "Quit all" })
keymap.set("n", "<leader>wq", ":wq<cr>", { desc = "Save and quit" })

-- Emergency exit
keymap.set("n", "<leader>Q", ":q!<cr>", { desc = "Force quit" })
keymap.set("n", "<leader>QA", ":qa!<cr>", { desc = "Force quit all" })

-- Smart line navigation
vim.api.nvim_set_keymap('n', '<Left>', [[col('.') == 1 ? '<Esc>k<S-a><Esc>' : '<Left>']], {expr = true, desc = "Smart left navigation"})
vim.api.nvim_set_keymap('i', '<Left>', [[col('.') == 1 ? '<Esc>k<S-a>' : '<Left>']], {expr = true, desc = "Smart left navigation in insert"})

-- Enhanced window navigation (optimized for long sessions)
keymap.set("n", "<c-k>", ":wincmd k<CR>", { noremap = true, silent = true, desc = "Move to upper window" })
keymap.set("n", "<c-j>", ":wincmd j<CR>", { noremap = true, silent = true, desc = "Move to lower window" })
keymap.set("n", "<c-h>", ":wincmd h<CR>", { noremap = true, silent = true, desc = "Move to left window" })
keymap.set("n", "<c-l>", ":wincmd l<CR>", { noremap = true, silent = true, desc = "Move to right window" })

-- Better text editing
keymap.set("n", 'dw', 'vb"_d', { desc = "Delete word backward" })
keymap.set('n', '<C-a>', 'gg<S-v>G', { desc = "Select all" })
keymap.set('n', 'x', '"_x', { desc = "Delete character without yanking" })
keymap.set('v', 'p', '"_dP', { desc = "Paste without yanking" })

-- Enhanced text manipulation
keymap.set('v', '<', '<gv', { desc = "Indent left and keep selection" })
keymap.set('v', '>', '>gv', { desc = "Indent right and keep selection" })
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Quick duplicate
keymap.set('n', '<leader>d', 'yyp', { desc = "Duplicate current line" })
keymap.set('v', '<leader>d', 'y`>p', { desc = "Duplicate selection" })

-- Better undo/redo
keymap.set('n', 'U', '<C-r>', { desc = "Redo" })

-- Quick commenting (if you don't have a comment plugin)
keymap.set('n', '<leader>/', 'gcc', { desc = "Toggle comment", remap = true })
keymap.set('v', '<leader>/', 'gc', { desc = "Toggle comment", remap = true })

-- Buffer management (essential for productivity)
keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = "Delete buffer" })
keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = "Next buffer" })
keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = "Previous buffer" })
keymap.set('n', '<leader>ba', ':%bd|e#<CR>', { desc = "Delete all buffers except current" })

-- Quick list navigation
keymap.set('n', '[q', ':cprev<CR>', { desc = "Previous quickfix" })
keymap.set('n', ']q', ':cnext<CR>', { desc = "Next quickfix" })
keymap.set('n', '[l', ':lprev<CR>', { desc = "Previous location list" })
keymap.set('n', ']l', ':lnext<CR>', { desc = "Next location list" })

-- Folding shortcuts
keymap.set('n', '<leader>fo', 'zo', { desc = "Open fold" })
keymap.set('n', '<leader>fc', 'zc', { desc = "Close fold" })
keymap.set('n', '<leader>fa', 'za', { desc = "Toggle fold" })
keymap.set('n', '<leader>fA', 'zA', { desc = "Toggle all folds" })

-- Health and productivity shortcuts
keymap.set('n', '<leader>br', function()
    vim.notify("🧘 Take a deep breath! Stretch your fingers and neck.", vim.log.levels.INFO, { title = "Quick Break" })
end, { desc = "Health break reminder" })

-- Focus mode toggle
keymap.set('n', '<leader>z', ':ZenMode<CR>', { desc = "Toggle zen mode" })

-- Terminal shortcuts
keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { desc = "Toggle terminal" })
keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = "Exit terminal mode" })
keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h', { desc = "Terminal left window" })
keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j', { desc = "Terminal down window" })
keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k', { desc = "Terminal up window" })
keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l', { desc = "Terminal right window" })

-- telescope - Enhanced search functionality
local builtin = require('telescope.builtin')

-- Core search functions
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "🔍 Find files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "🔍 Live grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "🔍 Find buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "🔍 Help tags" })

-- Advanced search functions
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = "🔍 Find word under cursor" })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "🔍 Find recent files" })
vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = "🔍 Find commands" })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "🔍 Find keymaps" })
vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = "🔍 Find registers" })
vim.keymap.set('n', '<leader>ft', builtin.tags, { desc = "🔍 Find tags" })
vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = "🔍 Find quickfix" })
vim.keymap.set('n', '<leader>fl', builtin.loclist, { desc = "🔍 Find loclist" })

-- Git search
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = "🔍 Find git files" })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "🔍 Git commits" })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "🔍 Git branches" })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "🔍 Git status" })

-- LSP search
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = "🔍 LSP definitions" })
vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = "🔍 LSP references" })
vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = "🔍 LSP implementations" })
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = "🔍 Document symbols" })
vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = "🔍 Workspace symbols" })

-- File browser
vim.keymap.set('n', '<leader>fe', ':Telescope file_browser<CR>', { desc = "🔍 File browser" })
vim.keymap.set('n', '<leader>fE', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { desc = "🔍 File browser (current dir)" })

-- Live grep with args (VS Code-like search)
vim.keymap.set('n', '<leader>/', ':Telescope live_grep_args<CR>', { desc = "🔍 Advanced live grep" })
vim.keymap.set('v', '<leader>/', function()
	local text = vim.getVisualSelection()
	require('telescope').extensions.live_grep_args.live_grep_args({ default_text = text })
end, { desc = "🔍 Search selected text" })

-- Search in current buffer
vim.keymap.set('n', '<leader>s/', builtin.current_buffer_fuzzy_find, { desc = "🔍 Search in current buffer" })

-- Resume last search
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = "🔍 Resume last search" })

-- go to each character
vim.keymap.set('i', '<c-l>', '<Esc>la', { noremap = true })
vim.keymap.set('i', '<c-h>', '<Esc>ha', { noremap = true })


-- tab and shift tab 
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true })

-- bufferline
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd | bnext<CR>', { noremap = true, silent = true })

-- neo tree toggle
-- open/close neo tree
vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })

-- Quick find and replace in current file
vim.keymap.set("n", "<leader>rr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "Replace word under cursor in file" })
vim.keymap.set("v", "<leader>rr", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "Replace selected text in selection" })

-- reafactor
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
vim.keymap.set( "n", "<leader>rI", ":Refactor inline_func")
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- twilight toggle
vim.keymap.set('n', '<leader>tw', ':Twilight<CR>', { noremap = true, silent = true })

-- zen mode
vim.keymap.set('n', '<leader>z', ':ZenMode<CR>', { noremap = true, silent = true })

-- Smooth UI and transparency controls
vim.keymap.set("n", "<leader>tt", function()
  require("transparent").toggle()
  print("🎨 Transparency toggled!")
end, { desc = "Toggle transparency", silent = true })

vim.keymap.set("n", "<leader>tc", function()
  require("transparent").clear_prefix("BufferLine")
  require("transparent").clear_prefix("NeoTree")
  print("🎨 UI transparency cleared!")
end, { desc = "Clear UI transparency", silent = true })

-- Enhanced smooth scrolling keymaps (already handled by neoscroll)
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })

-- Enhanced title bar and navigation
vim.keymap.set("n", "<leader>tb", function()
  require("barbecue.ui").toggle()
  print("🍖 Breadcrumb navigation toggled!")
end, { desc = "Toggle breadcrumb bar", silent = true })

vim.keymap.set("n", "<leader>ti", function()
  require("incline").toggle()
  print("📊 File info bar toggled!")
end, { desc = "Toggle file info bar", silent = true })

-- Enhanced buffer navigation with smooth animations
vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer (smooth)" })
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer (smooth)" })
vim.keymap.set("n", "<leader>bd", "<cmd>BufferLinePickClose<cr>", { desc = "Pick close buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })

-- Smooth interface controls
vim.keymap.set("n", "<leader>ub", function()
  vim.o.winblend = vim.o.winblend == 0 and 15 or 0
  vim.o.pumblend = vim.o.pumblend == 0 and 15 or 0
  print("🌊 Window transparency: " .. (vim.o.winblend == 0 and "OFF" or "ON"))
end, { desc = "Toggle window transparency", silent = true })

vim.keymap.set("n", "<leader>us", function()
  vim.o.smoothscroll = not vim.o.smoothscroll
  print("🌊 Smooth scrolling: " .. (vim.o.smoothscroll and "ON" or "OFF"))
end, { desc = "Toggle smooth scrolling", silent = true })

vim.keymap.set("n", "<leader>uc", function()
  vim.o.cursorline = not vim.o.cursorline
  print("🌊 Cursor line: " .. (vim.o.cursorline and "ON" or "OFF"))
end, { desc = "Toggle cursor line", silent = true })

-- Smooth buffer border styling
vim.keymap.set("n", "<leader>bb", function()
  local bufferline = require("bufferline")
  local current_style = bufferline.get_config().options.separator_style
  local styles = { "slope", "slant", "padded_slant", "thick", "thin" }
  local current_index = 1
  for i, style in ipairs(styles) do
    if style == current_style then
      current_index = i
      break
    end
  end
  local next_style = styles[(current_index % #styles) + 1]
  bufferline.setup({ options = { separator_style = next_style } })
  print("🎨 Buffer style: " .. next_style)
end, { desc = "Cycle buffer border styles", silent = true })

-- Enhanced search utilities (VS Code-like)
local search_utils = require('config.utils.search-utils')

-- Search option toggles
keymap.set("n", "<leader>stc", search_utils.toggle_case_sensitive, { desc = "🔍 Toggle case sensitive" })
keymap.set("n", "<leader>stw", search_utils.toggle_whole_word, { desc = "🔍 Toggle whole word" })
keymap.set("n", "<leader>str", search_utils.toggle_regex, { desc = "🔍 Toggle regex" })
keymap.set("n", "<leader>sth", search_utils.toggle_hidden, { desc = "🔍 Toggle hidden files" })
keymap.set("n", "<leader>sti", search_utils.toggle_gitignore, { desc = "🔍 Toggle gitignore" })
keymap.set("n", "<leader>sts", search_utils.show_search_status, { desc = "🔍 Show search status" })

-- Enhanced search functions
keymap.set("n", "<leader>sg", search_utils.live_grep_with_options, { desc = "🔍 Live grep (with options)" })
keymap.set("n", "<leader>sG", search_utils.grep_string_with_options, { desc = "🔍 Grep string (with options)" })

-- File type specific searches
keymap.set("n", "<leader>sfl", function() search_utils.search_in_filetype("lua") end, { desc = "🔍 Search Lua files" })
keymap.set("n", "<leader>sfp", function() search_utils.search_in_filetype("python") end, { desc = "🔍 Search Python files" })
keymap.set("n", "<leader>sfj", function() search_utils.search_in_filetype("javascript") end, { desc = "🔍 Search JS/TS files" })
keymap.set("n", "<leader>sfg", function() search_utils.search_in_filetype("go") end, { desc = "🔍 Search Go files" })
keymap.set("n", "<leader>sfr", function() search_utils.search_in_filetype("rust") end, { desc = "🔍 Search Rust files" })
keymap.set("n", "<leader>sfc", function() search_utils.search_in_filetype("cpp") end, { desc = "🔍 Search C/C++ files" })
keymap.set("n", "<leader>sfh", function() search_utils.search_in_filetype("html") end, { desc = "🔍 Search HTML files" })
keymap.set("n", "<leader>sfs", function() search_utils.search_in_filetype("css") end, { desc = "🔍 Search CSS files" })
keymap.set("n", "<leader>sfm", function() search_utils.search_in_filetype("markdown") end, { desc = "🔍 Search Markdown files" })

-- Exclude common directories from search
keymap.set("n", "<leader>sx", function() 
	search_utils.search_with_exclude({"node_modules/*", ".git/*", "dist/*", "build/*", "*.log", "*.cache"})
end, { desc = "🔍 Search (exclude common dirs)" })

-- Search shortcuts that mimic VS Code
keymap.set("n", "<C-f>", function()
	vim.cmd("normal! /")
end, { desc = "🔍 Search in buffer" })

keymap.set("n", "<C-S-f>", function()
	search_utils.live_grep_with_options()
end, { desc = "🔍 Search in workspace" })

keymap.set("n", "<C-h>", function()
	vim.cmd(":%s//")
	vim.cmd("startinsert")
end, { desc = "🔄 Find and replace in buffer" })

keymap.set("n", "<C-S-h>", function()
	require("spectre").open()
end, { desc = "🔄 Find and replace in workspace" })

