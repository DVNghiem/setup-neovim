return {
  "kylechui/nvim-surround",
  event = { "BufReadPost", "BufNewFile" },
  version = "*",
  keys = {
    { "ys", desc = "Add Surround (ysiw)" },
    { "ds", desc = "Delete Surround" },
    { "cs", desc = "Change Surround" },
  },
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },

      surrounds = {
        ["("] = { add = { "( ", " )" } },
        [")"] = { add = { "(", ")" } },
        ["{"] = { add = { "{ ", " }" } },
        ["}"] = { add = { "{", "}" } },
        ["<"] = { add = { "< ", " >" } },
        [">"] = { add = { "<", ">" } },
        ["["] = { add = { "[ ", " ]" } },
        ["]"] = { add = { "[", "]" } },

        -- HTML/JSX 
        ["t"] = { add = { "<div>", "</div>" }, change = { target = "<[^>]->" } },
        ["T"] = { add = { "<div className=\"\">", "</div>" } },
        ["p"] = { add = { "<p>", "</p>" } },
        ["h"] = { add = { "<h1>", "</h1>" } },
        ["a"] = { add = { "<a href=\"\">", "</a>" } },

        -- FUNCTION ARROW
        ["f"] = {
          add = function()
            local cmd = vim.fn.input("Function: ")
            return { { cmd .. " => {" }, { "}" } }
          end,
        },
      },

      move_cursor = "begin",
      indent_lines = true,
    })
  end,
}