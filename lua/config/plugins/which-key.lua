return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    window = {
      border = "rounded",
      position = "bottom",
      margin = { 1, 0, 1, 0 },
      padding = { 1, 2, 1, 2 },
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "left",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register leader key groups
    wk.register({
      ["<leader>f"] = { name = "Find (Telescope)" },
      ["<leader>l"] = { name = "LSP" },
      ["<leader>lw"] = { name = "Workspace" },
      ["<leader>g"] = { name = "Git" },
      ["<leader>b"] = { name = "Buffers" },
      ["<leader>w"] = { name = "Windows" },
      ["<leader>t"] = { name = "Toggles/Terminal" },
      ["<leader>c"] = { name = "Code" },
      ["<leader>x"] = { name = "Diagnostics/Trouble" },
      ["<leader>s"] = { name = "Search/Replace" },
      ["<leader>r"] = { name = "Refactor" },
    })
  end,
}
