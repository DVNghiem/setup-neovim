local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
---when inside a snippet, seeks to the nearest luasnip field if possible, and checks if it is jumpable
---@param dir number 1 for forward, -1 for backward; defaults to 1
---@return boolean true if a jumpable luasnip field is found while inside a snippet
local function jumpable(dir)
    local luasnip_ok, luasnip = pcall(require, "luasnip")
    if not luasnip_ok then
        return false
    end

    local win_get_cursor = vim.api.nvim_win_get_cursor
    local get_current_buf = vim.api.nvim_get_current_buf

    ---sets the current buffer's luasnip to the one nearest the cursor
    ---@return boolean true if a node is found, false otherwise
    local function seek_luasnip_cursor_node()
        -- TODO(kylo252): upstream this
        -- for outdated versions of luasnip
        if not luasnip.session.current_nodes then
            return false
        end

        local node = luasnip.session.current_nodes[get_current_buf()]
        if not node then
            return false
        end

        local snippet = node.parent.snippet
        local exit_node = snippet.insert_nodes[0]

        local pos = win_get_cursor(0)
        pos[1] = pos[1] - 1

        -- exit early if we're past the exit node
        if exit_node then
            local exit_pos_end = exit_node.mark:pos_end()
            if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
                snippet:remove_from_jumplist()
                luasnip.session.current_nodes[get_current_buf()] = nil

                return false
            end
        end

        node = snippet.inner_first:jump_into(1, true)
        while node ~= nil and node.next ~= nil and node ~= snippet do
            local n_next = node.next
            local next_pos = n_next and n_next.mark:pos_begin()
            local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1]) or
                                  (pos[1] == next_pos[1] and pos[2] < next_pos[2])

            -- Past unmarked exit node, exit early
            if n_next == nil or n_next == snippet.next then
                snippet:remove_from_jumplist()
                luasnip.session.current_nodes[get_current_buf()] = nil

                return false
            end

            if candidate then
                luasnip.session.current_nodes[get_current_buf()] = node
                return true
            end

            local ok
            ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
            if not ok then
                snippet:remove_from_jumplist()
                luasnip.session.current_nodes[get_current_buf()] = nil

                return false
            end
        end

        -- No candidate, but have an exit node
        if exit_node then
            -- to jump to the exit node, seek to snippet
            luasnip.session.current_nodes[get_current_buf()] = snippet
            return true
        end

        -- No exit node, exit from snippet
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil
        return false
    end

    if dir == -1 then
        return luasnip.in_snippet() and luasnip.jumpable(-1)
    else
        return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
    end
end
return {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline",
                    "saadparwaiz1/cmp_luasnip", "onsails/lspkind.nvim", "rafamadriz/friendly-snippets"},
    opts = function()
        vim.api.nvim_set_hl(0, "CmpGhostText", {
            link = "Comment",
            default = true
        })
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local kind_icons = require("config.cores.icon").kinds

        local function jumpable(dir)
            local luasnip_ok, luasnip = pcall(require, "luasnip")
            if not luasnip_ok then
                return false
            end
            if dir == -1 then
                return luasnip.in_snippet() and luasnip.jumpable(-1)
            else
                return luasnip.expand_or_locally_jumpable() or (luasnip.in_snippet() and luasnip.jumpable(1))
            end
        end

        return {
            completion = {
                completeopt = "menu,menuone,noinsert"
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({
                    select = false
                }),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif jumpable(1) then
                        luasnip.jump(1)
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, {"i", "s"}),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {"i", "s"})
            }),

            sources = cmp.config.sources({{
                name = "copilot",
                priority = 1000,
                max_item_count = 3
            }, {
                name = "nvim_lsp",
                priority = 750
            }, {
                name = "luasnip",
                priority = 600
            }, {
                name = "buffer",
                priority = 500
            }, {
                name = "path",
                priority = 250
            }}),

            formatting = {
                fields = {"kind", "abbr", "menu"},
                format = function(entry, vim_item)
                    vim_item.kind = kind_icons[vim_item.kind] or "?"
                    vim_item.menu = ({
                        copilot = "Copilot",
                        nvim_lsp = "LSP",
                        luasnip = "Snippet",
                        buffer = "Buffer",
                        path = "Path"
                    })[entry.source.name]
                    return vim_item
                end
            },

            window = {
                completion = {
                    border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None"
                },
                documentation = {
                    border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}
                }
            },

            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText"
                }
            }
        }
    end,

    config = function(_, opts)
        local cmp = require("cmp")

        -- Main setup
        for _, source in ipairs(opts.sources) do
            source.group_index = source.group_index or 1
        end
        cmp.setup(opts)

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({{
                name = "path"
            }}, {{
                name = "cmdline"
            }}),
            formatting = {
                fields = {"abbr"}
            }
        })

        cmp.setup.cmdline({"/", "?"}, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {{
                name = "buffer"
            }},
            formatting = {
                fields = {"abbr"}
            }
        })
    end
}
