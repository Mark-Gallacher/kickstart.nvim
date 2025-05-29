-- Read the LSP configuration Files
local lsp_files = {}
local lsp_dir = vim.fn.stdpath 'config' .. '/lsp/'

-- Iterate over all files inside the lsp directory
for _, file in ipairs(vim.fn.globpath(lsp_dir, '*.lua', false, true)) do
  -- `:t` gets filename, `:r` removes extension
  local name = vim.fn.fnamemodify(file, ':t:r')

  table.insert(lsp_files, name)
end

-- Enable the LSPs
vim.lsp.enable(lsp_files)
