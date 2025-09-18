return {
  'folke/snacks.nvim',
  opts = {
    statuscolumn = {
      left = { 'mark', 'sign' },
      right = { 'fold', 'git' },
      git = { patterns = { 'GitSign' } },
    },
  },

  event = 'BufRead',
}
