-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Autocommands ]]
require 'autocmd'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- [[ LSP SETUP ]]
require 'lsp'

-- Read the LSP configuration Files
local lsp_dir = vim.fn.stdpath 'config' .. '/lsp/'

-- Iterate over all files inside the lsp directory
for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
    if file:match("%.lua$") then
        local name = file:gsub("%.lua$", "")
        vim.lsp.enable(name)
    end
end
