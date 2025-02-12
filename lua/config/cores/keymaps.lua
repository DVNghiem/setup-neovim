-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "JK", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
keymap.set("n", "<c-s>", ":w<cr>", { desc = "Save" })
keymap.set("n", "<leader>q", ":q<cr>", { desc = "Exit" })

-- go to end line
vim.api.nvim_set_keymap('n', '<Left>', [[col('.') == 1 ? '<Esc>k<S-a><Esc>' : '<Left>']], {expr = true})
vim.api.nvim_set_keymap('i', '<Left>', [[col('.') == 1 ? '<Esc>k<S-a>' : '<Left>']], {expr = true})

-- Move to tab
keymap.set("n", "<c-k>", ":wincmd k<CR>", opts)
keymap.set("n", "<c-j>", ":wincmd j<CR>", opts)
keymap.set("n", "<c-h>", ":wincmd h<CR>", opts)
keymap.set("n", "<c-l>", ":wincmd l<CR>", opts)

keymap.set("n", 'dw', 'vb"_d')       -- delete word backward
keymap.set('n', '<C-a>', 'gg<S-v>G') -- select all

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- go to each character
vim.keymap.set('i', '<c-l>', '<Esc>la', { noremap = true })
vim.keymap.set('i', '<c-h>', '<Esc>ha', { noremap = true })

-- new line
vim.keymap.set('i', '<c-n>', '<Esc>o', { noremap = true })


-- tab and shift tab 
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true })

-- bufferline
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd | bnext<CR>', { noremap = true, silent = true })

-- neo tree toggle
-- open/close neo tree
vim.api.nvim_set_keymap('n', '<leader>nt', ':Neotree toggle<CR>', { noremap = true, silent = true })


