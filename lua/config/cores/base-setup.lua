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
set.scrolljump=5         -- Jump 5 lines when scrolling

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
set.colorcolumn = "80,120"   -- Visual guides for line length
set.list = true              -- Show invisible characters
set.listchars = {
    tab = "▸ ",
    trail = "·",
    extends = "❯",
    precedes = "❮",
    nbsp = "±"
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

-- Enhanced Auto-save functionality (optimized for backend development)
-- Auto-save on focus lost and buffer leave
vim.api.nvim_create_autocmd({"FocusLost", "BufLeave"}, {
    pattern = "*",
    callback = function()
        if vim.bo.modifiable and not vim.bo.readonly and vim.fn.expand("%") ~= "" then
            vim.cmd("silent! write")
        end
    end,
    desc = "Auto-save on focus lost or buffer change"
})

-- Auto-save on cursor hold (after 3 seconds of inactivity)
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
    pattern = "*",
    callback = function()
        if vim.bo.modifiable and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.modified then
            vim.cmd("silent! write")
            -- Show subtle notification for auto-save
            vim.defer_fn(function()
                if vim.fn.mode() == 'n' then
                    local file = vim.fn.expand("%:t")
                    vim.notify("📄 " .. file .. " auto-saved", vim.log.levels.INFO, {
                        title = "Auto-save",
                        timeout = 1000,
                    })
                end
            end, 100)
        end
    end,
    desc = "Auto-save after 3 seconds of inactivity"
})

-- Enhanced auto-save with safety checks
local function safe_auto_save()
    local buf = vim.api.nvim_get_current_buf()
    local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
    local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
    
    -- Skip special buffers
    local skip_filetypes = {'neo-tree', 'dashboard', 'alpha', 'lazy', 'mason', 'toggleterm', 'help', 'qf'}
    
    if buftype == '' and vim.tbl_contains(skip_filetypes, filetype) == false and
       vim.bo.modifiable and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.modified then
        vim.cmd("silent! write")
        return true
    end
    return false
end

-- Auto-save timer (every 30 seconds for active files)
local auto_save_timer = vim.loop.new_timer()
auto_save_timer:start(30000, 30000, vim.schedule_wrap(function()
    if safe_auto_save() then
        local file = vim.fn.expand("%:t")
        vim.notify("💾 " .. file .. " saved automatically", vim.log.levels.INFO, {
            title = "Auto-save",
            timeout = 500,
        })
    end
end))

-- Large file optimizations (prevents lag when opening big files)
vim.api.nvim_create_autocmd("BufReadPre", {
    pattern = "*",
    callback = function()
        local file_size = vim.fn.getfsize(vim.fn.expand("<afile>"))
        if file_size > 1048576 or file_size == -2 then -- 1MB or directory
            -- Disable heavy features for large files
            vim.cmd("syntax off")
            vim.opt_local.foldmethod = "manual"
            vim.opt_local.spell = false
            vim.opt_local.wrap = false
            vim.opt_local.swapfile = false
            vim.opt_local.undofile = false
            vim.cmd("set noloadplugins")
        end
    end,
})

-- File opening performance optimizations (fixes lag when opening files)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "neo-tree",
    callback = function()
        -- Disable heavy features in neo-tree for smoother navigation
        vim.opt_local.cursorline = false
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.opt_local.signcolumn = "no"
    end,
})

-- Optimize file opening by deferring syntax highlighting
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        -- For files smaller than 50KB, enable immediate syntax
        local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(buf))
        if file_size > 0 and file_size < 51200 then
            vim.defer_fn(function()
                if vim.api.nvim_buf_is_valid(buf) then
                    vim.bo[buf].syntax = "on"
                end
            end, 10)
        end
    end,
})

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
vim.opt.guifont = "FiraCode Nerd Font:h13"

-- Search settings (enhanced)
set.ignorecase = true    -- ignore case when searching
set.smartcase = true     -- if you include mixed case in your search, assumes you want case-sensitive
set.hlsearch = true      -- highlight search results
set.incsearch = true     -- show search results as you type
set.wrapscan = true      -- wrap search around end of file

-- Better text editing
set.wrap = false         -- no line wrapping by default
set.linebreak = true     -- wrap at word boundaries when wrap is on
set.breakindent = true   -- maintain indent when wrapping
set.showbreak = "↪ "     -- show wrapped lines indicator
set.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- Completion settings
set.completeopt = "menu,menuone,noselect,preview"
set.pumheight = 15       -- Limit popup menu height
set.pumblend = 10        -- Slight transparency for popup menu

-- Folding (better code organization)
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldlevel = 99       -- Start with all folds open
set.foldlevelstart = 99
set.foldenable = true

-- Better diff viewing
set.diffopt:append("vertical,algorithm:patience,indent-heuristic")

-- Wildmenu completion
set.wildmenu = true
set.wildmode = "longest:full,full"
set.wildoptions = "pum"

-- Path completion
set.path:append {"**"}

-- Session options
set.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Event global
_G.BufEvent = { "BufReadPost", "BufNewFile", "BufWritePre" }

-- Health monitoring for long coding sessions
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Create undo directory if it doesn't exist
        local undo_dir = vim.fn.expand("~/.cache/nvim/undo")
        if vim.fn.isdirectory(undo_dir) == 0 then
            vim.fn.mkdir(undo_dir, "p")
        end
        
        -- Welcome message with health tips
        vim.defer_fn(function()
            vim.notify("💪 Welcome to your ultimate coding environment!\n💡 Tips: Take breaks every hour, stay hydrated, and use :Zen for focus mode", 
                      vim.log.levels.INFO, 
                      { title = "Health Reminder", timeout = 3000 })
        end, 1000)
    end,
})

-- Break reminder system
local break_timer = vim.loop.new_timer()
local function start_break_reminders()
    break_timer:start(3600000, 3600000, vim.schedule_wrap(function() -- Every hour
        vim.notify("🧘 Time for a break! Your eyes and posture will thank you.", 
                   vim.log.levels.WARN, { title = "Health Break" })
    end))
end

-- Auto-start break reminders
vim.api.nvim_create_autocmd("VimEnter", {
    callback = start_break_reminders
})

-- Smooth UI and fluid interface settings
vim.opt.pumblend = 15 -- Transparency for popup menus
vim.opt.winblend = 15 -- Transparency for floating windows

-- Enhanced smooth scrolling
vim.opt.smoothscroll = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Fluid cursor and visual settings
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Smooth window borders and separators
vim.opt.fillchars = {
  horiz = '━',
  horizup = '┻', 
  horizdown = '┳',
  vert = '┃',
  vertleft = '┫',
  vertright = '┣',
  verthoriz = '╋',
  fold = '·',
  eob = ' ', -- suppress ~ at EndOfBuffer
  diff = '╱', -- alternatives = ⣿ ░ ─
  msgsep = '━', -- alternatives = ‾ ─
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸'
}

-- Enhanced list characters for smoother appearance
vim.opt.listchars = {
  tab = '→ ',
  trail = '·',
  nbsp = '␣',
  extends = '▶',
  precedes = '◀'
}

-- Smooth visual enhancements
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'n'

-- Enhanced completion menu styling
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

-- Smooth fold styling
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Enhanced diff styling
vim.opt.diffopt:append("linematch:60")

-- Smooth terminal colors
vim.opt.termguicolors = true

