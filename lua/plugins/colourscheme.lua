---Boilerplate for colour scheme configuration, there must be a better way.
---@param colourscheme string
---@param name string
---@param opts table
---@param active boolean
---@return table
local function colourConfig(colourscheme, name, opts, active)
    return {
        colourscheme,
        lazy = false,
        priority = 1000,
        config = function()
            local n = require(name)
            opts = opts or {}
            active = active or false

            n.setup(opts)

            if active then
                vim.o.background = "dark"
                vim.cmd.colorscheme(name)
            end
        end,
    }
end

return {

    -- tokyonight
    ---@diagnostic disable-next-line: missing-parameter
    colourConfig('folke/tokyonight.nvim', 'tokyonight', { style = 'night' }),

    -- neofusion
    ---@diagnostic disable-next-line: missing-parameter
    colourConfig('diegoulloao/neofusion.nvim', 'neofusion'),

    -- tokyodark
    ---@diagnostic disable-next-line: missing-parameter
    colourConfig('tiagovla/tokyodark.nvim', 'tokyodark', {}, true),

    -- catppuccin
    ---@diagnostic disable-next-line: missing-parameter
    colourConfig('catppuccin/nvim', 'catppuccin', { flavour = 'mocha' }),

    -- nordic
    ---@diagnostic disable-next-line: missing-parameter
    colourConfig('AlexvZyl/nordic.nvim', 'nordic'),

    -- kanagawa theme = wave, dragon or lotus
    ---@diagnostic disable-next-line: missing-parameter
    colourConfig('rebelot/kanagawa.nvim', 'kanagawa', { background = { dark = 'dragon' } }),

    -- monet theme
    ---@diagnostic disable-next-line: missing-parameter
    colourConfig("fynnfluegge/monet.nvim", "monet"),

    -- gruvbox
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.

            vim.g.gruvbox_material_background = 'hard'
            -- vim.cmd.colorscheme 'gruvbox-material'
        end,
    },
}
