-- plugins/quarto.lua
return {
  {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto' },
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
