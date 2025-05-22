return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        local hooks = require("ibl.hooks")

        hooks.register('HIGHLIGHT_SETUP', function()
            vim.api.nvim_set_hl(0, "IndentUnFocused", { fg = "#2f3146" })
            vim.api.nvim_set_hl(0, "IndentFocused", { fg = "#444B6A" })
        end)

        require("ibl").setup({
            exclude = {
                filetypes = { "help", "dashboard", "TelescopePrompt", "Float" },
                buftypes = { "terminal", "nofile", "telescope" },
            },
            indent = {
                char = "▏",
                highlight = "IndentUnFocused",
            },
            scope = {
                char = "▏",
                highlight = "IndentFocused",
            }
        })
    end
}
