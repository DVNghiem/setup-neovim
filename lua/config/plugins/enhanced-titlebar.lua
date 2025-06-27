return {
  -- Enhanced winbar with file titles and smooth styling
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      attach_navic = false,
      create_autocmd = false,
      show_dirname = false,
      show_basename = true,
      show_modified = false, -- Disable to avoid the error
      ellipsis = "…",
      separator = "",
      modifiers = {
        dirname = ":~:.",
        basename = "",
      },
      -- Beautiful icons for context
      symbols = {
        modified = "●",
        ellipsis = "…", 
        separator = "",
      },
      kinds = {
        File = "󰈙",
        Module = "",
        Namespace = "󰌗",
        Package = "",
        Class = "󰌗",
        Method = "󰆧",
        Property = "",
        Field = "",
        Constructor = "",
        Enum = "󰕘",
        Interface = "",
        Function = "󰊕",
        Variable = "󰆧",
        Constant = "󰏿",
        String = "󰀬",
        Number = "󰎠",
        Boolean = "◩",
        Array = "󰅪",
        Object = "󰅩",
        Key = "󰌋",
        Null = "󰟢",
        EnumMember = "",
        Struct = "󰌗",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰊄",
      },
      theme = {
        -- Use transparent background for seamless look
        normal = { bg = "NONE" },
        
        -- Context styling
        ellipsis = { fg = "#565f89" },
        separator = { fg = "#565f89" },
        modified = { fg = "#ff9e3b" },
        
        -- Directory and basename styling
        dirname = { fg = "#565f89", italic = true },
        basename = { fg = "#c3ccdc", bold = true },
        
        -- Context types styling
        context = { fg = "#7aa2f7" },
        context_file = { fg = "#c3ccdc" },
        context_module = { fg = "#bb9af7" },
        context_namespace = { fg = "#bb9af7" },
        context_package = { fg = "#bb9af7" },
        context_class = { fg = "#2ac3de" },
        context_method = { fg = "#7dcfff" },
        context_property = { fg = "#73daca" },
        context_field = { fg = "#73daca" },
        context_constructor = { fg = "#7dcfff" },
        context_enum = { fg = "#ff9e3b" },
        context_interface = { fg = "#2ac3de" },
        context_function = { fg = "#7dcfff" },
        context_variable = { fg = "#e0af68" },
        context_constant = { fg = "#ff9e3b" },
        context_string = { fg = "#9ece6a" },
        context_number = { fg = "#ff9e3b" },
        context_boolean = { fg = "#ff9e3b" },
        context_array = { fg = "#e0af68" },
        context_object = { fg = "#e0af68" },
        context_key = { fg = "#73daca" },
        context_null = { fg = "#565f89" },
        context_enum_member = { fg = "#73daca" },
        context_struct = { fg = "#2ac3de" },
        context_event = { fg = "#f7768e" },
        context_operator = { fg = "#89ddff" },
        context_type_parameter = { fg = "#2ac3de" },
      },
    },
    config = function(_, opts)
      require("barbecue").setup(opts)
      
      -- Auto-update winbar for smooth experience (simplified)
      vim.api.nvim_create_autocmd({
        "WinScrolled",
        "BufWinEnter", 
        "CursorHold",
        "InsertLeave",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },
  
  -- Enhanced title bar with file info
  {
    "b0o/incline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local helpers = require("incline.helpers")
      require("incline").setup({
        window = {
          padding = 1,
          margin = { horizontal = 1 },
          placement = {
            horizontal = "right",
            vertical = "top",
          },
          width = "fit",
          winhighlight = {
            active = {
              Normal = "InclineNormal",
              NonText = "InclineNormalNC",
            },
            inactive = {
              Normal = "InclineNormalNC", 
              NonText = "InclineNormalNC",
            },
          },
        },
        hide = {
          cursorline = false,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          
          local function get_git_diff()
            local icons = { removed = "", changed = "", added = "" }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. " " .. signs[name] .. " ", group = "Diff" .. name })
              end
            end
            return labels
          end
          
          local function get_diagnostic_label()
            local icons = { error = "", warn = "", info = "", hint = "" }
            local label = {}
            
            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. string.upper(severity:sub(1, 1)) .. severity:sub(2) })
              end
            end
            return label
          end
          
          local buffer = {
            { get_diagnostic_label() },
            { get_git_diff() },
            { ft_icon, guifg = ft_color }, 
            { " " },
            { filename, gui = modified and "bold,italic" or "bold" },
            { modified and " ●" or "" },
          }
          return buffer
        end,
      })
      
      -- Set up highlight groups
      vim.api.nvim_set_hl(0, "InclineNormal", { bg = "#1e2030", fg = "#c3ccdc" })
      vim.api.nvim_set_hl(0, "InclineNormalNC", { bg = "#16161e", fg = "#565f89" })
    end,
  },
}
