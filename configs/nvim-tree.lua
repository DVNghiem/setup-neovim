-- -- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- -- empty setup using defaults
require("nvim-tree").setup({
  open_on_setup = true,
  ignore_buffer_on_setup = true,
  filters = {
    dotfiles = true,
  },
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
})
