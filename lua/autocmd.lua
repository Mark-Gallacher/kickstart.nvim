local group = vim.api.nvim_create_augroup('custom_autocommands', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
  -- only for quarto or markdown
  pattern = { '*.qmd', '*.md' },
  -- turn on spell checker
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = 'en_gb'
    vim.opt.conceallevel = 1
  end,
  group = group,
})

vim.api.nvim_create_autocmd('BufEnter', {
  -- only for quarto or markdown
  pattern = { '*.py' },
  -- turn on spell checker
  callback = function()
    -- specifying the virtual environment for python in windows
    -- this should be an autocommand
    vim.g.python3_host_prog = 'C:/Users/markg/.virtualenvs/vim-IQcaHTq4/Scripts/python.exe'
  end,
  group = group,
})
