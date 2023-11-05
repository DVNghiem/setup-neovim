return {
  "mg979/vim-visual-multi",
  -- "terryma/vim-multiple-cursors",
  branch = "master",
  init = function()
    vim.g.VM_maps = {
      ["Find Under"] = "<C-d>"
    }
  end,
  config = function()

  end,
}
