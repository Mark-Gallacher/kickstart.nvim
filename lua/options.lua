-- [[ Setting options ]]

-- See `:help vim.opt`
require 'autocmd'

vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5

-- Enable mouse mode, can be useful for resizing splits for example!
-- Disable for Visual Mode
vim.opt.mouse = 'nic'
vim.opt.mousescroll = 'ver:1,hor:0' -- disable horizontal scroll

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.swapfile = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = false
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Have a global status bar instead
vim.o.laststatus = 3

-- Set Default Conceal level to 2
vim.opt.conceallevel = 2

-- Folds
function _G.fold_lines()
  local n_lines = vim.v.foldend - vim.v.foldstart
  local lstart = string.gsub(vim.fn.getline(vim.v.foldstart), '\t', '    ')
  -- local lend = string.gsub(vim.fn.getline(vim.v.foldend), '\t', '')

  local text = ('%s [%d lines]'):format(lstart, n_lines)
  return text
end

vim.o.foldmethod = 'expr'
-- vim.opt.foldexpr = 'v:lua.vim.foldexpr()' -- This didn't work for python file - issue with lsp?
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = 'v:lua.fold_lines()'
vim.o.fillchars = 'eob: ,fold: ,foldopen: ,foldsep: ,foldclose:>'
vim.o.foldlevel = 20
vim.o.foldcolumn = '1'
vim.o.foldopen = 'insert,mark,search,tag'
