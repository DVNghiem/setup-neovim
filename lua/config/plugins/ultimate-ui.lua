return {
  -- Enhanced Status Line with Git Integration
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
          }
        end
      end

      local function lsp_status()
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        if #clients == 0 then
          return "No LSP"
        end
        
        local client_names = {}
        for _, client in ipairs(clients) do
          table.insert(client_names, client.name)
        end
        return table.concat(client_names, ", ")
      end

      local function macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "Recording @" .. recording_register
        end
      end

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
          },
          lualine_b = {
            {
              "branch",
              icon = "",
            },
            {
              "diff",
              source = diff_source,
              symbols = { added = " ", modified = " ", removed = " " },
              diff_color = {
                added = { fg = "#98be65" },
                modified = { fg = "#ECBE7B" },
                removed = { fg = "#ec5f67" },
              },
            },
          },
          lualine_c = {
            {
              "filename",
              file_status = true,
              newfile_status = false,
              path = 1,
              symbols = {
                modified = "[+]",
                readonly = "[-]",
                unnamed = "[No Name]",
                newfile = "[New]",
              }
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic", "nvim_lsp" },
              sections = { "error", "warn", "info", "hint" },
              diagnostics_color = {
                error = { fg = "#ec5f67" },
                warn = { fg = "#ECBE7B" },
                info = { fg = "#008080" },
                hint = { fg = "#10B981" },
              },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
              colored = true,
              update_in_insert = false,
              always_visible = false,
            },
          },
          lualine_x = {
            {
              macro_recording,
              color = { fg = "#ff9e3b" },
            },
            {
              lsp_status,
              icon = " LSP:",
              color = { fg = "#7aa2f7" },
            },
            "encoding",
            "fileformat",
            "filetype"
          },
          lualine_y = {
            {
              "progress",
              separator = " ",
              padding = { left = 1, right = 0 },
            },
            {
              "location",
              padding = { left = 0, right = 1 },
            },
          },
          lualine_z = {
            {
              function()
                return " " .. os.date("%R")
              end,
            },
          }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { "neo-tree", "lazy", "trouble", "quickfix" }
      })
    end,
  },

  -- Enhanced Command Palette
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-symbols.nvim",
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorschemes" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>fs", "<cmd>Telescope symbols<cr>", desc = "Symbols" },
      { "<leader>fp", "<cmd>Telescope project<cr>", desc = "Projects" },
      { "<leader>fd", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
      { "<leader>ft", "<cmd>Telescope treesitter<cr>", desc = "Treesitter" },
      { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
      { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jump List" },
      { "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
      { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
      { "<leader>fe", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<C-f>", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local trouble = require("trouble.sources.telescope")

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          file_ignore_patterns = {
            ".git/",
            "node_modules/",
            "build/",
            "dist/",
            "*.lock",
            "package-lock.json",
            "yarn.lock",
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<C-/>"] = actions.which_key,
              ["<c-t>"] = trouble.open,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["?"] = actions.which_key,
              ["<c-t>"] = trouble.open,
            },
          },
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          sorting_strategy = "ascending",
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          use_less = true,
          set_env = { ["COLORTERM"] = "truecolor" },
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
          live_grep = {
            additional_args = function(opts)
              return {"--hidden"}
            end
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              winblend = 10,
              width = 0.8,
              previewer = false,
              shorten_path = false,
            }),
          },
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                ["<A-c>"] = require("telescope._extensions.file_browser.actions").create,
                ["<S-CR>"] = require("telescope._extensions.file_browser.actions").create_from_prompt,
                ["<A-r>"] = require("telescope._extensions.file_browser.actions").rename,
                ["<A-m>"] = require("telescope._extensions.file_browser.actions").move,
                ["<A-y>"] = require("telescope._extensions.file_browser.actions").copy,
                ["<A-d>"] = require("telescope._extensions.file_browser.actions").remove,
                ["<C-o>"] = require("telescope._extensions.file_browser.actions").open,
                ["<C-g>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
                ["<C-e>"] = require("telescope._extensions.file_browser.actions").goto_home_dir,
                ["<C-w>"] = require("telescope._extensions.file_browser.actions").goto_cwd,
                ["<C-t>"] = require("telescope._extensions.file_browser.actions").change_cwd,
                ["<C-f>"] = require("telescope._extensions.file_browser.actions").toggle_browser,
                ["<C-h>"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
                ["<C-s>"] = require("telescope._extensions.file_browser.actions").toggle_all,
              },
              ["n"] = {
                ["c"] = require("telescope._extensions.file_browser.actions").create,
                ["r"] = require("telescope._extensions.file_browser.actions").rename,
                ["m"] = require("telescope._extensions.file_browser.actions").move,
                ["y"] = require("telescope._extensions.file_browser.actions").copy,
                ["d"] = require("telescope._extensions.file_browser.actions").remove,
                ["o"] = require("telescope._extensions.file_browser.actions").open,
                ["g"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
                ["e"] = require("telescope._extensions.file_browser.actions").goto_home_dir,
                ["w"] = require("telescope._extensions.file_browser.actions").goto_cwd,
                ["t"] = require("telescope._extensions.file_browser.actions").change_cwd,
                ["f"] = require("telescope._extensions.file_browser.actions").toggle_browser,
                ["h"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
                ["s"] = require("telescope._extensions.file_browser.actions").toggle_all,
              },
            },
          },
          project = {
            base_dirs = {
              vim.fn.expand("~/.config"),
              vim.fn.getcwd(),
            },
            hidden_files = true,
            theme = "dropdown",
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = true,
          },
        },
      })

      -- Load extensions
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
      telescope.load_extension("file_browser")
      telescope.load_extension("project")
    end,
  },

  -- Enhanced Breadcrumbs and Winbar
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    event = "LspAttach",
    config = function()
      require("nvim-navic").setup({
        icons = {
          File = " ",
          Module = " ",
          Namespace = " ",
          Package = " ",
          Class = " ",
          Method = " ",
          Property = " ",
          Field = " ",
          Constructor = " ",
          Enum = " ",
          Interface = " ",
          Function = " ",
          Variable = " ",
          Constant = " ",
          String = " ",
          Number = " ",
          Boolean = " ",
          Array = " ",
          Object = " ",
          Key = " ",
          Null = " ",
          EnumMember = " ",
          Struct = " ",
          Event = " ",
          Operator = " ",
          TypeParameter = " ",
        },
        lsp = {
          auto_attach = true,
          preference = nil,
        },
        highlight = true,
        separator = " > ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true,
        lazy_update_context = false,
        click = false,
      })

      -- Set up winbar
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, args.buf)
          end
        end,
      })

      -- Configure winbar display
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
  },

  -- Enhanced Notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      
      notify.setup({
        background_colour = "#000000",
        fps = 30,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = ""
        },
        level = 2,
        minimum_width = 50,
        render = "default",
        stages = "fade_in_slide_out",
        timeout = 5000,
        top_down = true
      })

      -- Set as default notify function
      vim.notify = notify

      -- Add keymap to dismiss notifications
      vim.keymap.set("n", "<leader>nd", function()
        notify.dismiss({ silent = true, pending = true })
      end, { desc = "Dismiss notifications" })
    end,
  },

  -- Enhanced Floating Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        on_create = function(t)
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.signcolumn = "no"
          
          local function set_terminal_keymaps()
            local opts = {buffer = 0}
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
          end
          
          vim.cmd('startinsert!')
          set_terminal_keymaps()
        end,
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
        hide_numbers = true,
        shade_filetypes = {},
        autochdir = false,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
          width = function()
            return math.floor(vim.o.columns * 0.8)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.8)
          end,
        },
        winbar = {
          enabled = false,
          name_formatter = function(term)
            return term.name
          end
        },
      })

      -- Custom terminal functions
      local Terminal = require('toggleterm.terminal').Terminal

      -- Lazygit terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
          width = function()
            return math.floor(vim.o.columns * 0.9)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.9)
          end,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      -- Python REPL terminal
      local python = Terminal:new({
        cmd = "python3",
        direction = "float",
        float_opts = {
          border = "double",
        },
      })

      -- Node.js REPL terminal
      local node = Terminal:new({
        cmd = "node",
        direction = "float",
        float_opts = {
          border = "double",
        },
      })

      -- Custom keymaps
      function _lazygit_toggle()
        lazygit:toggle()
      end

      function _python_toggle()
        python:toggle()
      end

      function _node_toggle()
        node:toggle()
      end

      -- Set keymaps
      vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float Terminal" })
      vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Horizontal Terminal" })
      vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Vertical Terminal" })
      vim.keymap.set("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", { desc = "LazyGit Terminal" })
      vim.keymap.set("n", "<leader>tp", "<cmd>lua _python_toggle()<CR>", { desc = "Python Terminal" })
      vim.keymap.set("n", "<leader>tn", "<cmd>lua _node_toggle()<CR>", { desc = "Node Terminal" })
    end,
  },

  -- Enhanced Buffer Management
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          style_preset = require("bufferline").style_preset.default,
          themable = true,
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = {
            icon = "▎",
            style = "icon",
          },
          buffer_close_icon = "󰅖",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 30,
          max_prefix_length = 30,
          truncate_names = true,
          tab_size = 21,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          custom_filter = function(buf_number, buf_numbers)
            if vim.bo[buf_number].filetype ~= "oil" then
              return true
            end
          end,
          offsets = {
            {
              filetype = "neo-tree",
              text = "Neo-tree",
              text_align = "left",
              separator = true,
            }
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          show_duplicate_prefix = true,
          persist_buffer_sort = true,
          move_wraps_at_ends = false,
          separator_style = "slant",
          enforce_regular_tabs = true,
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
          },
          sort_by = 'insert_after_current',
        },
        highlights = require("catppuccin.groups.integrations.bufferline").get()
      })

      -- Enhanced buffer navigation keymaps
      vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
      vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
      vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
      vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
      vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close Left Buffers" })
      vim.keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Close Right Buffers" })
      vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close Other Buffers" })
      vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Pin Buffer" })
      vim.keymap.set("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", { desc = "Close Unpinned Buffers" })
      vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
      vim.keymap.set("n", "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Delete Buffer (Force)" })
    end,
  },

  -- Enhanced Dashboard with Project Analytics
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { 
      "nvim-tree/nvim-web-devicons",
      "folke/persistence.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local dashboard = require("dashboard")
      
      -- Custom header with system info
      local function get_system_info()
        local version = vim.version()
        local plugins = require("lazy").stats()
        return string.format(
          "󰀵 Neovim v%d.%d.%d  󰏖 %d plugins loaded in %.2fms",
          version.major, version.minor, version.patch,
          plugins.loaded, plugins.startuptime
        )
      end

      dashboard.setup({
        theme = 'doom',
        config = {
          header = {
            "",
            "",
            "██╗   ██╗██╗████████╗██╗███╗   ███╗ █████╗ ████████╗███████╗",
            "██║   ██║██║╚══██╔══╝██║████╗ ████║██╔══██╗╚══██╔══╝██╔════╝",
            "██║   ██║██║   ██║   ██║██╔████╔██║███████║   ██║   █████╗  ",
            "██║   ██║██║   ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██╔══╝  ",
            "╚██████╔╝███████║   ██║   ██║██║ ╚═╝ ██║██║  ██║   ██║   ███████╗",
            " ╚═════╝ ╚══════╝   ╚═╝   ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝",
            "",
            "                     █ █▀▄ █▀▀   █▀▀ ▀▄▀ █▀█ █▀▀ █▀█ █ █▀▀ █▄█ █▀▀ █▀▀",
            "                     █ █▄▀ █▄▄   █▄▄ █▀█ █▀▀ █▄▄ █▀▄ █ █▄▄ █▀█ █▄▄ █▄▄",
            "",
            get_system_info(),
            "",
          },
          center = {
            {
              icon = ' ',
              icon_hl = 'Title',
              desc = 'Find File           ',
              desc_hl = 'String',
              key = 'f',
              keymap = 'SPC f f',
              key_hl = 'Number',
              action = 'Telescope find_files'
            },
            {
              icon = ' ',
              icon_hl = 'Title',
              desc = 'Recent Files        ',
              desc_hl = 'String',
              key = 'r',
              keymap = 'SPC f r',
              key_hl = 'Number',
              action = 'Telescope oldfiles'
            },
            {
              icon = ' ',
              icon_hl = 'Title',
              desc = 'Find Text           ',
              desc_hl = 'String',
              key = 'g',
              keymap = 'SPC f g',
              key_hl = 'Number',
              action = 'Telescope live_grep'
            },
            {
              icon = ' ',
              icon_hl = 'Title',
              desc = 'Projects            ',
              desc_hl = 'String',
              key = 'p',
              keymap = 'SPC f p',
              key_hl = 'Number',
              action = 'Telescope project'
            },
            {
              icon = ' ',
              icon_hl = 'Title',
              desc = 'Load Session        ',
              desc_hl = 'String',
              key = 's',
              keymap = 'SPC s l',
              key_hl = 'Number',
              action = 'SessionLoad'
            },
            {
              icon = ' ',
              icon_hl = 'Title',
              desc = 'Git Status          ',
              desc_hl = 'String',
              key = 'G',
              keymap = 'SPC g g',
              key_hl = 'Number',
              action = 'Neogit'
            },
            {
              icon = ' ',
              icon_hl = 'Title',
              desc = 'Package Manager     ',
              desc_hl = 'String',
              key = 'l',
              keymap = 'SPC l',
              key_hl = 'Number',
              action = 'Lazy'
            },
            {
              icon = ' ',
              icon_hl = 'Title',
              desc = 'Settings            ',
              desc_hl = 'String',
              key = 'c',
              keymap = 'SPC c',
              key_hl = 'Number',
              action = 'edit $MYVIMRC'
            },
            {
              icon = ' ',
              icon_hl = 'Title',
              desc = 'Quit                ',
              desc_hl = 'String',
              key = 'q',
              keymap = 'SPC q',
              key_hl = 'Number',
              action = 'qa'
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return {
              "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
              "",
              "🚀 Ultimate IDE Experience - Ready for Development!"
            }
          end,
        }
      })
    end,
  },


}
