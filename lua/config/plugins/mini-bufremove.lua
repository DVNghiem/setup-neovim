return {
  -- Safe buffer removal - prevents closing windows when deleting buffers
  {
    "echasnovski/mini.bufremove",
    version = "*",
    keys = {
      {
        "<leader>bc",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Close current buffer",
      },
      {
        "<leader>bC",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Force close current buffer",
      },
      {
        "<leader>bw",
        function()
          require("mini.bufremove").wipeout(0, false)
        end,
        desc = "Wipeout current buffer",
      },
      {
        "<leader>bW",
        function()
          require("mini.bufremove").wipeout(0, true)
        end,
        desc = "Force wipeout current buffer",
      },
    },
    config = function()
      require("mini.bufremove").setup()
    end,
  },
}
