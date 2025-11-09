return {
  -- Enhanced Copilot chat for better AI assistance
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" }, -- for integration
    },
    event = "VeryLazy",
    config = function()
      -- Safe setup with error handling
      local ok, copilot_chat = pcall(require, "CopilotChat")
      if not ok then
        vim.notify("CopilotChat not available yet. Please run :Lazy sync", vim.log.levels.WARN)
        return
      end
      
      copilot_chat.setup({
        debug = false,
        proxy = nil,
        allow_insecure = false,
        system_prompt = [[You are an AI programming assistant helping during long coding sessions. 
Be concise, helpful, and focus on:
1. Code quality and best practices
2. Performance optimizations
3. Maintainability
4. Security considerations
5. Developer ergonomics and productivity

Consider the developer might be tired, so provide clear, well-structured responses.]],
        question_header = "## User ",
        answer_header = "## Copilot ",
        error_header = "## Error ",
        separator = " --- ",
        show_folds = true,
        show_help = true,
        auto_follow_cursor = true,
        auto_insert_mode = false,
        clear_chat_on_new_prompt = false,
        context = nil,
        history_path = vim.fn.stdpath("data") .. "/copilotchat_history",
        callback = nil,
        
        -- Updated selection configuration
        selection = function(source)
          local select_ok, select = pcall(require, "CopilotChat.select")
          if select_ok then
            return select.visual(source) or select.buffer(source)
          end
          return nil
        end,
        
        prompts = {
          Explain = {
            prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
          },
          Review = {
            prompt = "/COPILOT_REVIEW Review the selected code for potential issues, bugs, and improvements. Focus on performance, security, and maintainability.",
          },
          Fix = {
            prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to fix the problem.",
          },
          Optimize = {
            prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.",
          },
          Docs = {
            prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
          },
          Tests = {
            prompt = "/COPILOT_GENERATE Please generate tests for my code.",
          },
          BetterNamings = {
            prompt = "Please provide better names for the following variables and functions.",
          },
          Summarize = {
            prompt = "Summarize the selected code in a concise way, highlighting the main functionality.",
          },
          Simplify = {
            prompt = "Simplify the selected code while maintaining functionality.",
          },
          Concise = {
            prompt = "Re-write the selected code to be more concise while maintaining readability.",
          },
          ErgonomicReview = {
            prompt = "Review this code considering developer ergonomics - readability, maintainability, and ease of understanding for long coding sessions.",
          },
        },
        
        window = {
          layout = "vertical",
          width = 0.4,
          height = 0.4,
          relative = "editor",
          border = "rounded",
          row = nil,
          col = nil,
          title = "Copilot Chat",
          footer = nil,
          zindex = 1,
        },
        
        mappings = {
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "<Tab>",
          },
          close = {
            normal = "q",
            insert = "<C-c>"
          },
          reset = {
            normal = "<C-r>",
            insert = "<C-r>"
          },
          submit_prompt = {
            normal = "<CR>",
            insert = "<C-s>"
          },
          accept_diff = {
            normal = "<C-y>",
            insert = "<C-y>"
          },
          yank_diff = {
            normal = "gy",
          },
          show_diff = {
            normal = "gd"
          },
          show_info = {
            normal = "gi"
          },
          show_context = {
            normal = "gc"
          },
        },
      })
      
      -- Auto-save chat history
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          local history_path = vim.fn.stdpath("data") .. "/copilotchat_history"
          pcall(copilot_chat.save, history_path .. "/session_" .. os.date("%Y%m%d_%H%M%S") .. ".json")
        end,
      })
      
      -- Integrate with telescope if available
      pcall(function()
        require("CopilotChat.integrations.telescope").setup()
      end)
    end,
    keys = {
      -- Show prompts
      { "<leader>ccp", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
      { "<leader>ccx", "<cmd>CopilotChatReset<cr>", desc = "Reset Copilot Chat" },
      { "<leader>ccs", "<cmd>CopilotChatStop<cr>", desc = "Stop Copilot Chat" },
      
      -- Quick actions
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", mode = {"n", "v"}, desc = "Explain code" },
      { "<leader>ccr", "<cmd>CopilotChatReview<cr>", mode = {"n", "v"}, desc = "Review code" },
      { "<leader>ccf", "<cmd>CopilotChatFix<cr>", mode = {"n", "v"}, desc = "Fix code" },
      { "<leader>cco", "<cmd>CopilotChatOptimize<cr>", mode = {"n", "v"}, desc = "Optimize code" },
      { "<leader>ccd", "<cmd>CopilotChatDocs<cr>", mode = {"n", "v"}, desc = "Generate docs" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>", mode = {"n", "v"}, desc = "Generate tests" },
      
      -- Code improvement
      { "<leader>ccn", "<cmd>CopilotChatBetterNamings<cr>", mode = {"n", "v"}, desc = "Better variable names" },
      { "<leader>ccS", "<cmd>CopilotChatSummarize<cr>", mode = {"n", "v"}, desc = "Summarize code" },
      { "<leader>cci", "<cmd>CopilotChatSimplify<cr>", mode = {"n", "v"}, desc = "Simplify code" },
      { "<leader>ccC", "<cmd>CopilotChatConcise<cr>", mode = {"n", "v"}, desc = "Make code concise" },
      { "<leader>ccE", "<cmd>CopilotChatErgonomicReview<cr>", mode = {"n", "v"}, desc = "Ergonomic review" },
      
      -- Custom prompts
      { "<leader>ccq", function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            local ok, chat = pcall(require, "CopilotChat")
            if ok then
              -- Safely get selection without requiring CopilotChat.select
              vim.defer_fn(function()
                chat.ask(input)
              end, 100)
            else
              vim.notify("CopilotChat not available", vim.log.levels.WARN)
            end
          end
        end, desc = "Quick chat" },
    },
  },
  
  -- Code documentation generator
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Neogen",
    opts = {
      snippet_engine = "luasnip",
      languages = {
        lua = {
          template = {
            annotation_convention = "ldoc",
          },
        },
        python = {
          template = {
            annotation_convention = "google_docstrings",
          },
        },
        javascript = {
          template = {
            annotation_convention = "jsdoc",
          },
        },
        typescript = {
          template = {
            annotation_convention = "tsdoc",
          },
        },
        go = {
          template = {
            annotation_convention = "godoc",
          },
        },
        rust = {
          template = {
            annotation_convention = "rustdoc",
          },
        },
        java = {
          template = {
            annotation_convention = "javadoc",
          },
        },
      },
    },
    keys = {
      { "<leader>ng", "<cmd>Neogen<cr>", desc = "Generate documentation" },
      { "<leader>nf", "<cmd>Neogen func<cr>", desc = "Generate function docs" },
      { "<leader>nc", "<cmd>Neogen class<cr>", desc = "Generate class docs" },
      { "<leader>nt", "<cmd>Neogen type<cr>", desc = "Generate type docs" },
      { "<leader>nF", "<cmd>Neogen file<cr>", desc = "Generate file docs" },
    },
  },
}
