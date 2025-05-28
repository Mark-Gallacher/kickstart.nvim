-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set

local set = vim.keymap.set

-- Function to make new terminal more easily
local function new_terminal(lang)
    vim.cmd('vsplit term://' .. lang)
end

local function new_terminal_python()
    new_terminal 'python'
end

local function new_terminal_r()
    new_terminal 'R --no-save'
end

local function new_terminal_ipython()
    new_terminal 'ipython --no-confirm-exit'
end

local function new_terminal_shell()
    new_terminal '$SHELL'
end

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

set('n', '<leader>;w', '<cmd>w<CR>', { desc = 'Write File' })
set('n', '<leader>;W', '<cmd>wa<CR>', { desc = 'Write File' })
set('n', '<leader>;x', '<cmd>wq<CR>', { desc = 'Write and Exit File' })
set('n', '<leader>;q', '<cmd>q<CR>', { desc = 'Exit File' })
set('n', '<leader>;Q', '<cmd>qa<CR>', { desc = 'Exit File' })

-- INFO: DIAGNOSTIC KEYMAPS
set('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end,
    { desc = 'Go to previous [D]iagnostic message' })
set('n', ']d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
    { desc = 'Go to next [D]iagnostic message' })

set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- INFO: WINDOWS, TABS and BUFFERS
--  See `:help wincmd` for a list of all window commands
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
set('t', '<C-h>', '<C-\\><C-N><C-w><C-h>', { desc = 'Move focus to the left window' })
set('t', '<C-l>', '<C-\\><C-N><C-w><C-l>', { desc = 'Move focus to the right window' })
set('t', '<C-j>', '<C-\\><C-N><C-w><C-j>', { desc = 'Move focus to the lower window' })
set('t', '<C-k>', '<C-\\><C-N><C-w><C-k>', { desc = 'Move focus to the upper window' })

set("n", "<leader>wv", "<C-w>v", { desc = "Create [W]indow [V]ertical Split" })
set("n", "<leader>ws", "<C-w>s", { desc = "Create [W]indow [S]plit" })

-- Normally these are not good mappings, but worth trying to
-- make navigating tabs easier this way.
set('n', '<left>', 'gT', { desc = 'Move to Left Tap' })
set('n', '<right>', 'gt', { desc = 'Move to Right Tap' })

-- Change the height and width of a window more easier
set('n', '<M-,>', '<c-w>5<', { desc = 'Decrease the width of the window' })
set('n', '<M-.>', '<c-w>5>', { desc = 'Increase the width of the window' })
set('n', '<M-t>', '<c-w>+', { desc = 'Increase the Height of the window -- Taller' })
set('n', '<M-s>', '<c-w>-', { desc = 'Decrease the Height of the window -- Shorter' })

set('n', '<leader>bn', vim.cmd.bnext, { desc = 'Move to Next Buffer' })
set('n', '<leader>bp', vim.cmd.bprevious, { desc = 'Move to Previous Buffer' })

-- move cursor to bottom or top of window, then centre of cursor.
set('n', '<c-d>', '<c-d>zz', { desc = 'Move Cursor to bottom of window - then centre' })
set('n', '<c-u>', '<c-u>zz', { desc = 'Move Cursor to top of window - then centre' })

-- Move selected lines with shift+j or shift+k
set('v', 'J', ":m '>+1<CR>gv=gv")
set('v', 'K', ":m '<-2<CR>gv=gv")

-- When you yank text and want to paste over text to replace it -
-- this keeps the yanked text in the register, puts deleted text in _ register
set({ 'n', 'v' }, '<leader>p', [["_dP]])
-- set({ 'n', 'v' }, '<leader>d', [["_d]])

-- New terminals
set('n', '<leader>tr', function()
    new_terminal_r()
end, { desc = 'Create new [T]erminal - [R]' })

set('n', '<leader>tp', function()
    new_terminal_python()
end, { desc = 'Create new [T]erminal - [Python]' })

set('n', '<leader>ti', function()
    new_terminal_ipython()
end, { desc = 'Create new [T]erminal - [IPython]' })

set('n', '<leader>ts', function()
    new_terminal_shell()
end, { desc = 'Create new [T]erminal - [Shell]' })


-- Toggle virtual lines and text
set('n', '<leader>dt', function()
    vim.diagnostic.config {
        virtual_lines = not vim.diagnostic.config().virtual_lines,
        -- virtual_text = not vim.diagnostic.config().virtual_text,
    }
    require("tiny-inline-diagnostic").toggle()
end, { desc = '[D]iagnostics [T]oggle - virtual lines and virtual text' })

set('n', '<leader>dh', function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = '[D]iagnostics [H]ide - all' })
