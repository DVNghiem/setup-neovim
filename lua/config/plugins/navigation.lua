return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "FzfLua" },
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>",       desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>",  desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>",    desc = "Buffers" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>",  desc = "Recent files" },
      { "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor" },
      { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<C-p>", "<cmd>FzfLua files<cr>",    desc = "Find files" },
      { "<C-f>", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
    },
    opts = {
      winopts = { border = "rounded" },
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>a",  function() require("harpoon"):list():add() end,   desc = "Harpoon add file" },
      { "<C-e>",      function() require("harpoon"):list():toggle() end, desc = "Harpoon toggle menu" },
      { "<C-1>",      function() require("harpoon"):list():select(1) end, desc = "Harpoon select 1" },
      { "<C-2>",      function() require("harpoon"):list():select(2) end, desc = "Harpoon select 2" },
      { "<C-3>",      function() require("harpoon"):list():select(3) end, desc = "Harpoon select 3" },
      { "<C-4>",      function() require("harpoon"):list():select(4) end, desc = "Harpoon select 4" },
    },
    opts = {},
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
      { "<leader>-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = true,
    },
  },
}
