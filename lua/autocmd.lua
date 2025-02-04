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
  pattern = { '*.qmd', '*.md' },
  -- turn on spell checker
  callback = function()
    vim.keymap.set('n', '<leader>tc', function()
      local level = vim.o.conceallevel

      if level == 0 then
        vim.opt.conceallevel = 1
      elseif level == 1 then
        vim.opt.conceallevel = 0
      end
    end)
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

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Changing the Behaviour of <space>[<space>]x by filetype',
  group = group,
  callback = function()
    local file = vim.bo.filetype
    local set = vim.keymap.set

    if file == 'lua' then
      -- INFO: RUNNING LUA FILES
      -- Keymaps to execute the current line or file
      set('n', '<leader>x', '<cmd>.lua<CR>', { desc = 'Execute the current line' })
      set('v', '<leader>x', "<cmd>'<,'>lua<cr>", { desc = 'execute selected area' })
      set('n', '<leader><leader>x', '<cmd>%lua<CR>', { desc = 'Execute the current file' })
      set('n', '<leader><leader>w', '<cmd>write<cr><cmd>%lua<cr>', { desc = 'write and execute the current file' })
    end

    if file == 'python' then
      -- info: running lua files
      -- keymaps to execute the current line or file
      set('v', '<leader>x', "<cmd>'<,'> !python<cr>", { desc = 'execute selected area' })
      set('n', '<leader><leader>x', '<cmd>!python %<cr>', { desc = 'execute the current file' })
      set('n', '<leader><leader>w', '<cmd>write<cr><cmd>!python %<cr>', { desc = 'write and execute the current file' })
    end
  end,
})
