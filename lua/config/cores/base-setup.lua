vim.api.nvim_command("syntax enable")
vim.api.nvim_command('filetype plugin indent on')

vim.opt.modifiable = true
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = "*",
    callback = function()
        if not vim.o.modifiable then
            -- Don't set modifiable for special buffers
            local ft = vim.bo.filetype
            if ft ~= "neo-tree" and ft ~= "quickfix" and ft ~= "help" then
                vim.opt.modifiable = true
            end
        end
    end
})

local set = vim.opt

-- Scrolling & Navigation (optimized for long sessions)
set.scroll=5
set.scrolloff=8          -- Keep more lines visible above/below cursor
set.sidescrolloff=8      -- Keep more columns visible left/right

-- Indentation & Formatting
set.tabstop=4
set.softtabstop=4
set.shiftwidth=4
set.expandtab=true       -- Use spaces instead of tabs
set.smartindent=true     -- Smart auto-indenting
set.autoindent=true      -- Copy indent from current line

-- Basic Settings
set.encoding="UTF-8"
set.mouse="a"
set.number=true
set.relativenumber=true

-- Performance optimizations for large files
set.synmaxcol=300        -- Don't highlight very long lines
-- updatetime managed by LSP config to prevent conflicts
set.timeoutlen=200       -- Much faster key sequence timeout for responsiveness
set.ttimeoutlen=5        -- Very fast escape sequences
set.redrawtime=1500      -- Faster syntax highlighting timeout
set.regexpengine=1       -- Use old regex engine (sometimes faster)
set.ttyfast=true         -- Faster terminal connection
-- Visual & UI (optimized for long coding sessions)
vim.o.termguicolors = true
vim.o.background = "dark"

-- Better cursor and visual indicators
set.cursorline = true
set.cursorcolumn = false     -- Don't highlight column (can be distracting)
set.signcolumn = "yes:1"     -- Always show sign column to prevent shifting
set.colorcolumn = ""         -- Remove column markers for cleaner look
set.list = false             -- Hide invisible characters for cleaner look
set.listchars = {
    tab = "  ",
    trail = " ",
    extends = " ",
    precedes = " ",
    nbsp = " "
}

-- Window behavior
set.splitright = true
set.splitbelow = true
set.equalalways = false      -- Don't auto-resize windows

-- File handling (better for long sessions)
set.swapfile = false
set.backup = false
set.undofile = true          -- Persistent undo
set.undodir = vim.fn.expand("~/.cache/nvim/undo")
set.undolevels = 10000       -- More undo levels
set.hidden = true            -- Allow switching buffers without saving

-- Memory and performance
set.maxmempattern = 2000     -- Increase pattern matching memory
set.history = 1000           -- More command history
set.redrawtime = 1500        -- Faster syntax highlighting timeout
set.regexpengine = 1         -- Use old regex engine (sometimes faster)
set.ttyfast = true           -- Faster terminal connection

vim.cmd [[
    silent! colorscheme *
    hi Normal guibg=#fff
	autocmd ColorScheme * hi Normal guibg=NONE guifg=#row_color
    autocmd ColorScheme * hi NonText guibg=NONE guifg=#row_color
    autocmd ColorScheme * hi LineNr guibg=NONE guifg=#row_color
    highlight iCursor guifg=white guibg=steelblue
    set guicursor=n-v-c:block-Cursor
    set guicursor+=i:ver100-iCursor
    set guicursor+=n-v-c:blinkon0
    set guicursor+=i:blinkwait10
    
    " Better visual feedback
    highlight Visual cterm=reverse gui=reverse
    highlight Search guibg=#ffff00 guifg=#000000
    highlight IncSearch guibg=#ff6600 guifg=#ffffff
]]
-- Clipboard and editing
vim.opt.clipboard:append { 'unnamedplus' }
-- Font (optimized for readability)
vim.opt.guifont = "JetBrains Mono:h13"
