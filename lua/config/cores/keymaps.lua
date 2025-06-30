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
keymap.set("n", "<leader>/", ":/", { desc = "Search" })
keymap.set("n", "<leader>rw", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Replace word under cursor" })
keymap.set("v", "<leader>r", ":s/", { desc = "Replace in selection" })

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

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

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

-- Ultimate IDE Feature Keymaps
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- Enhanced LSP Keymaps for Ultimate IDE Experience
keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })
keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })

-- Code Actions and Refactoring
keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" })
keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Smart rename" })
keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format code" })

-- Diagnostics Navigation
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Symbols Outline
keymap.set("n", "<leader>so", "<cmd>SymbolsOutline<cr>", { desc = "Toggle symbols outline" })

-- Git Workflow Enhancement
keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
keymap.set("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = "Git commit" })
keymap.set("n", "<leader>gp", "<cmd>Neogit push<cr>", { desc = "Git push" })
keymap.set("n", "<leader>gl", "<cmd>Neogit pull<cr>", { desc = "Git pull" })
keymap.set("n", "<leader>gai", function() require("gp").generate_commit_message() end, { desc = "Generate AI commit message" })
keymap.set("n", "<leader>gsc", function() require("gp").smart_commit() end, { desc = "Smart commit workflow" })

-- Advanced Git Tools
keymap.set("n", "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
keymap.set("n", "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
keymap.set("n", "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", { desc = "File history" })

-- Enhanced Buffer Management
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close left buffers" })
keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Close right buffers" })
keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })
keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Pin buffer" })
keymap.set("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", { desc = "Close unpinned buffers" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
keymap.set("n", "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Delete buffer (force)" })

-- Enhanced Terminal Management
keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float terminal" })
keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Horizontal terminal" })
keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Vertical terminal" })
keymap.set("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", { desc = "LazyGit terminal" })
keymap.set("n", "<leader>tp", "<cmd>lua _python_toggle()<CR>", { desc = "Python terminal" })
keymap.set("n", "<leader>tn", "<cmd>lua _node_toggle()<CR>", { desc = "Node terminal" })

-- Enhanced Telescope for Ultimate IDE
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find text" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
keymap.set("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", { desc = "Find colorscheme" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
keymap.set("n", "<leader>fs", "<cmd>Telescope symbols<cr>", { desc = "Find symbols" })
keymap.set("n", "<leader>fp", "<cmd>Telescope project<cr>", { desc = "Find projects" })
keymap.set("n", "<leader>fd", "<cmd>Telescope file_browser<cr>", { desc = "File browser" })
keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find word under cursor" })
keymap.set("n", "<leader>ft", "<cmd>Telescope treesitter<cr>", { desc = "Find treesitter symbols" })
keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find marks" })
keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Find jumplist" })
keymap.set("n", "<leader>fl", "<cmd>Telescope loclist<cr>", { desc = "Find location list" })
keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "Find quickfix" })
keymap.set("n", "<leader>fe", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics" })

-- Quick access shortcuts
keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap.set("n", "<C-f>", "<cmd>Telescope live_grep<cr>", { desc = "Find text" })

-- Notification management
keymap.set("n", "<leader>nd", function() require("notify").dismiss({ silent = true, pending = true }) end, { desc = "Dismiss notifications" })

-- Workspace management
keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = "List workspace folders" })

-- Enhanced editing commands for ultimate productivity
keymap.set("n", "<leader>dup", "yyp", { desc = "Duplicate line" })
keymap.set("v", "<leader>dup", "y`>p", { desc = "Duplicate selection" })
keymap.set("n", "<leader>del", "dd", { desc = "Delete line" })
keymap.set("n", "<leader>cls", "cc", { desc = "Clear line and enter insert" })

-- Quick save and quit shortcuts
keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
keymap.set("i", "<C-s>", "<esc><cmd>w<cr>", { desc = "Save file and exit insert" })
keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all files" })
keymap.set("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Enhanced visual mode shortcuts
keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- UI Toggle for minimal cmdline interface
keymap.set("n", "<leader>uc", function()
  local current_cmdheight = vim.o.cmdheight
  if current_cmdheight == 0 then
    vim.o.cmdheight = 1
    print("Cmdline visible")
  else
    vim.o.cmdheight = 0
    print("Cmdline minimal")
  end
end, { desc = "Toggle cmdline height (minimal/visible)" })

