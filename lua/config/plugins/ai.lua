return {
  -- 1. COPILOT CORE
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VeryLazy",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 150,
          keymap = {
            accept = "<M-l>",
            accept_word = "<M-w>",
            accept_line = "<M-j>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<M-h>",
          },
        },
        panel = { enabled = true, auto_refresh = true },
        filetypes = { ["*"] = true },
      })

      -- Keymaps cho suggestion
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

  -- 2. COPILOT CMP (completion source)
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- 3. COPILOT CHAT
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    config = function()
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")

      chat.setup({
        debug = false,
        system_prompt = [[You are an AI programming assistant for long coding sessions.
Focus on: code quality, performance, security, maintainability, and developer ergonomics.
Be concise, clear, and helpful.]],
        question_header = "## User ",
        answer_header = "## Copilot ",
        separator = " --- ",
        show_help = true,
        auto_follow_cursor = false,
        history_path = vim.fn.stdpath("cache") .. "/copilotchat_history",
        selection = function(source)
          return (vim.fn.mode() == "v" or vim.fn.mode() == "V") and select.visual(source) or select.buffer(source)
        end,
        window = {
          layout = "vertical",
          width = 0.4,
          border = "rounded",
          title = "Copilot Chat",
        },
        mappings = {
          close = { normal = "q", insert = "<C-c>" },
          reset = { normal = "<C-r>", insert = "<C-r>" },
          submit_prompt = { normal = "<CR>", insert = "<C-s>" },
          accept_diff = { normal = "<C-y>", insert = "<C-y>" },
          show_diff = { normal = "gd" },
          preview_diff = { normal = "gp" },
        },
        prompts = {
          Explain = { prompt = "/COPILOT_EXPLAIN Explain the selected code." },
          Fix = { prompt = "/COPILOT_GENERATE Fix the problem in this code." },
          Tests = { prompt = "/COPILOT_GENERATE Generate tests for this code." },
          Optimize = { prompt = "/COPILOT_GENERATE Optimize performance and readability." },
          Docs = { prompt = "/COPILOT_GENERATE Add documentation." },
          Debug = { prompt = "Suggest where to put breakpoints and how to debug this." },
        },
      })

      -- Auto save chat history khi thoát
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          local path = vim.fn.stdpath("cache") .. "/copilotchat_history"
          vim.fn.mkdir(path, "p")
          pcall(chat.save, path .. "/session_" .. os.date("%Y%m%d_%H%M%S") .. ".json")
        end,
      })

      -- Keymaps cho CopilotChat
      vim.keymap.set("n", "<leader>ci", function()
        local line = vim.api.nvim_get_current_line()
        chat.ask("Explain: " .. vim.trim(line))
      end, { desc = "Inline chat" })

      vim.keymap.set("n", "<leader>ce", function()
        local diag = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
        if #diag > 0 then
          chat.ask("Fix this error: " .. diag[1].message, { selection = select.buffer })
        end
      end, { desc = "Fix LSP error" })

      vim.keymap.set("n", "<leader>cd", function()
        chat.ask("Where should I put breakpoints to debug this function?")
      end, { desc = "AI Debug suggest" })

      vim.keymap.set("n", "<leader>ccq", function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then chat.ask(input) end
      end, { desc = "Quick chat" })

      vim.keymap.set("n", "<leader>ccp", "<cmd>CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
    end,
    keys = {
      { "<leader>ccp", desc = "Toggle Copilot Chat" },
      { "<leader>ci", desc = "Inline chat" },
      { "<leader>ce", desc = "Fix LSP error" },
      { "<leader>cd", desc = "AI Debug suggest" },
      { "<leader>ccq", desc = "Quick chat" },
      { "<leader>cce", mode = { "n", "v" }, "<cmd>CopilotChatExplain<CR>", desc = "Explain" },
      { "<leader>ccf", mode = { "n", "v" }, "<cmd>CopilotChatFix<CR>", desc = "Fix" },
      { "<leader>cct", mode = { "n", "v" }, "<cmd>CopilotChatTests<CR>", desc = "Tests" },
    },
  },

  -- 4. LSPKIND (hiển thị icon AI trong CMP)
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

  -- 5. NEOGEN (tạo docs tự động)
  {
    "danymat/neogen",
    cmd = "Neogen",
    opts = {
      languages = {
        python = { template = { annotation_convention = "google_docstrings" } },
        go = { template = { annotation_convention = "godoc" } },
      },
    },
    keys = {
      { "<leader>ng", "<cmd>Neogen<CR>", desc = "Generate docs" },
    },
  },
}