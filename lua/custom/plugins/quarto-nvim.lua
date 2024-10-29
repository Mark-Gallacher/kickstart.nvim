-- plugins/quarto.lua

-- INFO: These functions are mainly for utility

-- function to check if we are inside a code chunk
local function is_code_chunk()
  local current, _ = require('otter.keeper').get_current_language_context()

  if current then
    return true
  else
    return false
  end
end

-- function to insert or split code chunk - boilerplate though
local function insert_code_chunk(lang)
  -- send an escape keycode to vim - to ensure we are in normal mode?
  -- first obtain the keycode for <esc>, then send to nvim_feedkeys
  local k = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
  vim.api.nvim_feedkeys(k, 'n', true)

  -- if inside code_chunk - split it
  -- define the raw string first in form ```{lang} ```
  local keys
  if is_code_chunk() then
    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
  else
    keys = [[o```{]] .. lang .. [[}```<esc>O]]
  end

  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end

-- INFO: Here we are defining functions to create new code chunks - used to define keymaps later
local function insert_python_chunk()
  insert_code_chunk 'python'
end

local function insert_r_chunk()
  insert_code_chunk 'r'
end

local function insert_bash_chunk()
  insert_code_chunk 'bash'
end

return {
  {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto' },
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local q = require 'quarto'

      -- alias for keymap.set
      local set = vim.keymap.set

      -- function to simplify creating keymaps.
      local function nset(lhs, rhs, desc)
        set('n', lhs, rhs, { silent = true, noremap = true, desc = desc })
      end

      -- keymaps
      nset('<leader>qp', q.quartoPreview(), '[P]review the [Q]uarto Document')
      nset('<leader>qq', q.quartoClosePreview(), '[Q]uiet [Q]uarto Preview')
      nset('<leader>qa', q.activate(), '[Q]uarto [A]ctivate')

      nset('<leader>cr', insert_r_chunk, 'Insert a [C]ode chunk - [R]')
      nset('<leader>cp', insert_python_chunk, 'Insert a [C]ode chunk - [Python]')
      nset('<leader>cb', insert_bash_chunk, 'Insert a [C]ode chunk - [Bash]')

      nset('<leader>rr', q.quartoSendAll(), '[R]un Full Quarto File')
      nset('<leader>ra', q.quartoSendAbove(), '[R]un [A]bove Chunk')
      nset('<leader>rb', q.quartoSendBelow(), '[R]un [B]elow Chunk')
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
