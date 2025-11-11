return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/persistence.nvim",
    "nvim-telescope/telescope.nvim",
    "robocorp/gp.nvim", -- AI
  },
  opts = function()
    local logo = [[
                                                        
         ███╗   ██╗      ██████╗ ███████╗██╗   ██╗       
        ████╗  ██║      ██╔══██╗██╔════╝██║   ██║      
        ██╔██╗ ██║█████╗██║  ██║█████╗  ██║   ██║      
        ██║╚██╗██║╚════╝██║  ██║██╔══╝  ╚██╗ ██╔╝      
        ██║ ╚████║      ██████╔╝███████╗ ╚████╔╝       
        ╚═╝  ╚═══╝      ╚═════╝ ╚══════╝  ╚═══╝      
        ⚡ Neovim Configuration by VanNghiem848 ⚡
    ]]

    local lines = vim.split(logo, "\n")
    local height = vim.o.lines * 0.6
    local pad = math.floor((height - #lines) * 0.35)
    logo = string.rep("\n", pad) .. table.concat(lines, "\n") .. "\n\n"

    local opts = {
      theme = "doom",
      hide = { statusline = false, tabline = false, winbar = false },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          {
            action = "Telescope find_files",
            desc = "Find File",
            icon = "󰱼 ",
            key = "f",
          },
          {
            action = "ene | startinsert",
            desc = "New File",
            icon = "󰝒 ",
            key = "n",
          },
          {
            action = "Telescope oldfiles",
            desc = "File Recent",
            icon = "󰋚 ",
            key = "r",
          },
          {
            action = "Telescope live_grep",
            desc = "Find content",
            icon = "󱡴 ",
            key = "g",
          },
          {
            action = function() require("persistence").load() end,
            desc = "Restore Session",
            icon = "󰁯 ",
            key = "s",
          },
          {
            action = "Telescope projects",
            desc = "Projects",
            icon = "󰉖 ",
            key = "p",
          },
          {
            action = function()
              require("gp").ChatNew()
            end,
            desc = "AI Chat (GPT)",
            icon = "󰧑 ",
            key = "a",
          },
          {
            action = "Lazy",
            desc = "Manage Plugins",
            icon = "󰒲 ",
            key = "l",
          },
          {
            action = "Mason",
            desc = "LSP & Tools",
            icon = "󰔡 ",
            key = "m",
          },
          {
            action = function() vim.api.nvim_input("<cmd>qa<cr>") end,
            desc = "Quit Neovim",
            icon = "󰩈 ",
            key = "q",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {
            "",
            "⚡ Neovim startup " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
            "   @vannghiem848",
          }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      local padding = 50 - #button.desc
      button.desc = button.desc .. string.rep(" ", padding)
      button.key_format = "  %s"
    end

    return opts
  end,
}