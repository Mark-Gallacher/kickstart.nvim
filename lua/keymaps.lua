-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set

local set = vim.keymap.set

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

-- Diagnostic keymaps
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Normally these are not good mappings, but worth trying to
-- make navigating tabs easier this way.
set('n', '<left>', 'gT', { desc = 'Move to Left Tap' })
set('n', '<right>', 'gt', { desc = 'Move to Right Tap' })

-- Change the height and width of a window more easier
set('n', '<M-,>', '<c-w>5<', { desc = 'Decrease the width of the window' })
set('n', '<M-.>', '<c-w>5>', { desc = 'Increase the width of the window' })
set('n', '<M-t>', '<c-w>+', { desc = 'Increase the Height of the window -- Taller' })
set('n', '<M-s>', '<c-w>-', { desc = 'Decrease the Height of the window -- Shorter' })

--set('n', '<leader>bn', ':bnext ', { desc = 'Move to Next Buffer' })
set('n', '<leader>bn', vim.cmd.bnext, { desc = 'Move to Next Buffer' })
set('n', '<leader>bp', vim.cmd.bprevious, { desc = 'Move to Previous Buffer' })
--set('n', '<leader>bp', ':bprevious ', { desc = 'Move to Previous /Buffer' })

-- Keymaps to execute the current line or file
set('n', '<leader>x', '<cmd>.lua<CR>', { desc = 'Execute the current line' })
set('n', '<leader><leader>x', '<cmd>%lua<CR>', { desc = 'Execute the current file' })

-- move cursor to bottom or top of window, then centre of cursor.
set('n', '<c-d>', '<c-d>zz', { desc = 'Move Cursor to bottom of window - then centre' })
set('n', '<c-u>', '<c-u>zz', { desc = 'Move Cursor to top of window - then centre' })

-- When you yank text and want to paste over text to replace it -
-- this keeps the yanked text in the register, puts deleted text in _ register
set({ 'n', 'v' }, '<leader>p', [["_dP]])

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- The general format is to give the autocommand a description, then a group as it is "listening" for our actions,
-- this isolates the function being called with an action and prevents duplicates callbacks. Then we tell it what to do
-- after it is finished - ie the callback function.
--
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- vim: ts=2 sts=2 sw=2 et
