-- todo-comments.lua

-- Highlight todo, notes, etc in comments
return {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
    config = function(opts)
        require("todo-comments").setup(opts)
        vim.keymap.set("n", "]t", function()
            require("todo-comments").jump_next()
        end, { desc = "Next todo comment" })

        vim.keymap.set("n", "[t", function()
            require("todo-comments").jump_prev()
        end, { desc = "Previous todo comment" })

        vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope keywords=TODO,FIX<CR>",
            { desc = "[S]earch [T]odo Comments (todo + fix)" })

        vim.keymap.set("n", "<leader>sT", "<cmd>TodoTelescope<CR>",
            { desc = "[S]earch [T]odo Comments (all)" })

        vim.keymap.set("n", "<leader>sq", "<cmd>TodoQuickFix keywords=TODO,FIX<CR>",
            { desc = "[S]earch Todo [Q]uickfix (todo + fix)" })

        vim.keymap.set("n", "<leader>sQ", "<cmd>TodoQuickFix<CR>", { desc = "[S]earch Todo [Q]uickfix (all)" })
    end
}
