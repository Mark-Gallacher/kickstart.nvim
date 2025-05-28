return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000,    -- needs to be loaded in first
    config = function()
        require('tiny-inline-diagnostic').setup({
            preset = "modern",
            options = {
                set_arrow_to_diag_color = true,
                multilines = {
                    enabled = true,
                    always_show = false
                },
                breakline = {
                    enabled = true
                },
            }
        })
        -- Configure the diagnostics
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = false,
            update_in_insert = true,
            -- underline = true,
            severity_sort = true,
            float = {
                focusable = true,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.HINT] = "●",
                    [vim.diagnostic.severity.INFO] = "●",
                    [vim.diagnostic.severity.WARN] = "●",
                    [vim.diagnostic.severity.ERROR] = "●",
                },
            },
        })
    end
}
