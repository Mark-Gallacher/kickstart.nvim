-- plugins/gitsigns.lua
return {
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        dependencies = {
            "sindrets/diffview.nvim",
        },
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                local gitsigns = require 'gitsigns'
                require 'diffview'.setup({
                    file_panel = {
                        win_config = {
                            width = 0, --default is 35
                        },
                    },
                    file_history_panel = {
                        win_config = {
                            height = 10, --default is 16
                        },
                    }
                })

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal { ']c', bang = true }
                    else
                        gitsigns.nav_hunk 'next'
                    end
                end, { desc = 'Jump to next git [c]hange' })

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal { '[c', bang = true }
                    else
                        gitsigns.nav_hunk 'prev'
                    end
                end, { desc = 'Jump to previous git [c]hange' })

                -- Actions
                -- visual mode
                map('v', '<leader>hs', function()
                    gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'stage git hunk' })
                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'reset git hunk' })
                -- normal mode
                map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
                map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
                map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
                map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
                map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
                map('n', '<leader>hP', gitsigns.preview_hunk_inline, { desc = 'git [P]review deleted lines' })
                map('n', '<leader>hb', gitsigns.toggle_current_line_blame, { desc = 'git [b]lame line' })
                map('n', '<leader>hd', "<cmd>DiffviewOpen<cr><esc><c-w>l", { desc = 'git [d]iff against index' })
                map('n', '<leader>hh', "<cmd>DiffviewFileHistory %<cr>", { desc = 'git [h]istory for file' })
                map('n', '<leader>hm', "<cmd>DiffviewOpen origin/main<cr><esc><c-w>l",
                    { desc = 'git [d]iff against main' })
                map('n', '<leader>hM', "<cmd>DiffviewOpen origin/master<cr><esc><c-w>l",
                    { desc = 'git [d]iff against master' })
                map('n', '<leader>hD', function()
                    gitsigns.diffthis '@'
                end, { desc = 'git [D]iff against last commit' })
            end,
        }
    }
}
