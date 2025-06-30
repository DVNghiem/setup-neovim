return {
  -- Smooth rounded corners and edges throughout the interface
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
        -- Hide search count messages
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        -- Minimize cmdline messages
        {
          filter = {
            event = "msg_showmode",
          },
          view = "mini",
        },
        -- Hide command echo messages
        {
          filter = {
            event = "msg_show",
            find = "^:",
          },
          opts = { skip = true },
        },
        -- Hide written messages
        {
          filter = {
            event = "msg_show",
            find = " written$",
          },
          opts = { skip = true },
        },
        -- Hide recording messages
        {
          filter = {
            event = "msg_show",
            find = "^recording",
          },
          opts = { skip = true },
        },
        -- Hide completion messages
        {
          filter = {
            event = "msg_show",
            find = "completion",
          },
          opts = { skip = true },
        },
      },
      cmdline = {
        enabled = true,
        view = "cmdline_popup", -- Use popup instead of cmdline
        opts = {},
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
        },
      },
      presets = {
        bottom_search = false, -- Don't use bottom search, use popup
        command_palette = false, -- Don't use command palette preset
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true, -- Rounded borders for LSP docs
      },
      views = {
        cmdline_popup = {
          position = {
            row = "30%", -- Center of screen vertically
            col = "50%", -- Center of screen horizontally
          },
          size = {
            min_width = 40,
            width = "auto",
            height = "auto",
          },
          border = {
            style = "rounded", -- Use rounded border so it's visible
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder",
            winblend = 10, -- Less transparent so it's more visible
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = "55%", -- Position slightly below the cmdline
            col = "50%",
          },
          size = {
            width = "auto",
            height = 8,
            max_height = 8,
            min_width = 40,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "FloatBorder" },
            winblend = 10,
          },
        },
      },
    },
  },

  -- Enhanced window decorations with smooth corners
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    opts = {
      input = {
        enabled = true,
        default_prompt = "Input",
        trim_prompt = true,
        title_pos = "left",
        insert_only = true,
        start_in_insert = true,
        border = "rounded", -- Smooth rounded corners
        relative = "cursor",
        prefer_width = 40,
        width = nil,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        buf_options = {},
        win_options = {
          wrap = false,
          list = true,
          listchars = "precedes:…,extends:…",
          sidescrolloff = 0,
          winblend = 15, -- More transparency for smoother look
        },
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<Up>"] = "HistoryPrev",
            ["<Down>"] = "HistoryNext",
          },
        },
      },
      select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        trim_prompt = true,
        telescope = function()
          return require("telescope.themes").get_ivy({
            winblend = 15,
            layout_config = {
              height = 0.4,
            },
          })
        end,
        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
          },
        },
        fzf_lua = {
          winopts = {
            height = 0.5,
            width = 0.5,
          },
        },
        nui = {
          position = "50%",
          size = nil,
          relative = "editor",
          border = {
            style = "rounded", -- Smooth rounded borders
          },
          buf_options = {
            swapfile = false,
            filetype = "DressingSelect",
          },
          win_options = {
            winblend = 15,
          },
          max_width = 80,
          max_height = 40,
          min_width = 40,
          min_height = 10,
        },
        builtin = {
          show_numbers = true,
          border = "rounded", -- Smooth rounded borders
          relative = "editor",
          buf_options = {},
          win_options = {
            winblend = 15,
            cursorline = true,
            cursorlineopt = "both",
          },
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },
          mappings = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },
        },
      },
    },
  },

  -- Smooth popup borders for completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        window = {
          completion = {
            border = "rounded", -- Smooth rounded borders
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            winblend = 15,
            scrollbar = false,
          },
          documentation = {
            border = "rounded", -- Smooth rounded borders
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            winblend = 15,
            max_height = 15,
            max_width = 60,
          },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind_icons = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "",
            }
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[LaTeX]",
            })[entry.source.name]
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      }
    end,
  },

  -- Smooth telescope borders
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = "➤ ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
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
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }, -- Smooth rounded corners
        winblend = 15,
        mappings = {
          i = {
            ["<C-n>"] = "move_selection_next",
            ["<C-p>"] = "move_selection_previous",
            ["<C-c>"] = "close",
            ["<Down>"] = "move_selection_next",
            ["<Up>"] = "move_selection_previous",
            ["<CR>"] = "select_default",
            ["<C-x>"] = "select_horizontal",
            ["<C-v>"] = "select_vertical",
            ["<C-t>"] = "select_tab",
            ["<C-u>"] = "preview_scrolling_up",
            ["<C-d>"] = "preview_scrolling_down",
          },
          n = {
            ["<esc>"] = "close",
            ["<CR>"] = "select_default",
            ["<C-x>"] = "select_horizontal",
            ["<C-v>"] = "select_vertical",
            ["<C-t>"] = "select_tab",
            ["j"] = "move_selection_next",
            ["k"] = "move_selection_previous",
            ["H"] = "move_to_top",
            ["M"] = "move_to_middle",
            ["L"] = "move_to_bottom",
            ["<Down>"] = "move_selection_next",
            ["<Up>"] = "move_selection_previous",
            ["gg"] = "move_to_top",
            ["G"] = "move_to_bottom",
            ["<C-u>"] = "preview_scrolling_up",
            ["<C-d>"] = "preview_scrolling_down",
          },
        },
      },
      pickers = {
        find_files = {
          theme = "ivy",
          previewer = false,
        },
        live_grep = {
          theme = "ivy",
        },
        buffers = {
          theme = "ivy",
          previewer = false,
        },
      },
    },
  },
}
