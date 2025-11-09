vim.api.nvim_command("syntax enable")
vim.api.nvim_command('filetype plugin indent on')

vim.opt.modifiable = true
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = "*",
    callback = function()
        if not vim.o.modifiable then
            local ft = vim.bo.filetype
            if ft ~= "neo-tree" and ft ~= "quickfix" and ft ~= "help" then
                vim.opt.modifiable = true
            end
        end
    end
})

local set = vim.opt

-- Scrolling & Navigation (smooth and responsive)
set.scroll = 5
set.scrolloff = 8
set.sidescrolloff = 8
set.smoothscroll = true

-- Indentation & Formatting
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.smartindent = true
set.autoindent = true
set.breakindent = true

-- Basic Settings
set.encoding = "UTF-8"
set.mouse = "a"
set.number = true
set.relativenumber = true
set.wrap = false

-- Performance optimizations
set.synmaxcol = 300
set.timeoutlen = 300
set.ttimeoutlen = 10
set.updatetime = 250
set.redrawtime = 1500
set.lazyredraw = false
set.ttyfast = true

-- Visual & UI (modern and clean)
vim.o.termguicolors = true
vim.o.background = "dark"

-- Better cursor and visual indicators
set.cursorline = true
set.cursorcolumn = false
set.signcolumn = "yes"
set.colorcolumn = ""
set.list = false
set.listchars = {
    tab = "  ",
    trail = " ",
    extends = " ",
    precedes = " ",
    nbsp = " "
}

-- Modern window settings
set.splitright = true
set.splitbelow = true
set.equalalways = false
set.winblend = 0          -- Transparency for floating windows
set.pumblend = 10         -- Slight transparency for popup menu

-- Window borders
set.fillchars = {
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
    fold = " ",
    foldopen = "-",
    foldclose = "+",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

-- File handling
set.swapfile = false
set.backup = false
set.undofile = true
set.undodir = vim.fn.expand("~/.cache/nvim/undo")
set.undolevels = 10000
set.hidden = true

-- Search settings
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.hlsearch = true

-- Memory and performance
set.maxmempattern = 2000
set.history = 1000

-- Better completion experience
set.completeopt = { "menu", "menuone", "noselect" }
set.pumheight = 15

-- Modern cursor styling
vim.cmd([[
    highlight iCursor guifg=white guibg=#89b4fa
    set guicursor=n-v-c:block-Cursor
    set guicursor+=i:ver25-iCursor
    set guicursor+=n-v-c:blinkon0
    set guicursor+=i:blinkwait10
    
    " Better visual feedback
    highlight Visual gui=reverse
    highlight Search guibg=#f9e2af guifg=#000000
    highlight IncSearch guibg=#f38ba8 guifg=#ffffff
]])
-- Clipboard and editing
vim.opt.clipboard:append { 'unnamedplus' }
-- Font (optimized for readability)
vim.opt.guifont = "JetBrains Mono:h13"
