return {
    'nanozuki/tabby.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        local theme = {
            -- this is carbonfox theme
            fill = { bg = '#11121d' },
            head = { fg = '#7199ee', bg = '#11121d', },
            current_tab = { fg = '#11121d', bg = '#7199ee', style = 'bold' },
            tab = { fg = '#c5cdd9', bg = '#11121d', },
            win = { fg = '#11121d', bg = '#7199ee', },
            tail = { fg = '#7199ee', bg = '#11121d' },
        }

        require('tabby.tabline').set(function(line)
            return {

                line.tabs().foreach(function(tab)
                    local hl = tab.is_current() and theme.current_tab or theme.tab

                    -- remove count of wins in tab with [n+] included in tab.name()
                    local name = tab.name()
                    local index = string.find(name, "%[%d")
                    local tab_name = index and string.sub(name, 1, index - 1) or name

                    -- indicate if any of buffers in tab have unsaved changes
                    local modified = false
                    local win_ids = require('tabby.module.api').get_tab_wins(tab.id)
                    for _, win_id in ipairs(win_ids) do
                        if pcall(vim.api.nvim_win_get_buf, win_id) then
                            local bufid = vim.api.nvim_win_get_buf(win_id)
                            if vim.api.nvim_get_option_value("modified", { buf = bufid }) then
                                modified = true
                                break
                            end
                        end
                    end

                    return {
                        line.sep('', hl, theme.fill),
                        tab_name,
                        modified and '',
                        line.sep('', hl, theme.fill),
                        hl = hl,
                        margin = ' ',
                    }
                end),
                line.spacer(),

                hl = theme.fill,
            }
        end)
    end,
}
