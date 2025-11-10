return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  keys = {
    { "<C-\\>", mode = {"n", "t"}, desc = "Toggle Terminal" },
    { "<leader>gg", "<cmd>TermExec cmd='lazygit'<CR>", desc = "Lazygit" },
    { "<leader>tp", "<cmd>TermExec cmd='python %'<CR>", desc = "Run Python File" },
    { "<leader>tn", "<cmd>TermExec cmd='node %'<CR>", desc = "Run Node.js File" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float Terminal" },
    { "<leader>th", "<cmd>ToggleTerm size=20 direction=horizontal<CR>", desc = "Horizontal" },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "Vertical" },
  },
  config = function()
    local toggleterm = require("toggleterm")
    
    toggleterm.setup({
      size = function(term)
        if term.direction == "horizontal" then
          return vim.o.lines * 0.3
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        else
          return 20
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = false,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "bash",
      auto_scroll = true,

      float_opts = {
        border = "curved",
        winblend = 0,
        width = function() return math.floor(vim.o.columns * 0.9) end,
        height = function() return math.floor(vim.o.lines * 0.9) end,
        highlights = {
          border = "FloatBorder",
          background = "NormalFloat",
        },
      },

      highlights = {
        NormalFloat = { link = "Normal" },
        FloatBorder = { fg = "#6272A4" },
      },
    })

    vim.api.nvim_set_hl(0, "ToggleTermBorder", { fg = "#6272A4" })
    vim.api.nvim_set_hl(0, "ToggleTermFloat", { bg = "#282A36" })

    local Terminal = require("toggleterm.terminal").Terminal
    
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = { border = "double" },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
    })

    -- KEYMAP
    vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, { desc = "Lazygit" })

    -- ESC EXIST TERMINAL
    vim.api.nvim_set_keymap("t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<C-h>", [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<C-l>", [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })
  end,
}