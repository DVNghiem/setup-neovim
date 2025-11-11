return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",        -- Alt+L = accept
            accept_word = "<M-w>",   -- Alt+W = accept word
            accept_line = "<M-j>",   -- Alt+J = accept line
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<M-h>",
          },
        },
        panel = { enabled = true, auto_refresh = true },
        filetypes = {
          ["*"] = true,  -- enable for all filetypes
        },
      })

      -- KEYMAP SHORTCUTS
      vim.keymap.set("i", "<M-l>", function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        end
      end, { desc = "Copilot Accept" })

      vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<CR>", { desc = "Copilot Panel" })
      vim.keymap.set("n", "<leader>ct", "<cmd>Copilot toggle<CR>", { desc = "Toggle Copilot" })
      vim.keymap.set("n", "<leader>cs", function()
        vim.notify("Copilot: " .. (require("copilot.client").is_disabled() and "OFF" or "ON"))
      end, { desc = "Copilot Status" })
    end,
  },

  -- 2. COPILOT CMP
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- 3. CODEIUM – BACKUP
  {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("codeium").setup({
        enable_chat = true,
      })
      vim.keymap.set("n", "<leader>ai", "<cmd>Codeium Chat<CR>", { desc = "Codeium Chat" })
    end,
  },

  {
    "onsails/lspkind.nvim",
    event = "InsertEnter",
    config = function()
      require("lspkind").init({
        symbol_map = {
          Copilot = "AI",
          Codeium = "AI",
        },
      })
    end,
  },
}