return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set("n", "<leader>ma", function() harpoon:list():add() end, { desc = "[M]ark Harpoon [A]dd" })
        vim.keymap.set("n", "<leader>mt", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "[M]ark Harpoon [T]oggle" })

        vim.keymap.set("n", "<leader>mh", function() harpoon:list():select(1) end,
            { desc = "[M]ark Harpoon Select Option 1" })
        vim.keymap.set("n", "<leader>mj", function() harpoon:list():select(2) end,
            { desc = "[M]ark Harpoon Select Option 2" })
        vim.keymap.set("n", "<leader>mk", function() harpoon:list():select(3) end,
            { desc = "[M]ark Harpoon Select Option 3" })
        vim.keymap.set("n", "<leader>ml", function() harpoon:list():select(4) end,
            { desc = "[M]ark Harpoon Select Option 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<leader>mp", function() harpoon:list():prev() end, { desc = "[M]ark Harpoon [P]revious" })
        vim.keymap.set("n", "<leader>mn", function() harpoon:list():next() end, { desc = "[M]ark Harpoon [N]ext" })
    end
}
