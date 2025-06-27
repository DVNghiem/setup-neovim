return {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" }, -- Changed from BufReadPre for faster file opening
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = true,
  }