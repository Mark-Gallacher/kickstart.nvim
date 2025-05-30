return {
    'stevearc/quicker.nvim',
    event = "VimEnter",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
    config = function()
        require("quicker").setup({
            keys = {
                {
                    ">",
                    function()
                        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                    end,
                    desc = "Expand quickfix context",
                },
                {
                    "<",
                    function()
                        require("quicker").collapse()
                    end,
                    desc = "Collapse quickfix context",
                },
            },
            type_icons = {
                H = "●",
                I = "●",
                N = "●",
                W = "●",
                E = "●",
            }
        })

        vim.keymap.set("n", "<leader>q", function()
            require("quicker").toggle()
        end, {
            desc = "Toggle quickfix",
        })

        vim.keymap.set("n", "<leader>l", function()
            require("quicker").toggle({ loclist = true })
        end, {
            desc = "Toggle loclist",
        })
    end
}
