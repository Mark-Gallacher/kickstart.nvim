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
      n.setup(opts)
      if active then
        vim.cmd.colorscheme(name)
      end
    end,
  }
end

return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  -- 'folke/tokyonight.nvim',
  -- -- 'tiagovla/tokyodark.nvim',
  -- priority = 1000, -- Make sure to load this before all the other start plugins.
  -- init = function()
  --   -- Load the colorscheme here.
  --   -- Like many other themes, this one has different styles, and you could load
  --   -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --
  --   vim.cmd.colorscheme 'tokyonight-night'
  --   -- vim.cmd.colorscheme 'neofusion'
  --
  --   -- You can configure highlights by doing something like:
  --   vim.cmd.hi 'Comment gui=none'
  -- end,

  -- tokyonight
  colourConfig('folke/tokyonight.nvim', 'tokyonight', { style = 'night' }, false),

  -- neofusion
  colourConfig('diegoulloao/neofusion.nvim', 'neofusion', {}, true),

  -- tokyodark
  colourConfig('tiagovla/tokyodark.nvim', 'tokyodark', {}, false),

  -- catppuccin
  colourConfig('catppuccin/nvim', 'catppuccin', { flavour = 'mocha' }, false),

  -- nordic
  colourConfig('AlexvZyl/nordic.nvim', 'nordic', {}, false),

  -- kanagawa theme = wave, dragon or lotus
  colourConfig('rebelot/kanagawa.nvim', 'kanagawa', { background = { dark = 'dragon' } }, false),
}
-- vim: ts=2 sts=2 sw=2 et
