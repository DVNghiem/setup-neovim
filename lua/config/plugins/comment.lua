return {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- Changed from BufReadPre for faster file opening
    dependencies = {
    },
    config = function()
      -- import comment plugin safely
      local comment = require("Comment")
  
      -- enable comment
      comment.setup({
        -- for commenting tsx, jsx, svelte, html files
      })
    end,
  }
