-- Minimal cheatsheet command for quick help
return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      -- Add a cheatsheet command that shows common keymaps
      vim.api.nvim_create_user_command("Cheatsheet", function()
        local cheat = {
          ["General"] = {
            ["<leader>h"] = "Help/Documentation",
            ["<leader>q"] = "Quit",
            ["<leader>w"] = "Save",
            ["<leader>x"] = "Save & Quit",
          },
          ["File Navigation"] = {
            ["<leader>ff"] = "Find Files",
            ["<leader>fg"] = "Live Grep", 
            ["<leader>fb"] = "Buffers",
            ["<leader>fh"] = "Help Tags",
            ["<leader>fr"] = "Recent Files",
            ["<leader>e"] = "Toggle Explorer",
          },
          ["LSP"] = {
            ["gd"] = "Go to Definition",
            ["gr"] = "Go to References", 
            ["K"] = "Hover Documentation",
            ["<leader>ca"] = "Code Actions",
            ["<leader>rn"] = "Rename",
            ["<leader>cf"] = "Format",
          },
          ["Git"] = {
            ["<leader>gg"] = "Neogit",
            ["<leader>gd"] = "Git Diff",
            ["<leader>gb"] = "Git Blame",
            ["<leader>gh"] = "Git Hunk Actions",
          },
          ["Terminal"] = {
            ["<C-\\>"] = "Toggle Terminal",
            ["<leader>tf"] = "Float Terminal",
            ["<leader>th"] = "Horizontal Terminal",
            ["<leader>tv"] = "Vertical Terminal",
          },
        }
        
        local lines = { "=== NEOVIM CHEATSHEET ===" }
        for category, mappings in pairs(cheat) do
          table.insert(lines, "")
          table.insert(lines, "📁 " .. category)
          table.insert(lines, string.rep("-", #category + 3))
          for key, desc in pairs(mappings) do
            table.insert(lines, string.format("  %-20s %s", key, desc))
          end
        end
        
        vim.api.nvim_echo({ { table.concat(lines, "\n"), "Normal" } }, true, {})
      end, { desc = "Show cheatsheet" })
      
      return opts
    end,
  },
}
