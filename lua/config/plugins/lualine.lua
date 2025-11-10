return {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count

        local colors = {
            blue = "#65D1FF",
            green = "#3EFFDC",
            violet = "#FF61EF",
            yellow = "#FFDA7B",
            red = "#FF4A4A",
            fg = "#c3ccdc",
            bg = "#112638",
            inactive_bg = "#2c3043"
        }

        local my_lualine_theme = {
            normal = {
                a = {
                    bg = colors.blue,
                    fg = colors.bg,
                    gui = "bold"
                },
                b = {
                    bg = colors.bg,
                    fg = colors.fg
                },
                c = {
                    bg = colors.bg,
                    fg = colors.fg
                }
            },
            insert = {
                a = {
                    bg = colors.green,
                    fg = colors.bg,
                    gui = "bold"
                },
                b = {
                    bg = colors.bg,
                    fg = colors.fg
                },
                c = {
                    bg = colors.bg,
                    fg = colors.fg
                }
            },
            visual = {
                a = {
                    bg = colors.violet,
                    fg = colors.bg,
                    gui = "bold"
                },
                b = {
                    bg = colors.bg,
                    fg = colors.fg
                },
                c = {
                    bg = colors.bg,
                    fg = colors.fg
                }
            },
            command = {
                a = {
                    bg = colors.yellow,
                    fg = colors.bg,
                    gui = "bold"
                },
                b = {
                    bg = colors.bg,
                    fg = colors.fg
                },
                c = {
                    bg = colors.bg,
                    fg = colors.fg
                }
            },
            replace = {
                a = {
                    bg = colors.red,
                    fg = colors.bg,
                    gui = "bold"
                },
                b = {
                    bg = colors.bg,
                    fg = colors.fg
                },
                c = {
                    bg = colors.bg,
                    fg = colors.fg
                }
            },
            inactive = {
                a = {
                    bg = colors.inactive_bg,
                    fg = colors.semilightgray,
                    gui = "bold"
                },
                b = {
                    bg = colors.inactive_bg,
                    fg = colors.semilightgray
                },
                c = {
                    bg = colors.inactive_bg,
                    fg = colors.semilightgray
                }
            }
        }

        -- configure lualine with modified theme
        lualine.setup({
            tabline = {
                lualine_a = {'buffers'},
                lualine_b = {'branch'},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {'tabs'}
            },
            extensions = {'neo-tree', 'lazy', 'trouble', 'mason', 'nvim-dap-ui'},
            options = {
                theme = 'dracula',
                component_separators = '',
                section_separators = {
                    left = '',
                    right = ''
                },
                globalstatus = true
            },
            sections = {
                lualine_c = {{
                    'filename',
                    file_status = true,
                    newfile_status = true,
                    path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                    symbols = {
                        modified = '󰷥',
                        readonly = '',
                        unnamed = '[No Name]',
                        newfile = ''
                    }
                }}
            }
        })
    end
}
