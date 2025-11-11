return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local autopairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")
    local cmp = require("cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    autopairs.setup({
      check_ts = false,

      map_cr = true,
      map_bs = true,
      map_c_h = false,
      map_c_w = false,

      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        offset = 0,
        highlight = "PmenuSel",
      },

      disable_filetype = { "TelescopePrompt", "vim" },

      enable_check_bracket_line = false,
      ignored_next_char = "[%w%.]",
    })

    autopairs.add_rules({
      Rule("=>", "", { "lua", "javascript", "typescript" })
        :use_regex(true)
        :replace_endpair(function() return " " end),

      Rule("->", "", { "rust", "c", "cpp" })
        :use_regex(true),

      Rule("|", "|", "tex")
        :with_pair(cond.not_inside_quote()),
    })

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}