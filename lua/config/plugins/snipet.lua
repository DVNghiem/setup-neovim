return {
  "L3MON4D3/LuaSnip",
  build = (not jit.os:find("Windows"))
      and "echo 'jsregexp optional - skip if fail'; make install_jsregexp"
      or nil,
  dependencies = {
    "rafamadriz/friendly-snippets",
    "honza/vim-snippets", --  500+ snippet classic
  },
  event = "InsertEnter",
  config = function()
    local ls = require("luasnip")
    local types = require("luasnip.util.types")

    ls.setup({
      keep_roots = true,
      link_roots = true,
      link_children = true,
      history = true,
      delete_check_events = "TextChanged,TextChangedI",
      region_check_events = "CursorMoved",
      update_events = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = {
          active = { virt_text = { { " ← Choice", "Comment" } } },
        },
        [types.insertNode] = {
          unvisited = { virt_text = { { "●", "ErrorMsg" } } },
          visited = { virt_text = { { "●", "Comment" } } },
        },
      },
    })

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } }) -- custom snippets
    require("luasnip.loaders.from_snipmate").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({ paths = { "./lua-snippets" } })

    vim.keymap.set({"i", "s"}, "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "")
      end
    end, { silent = true })

    vim.keymap.set({"i", "s"}, "<S-Tab>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    vim.keymap.set("i", "<C-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/plugins/luasnip.lua<CR>", { desc = "Reload Snippets" })
  end,
}