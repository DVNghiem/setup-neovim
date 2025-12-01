-- Disable deprecation warnings
vim.deprecate = function() end

-- Ensure modifiable buffers
vim.opt.modifiable = true
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    if not vim.o.modifiable then
      local ft = vim.bo.filetype
      if ft ~= "neo-tree" and ft ~= "quickfix" and ft ~= "help" then
        vim.opt.modifiable = true
      end
    end
  end,
})

-- Optimized autocmd group
local augroup = vim.api.nvim_create_augroup("CoreSettings", { clear = true })

-- Auto-save when leaving buffer or losing focus (preserved from original)
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = augroup,
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.bo.readonly == false then
      vim.cmd("silent! write")
    end
  end,
})

-- Large file detection and optimization (NEW)
vim.api.nvim_create_autocmd({ "BufReadPre" }, {
  group = augroup,
  pattern = "*",
  callback = function()
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > 1024 * 1024 then -- 1MB
      vim.opt_local.eventignore:append("FileType")
      vim.opt_local.undolevels = -1
      vim.opt_local.swapfile = false
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.syntax = "off"
    end
  end,
})

local set = vim.opt

-- Performance optimizations (world-class responsiveness) (UPDATED)
set.updatetime = 200        -- Fast LSP/diagnostics (balanced)
set.timeoutlen = 300         -- Better for which-key discoverability
set.ttimeoutlen = 10         -- Instant key code timeout
set.redrawtime = 1500        -- Prevent slow redraws
set.synmaxcol = 300          -- Don't highlight super long lines
set.lazyredraw = false       -- Smooth visual feedback
set.ttyfast = true           -- Fast terminal connection

-- Scrolling & Navigation (smooth and responsive)
set.scroll = 5
set.scrolloff = 8
set.sidescrolloff = 8
set.smoothscroll = true

-- Indentation & Formatting (PRESERVED)
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.smartindent = true
set.autoindent = true
set.breakindent = true

-- Basic Settings (PRESERVED)
set.encoding = "UTF-8"
set.mouse = "a"
set.number = true
set.relativenumber = true
set.wrap = false

-- Visual & UI (modern and clean)
vim.o.termguicolors = true
vim.go.background = "dark"

-- Better cursor and visual indicators
set.cursorline = true
set.cursorcolumn = false
set.signcolumn = "yes" -- PRESERVED
set.colorcolumn = ""   -- PRESERVED
set.list = false       -- PRESERVED

vim.opt.listchars:append({
  tab = "  ",
  trail = "·",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
})

-- Modern window settings
set.splitright = true
set.splitbelow = true
set.equalalways = false
set.winblend = 0  -- Transparency for floating windows
set.pumblend = 10 -- Slight transparency for popup menu

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

-- File handling (optimized) (UPDATED comment, content same)
set.swapfile = false
set.backup = false
set.undofile = true
set.undodir = vim.fn.expand("~/.cache/nvim/undo")
set.undolevels = 10000
set.hidden = true

-- Ensure undo directory exists (NEW)
vim.fn.mkdir(vim.fn.expand("~/.cache/nvim/undo"), "p")

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

-- Clipboard (UPDATED comment, content same)
vim.opt.clipboard = "unnamedplus"

-- Font (optimized for readability)
if vim.g.neovide then
  vim.opt.guifont = "JetBrains Mono:h13"
end