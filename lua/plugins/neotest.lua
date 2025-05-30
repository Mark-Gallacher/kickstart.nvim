return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "jfpedroza/neotest-elixir",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python"),
                require("neotest-elixir")
            }
        })
    end
}
