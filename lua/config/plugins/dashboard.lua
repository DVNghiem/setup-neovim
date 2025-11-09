return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/persistence.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = function()
    -- Modern ASCII art logo
    local logo = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                        
         ⚡ Lightning Fast Development Environment
    ]]

    logo = string.rep("\n", 4) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
        tabline = false,
        winbar = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          {
            action = "Telescope find_files",
            desc = " Find Files",
            icon = " ",
            key = "f",
          },
          {
            action = "ene | startinsert",
            desc = " New File",
            icon = " ",
            key = "n",
          },
          {
            action = "Telescope oldfiles",
            desc = " Recent Files",
            icon = " ",
            key = "r",
          },
          {
            action = "Telescope live_grep",
            desc = " Find Text",
            icon = " ",
            key = "g",
          },
          {
            action = function()
              require("persistence").load()
            end,
            desc = " Restore Session",
            icon = " ",
            key = "s",
          },
          {
            action = "Telescope projects",
            desc = " Projects",
            icon = " ",
            key = "p",
          },
          {
            action = "Lazy",
            desc = " Lazy Plugin Manager",
            icon = "󰒲 ",
            key = "l",
          },
          {
            action = "Mason",
            desc = " Mason LSP Manager",
            icon = " ",
            key = "m",
          },
          {
            action = function()
              vim.api.nvim_input("<cmd>qa<cr>")
            end,
            desc = " Quit",
            icon = " ",
            key = "q",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {
            "",
            "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
          }
        end,
      },
    }

    -- Add padding for better visual spacing
    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- Auto-open on startup
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local msg = "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
        vim.notify(msg, vim.log.levels.INFO, { title = "Startup" })
      end,
    })

    return opts
  end,
}
