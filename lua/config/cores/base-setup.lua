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

set.scroll=5
set.scrolloff=5
set.tabstop=4
set.softtabstop=0
set.shiftwidth=4
set.encoding="UTF-8"
set.mouse="a"
set.number=true
set.relativenumber=true
vim.o.termguicolors = true
vim.o.background = "dark"
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
]]
set.ai=true
set.si=true
set.wrap = false
set.path:append {"**"}
set.cursorline = true
set.signcolumn = "yes"
set.splitright = true
set.splitbelow = true
vim.opt.swapfile = false
vim.opt.clipboard:append { 'unnamedplus' }

vim.opt.guifont = "FiraCode Nerd Font:h13"
-- search settings
set.ignorecase = true -- ignore case when searching
set.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- backspace
set.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- Event global
_G.BufEvent = { "BufReadPost", "BufNewFile", "BufWritePre" }

