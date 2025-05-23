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
        keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
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
            'vim-pandoc/vim-pandoc-syntax',
        },
        config = function()
            local q = require 'quarto'
            local runner = require 'quarto.runner'

            q.quartoSend = runner.run_cell
            q.quartoSendAbove = runner.run_above
            q.quartoSendBelow = runner.run_below
            q.quartoSendAll = runner.run_all
            q.quartoSendRange = runner.run_range
            q.quartoSendLine = runner.run_line

            -- alias for keymap.set
            local set = vim.keymap.set

            -- function to simplify creating keymaps.
            local function nset(lhs, rhs, desc)
                set('n', lhs, rhs, { silent = true, noremap = true, desc = desc })
            end

            -- Function to send R table to console - using DT to make the print pretty
            local function show_r_table()
                local node = vim.treesitter.get_node { ignore_injections = false }
                assert(node, 'no symbol found under cursor')
                local text = vim.treesitter.get_node_text(node, 0)
                local cmd = [[call slime#send("DT::datatable(]] .. text .. [[)" . "\r")]]
                vim.cmd(cmd)
            end

            -- keymaps - might be neat to not use lua functions
            -- INFO: Generates the preview i.e. runs quarto preview on current buffer
            nset('<leader>qp', function()
                q.quartoPreview { args = '--output-dir quarto' }
            end, '[P]review the [Q]uarto Document')

            nset('<leader>qq', function()
                q.quartoClosePreview { args = '--output-dir quarto' }
            end, '[Q]uiet [Q]uarto Preview')

            nset('<leader>qa', function()
                q.activate()
            end, '[Q]uarto [A]ctivate')

            -- INFO: Insert Code Chunks
            nset('<leader>cr', function()
                insert_r_chunk()
            end, 'Insert a [C]ode chunk - [R]')

            nset('<leader>cp', function()
                insert_python_chunk()
            end, 'Insert a [C]ode chunk - [Python]')

            nset('<leader>cb', function()
                insert_bash_chunk()
            end, 'Insert a [C]ode chunk - [Bash]')

            -- INFO: Runs blocks of code (Requires an active terminal to be open)
            nset('<leader>rr', function()
                q.quartoSendAll()
            end, '[R]un Full Quarto File')

            nset('<leader>ra', function()
                q.quartoSendAbove()
            end, '[R]un [A]bove Chunk')

            nset('<leader>rb', function()
                q.quartoSendBelow()
            end, '[R]un [B]elow Chunk')

            nset('<leader>rl', function()
                q.quartoSendLine()
            end, '[R]un [L]ine')

            nset('<leader>rc', function()
                q.quartoSend()
            end, '[R]un [C]ell')

            nset('<leader>rt', function()
                show_r_table()
            end, '[R]ender [T]able in Console')
        end,
    },
    { -- send code from python/r/qmd documets to a terminal or REPL
        -- like ipython, R, bash
        'jpalardy/vim-slime',
        dev = false,
        init = function()
            vim.b['quarto_is_python_chunk'] = false
            Quarto_is_in_python_chunk = function()
                require('otter.tools.functions').is_otter_language_context 'python'
            end

            vim.cmd [[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
      return [a:text, "\n"]
      else
      return [a:text]
      end
      end
      endfunction
      ]]

            vim.g.slime_target = 'neovim'
            vim.g.slime_no_mappings = true
            vim.g.slime_python_ipython = 1
        end,

        config = function()
            vim.g.slime_input_pid = false
            vim.g.slime_suggest_default = true
            vim.g.slime_menu_config = false
            vim.g.slime_neovim_ignore_unlisted = true

            local function mark_terminal()
                local job_id = vim.b.terminal_job_id
                vim.print('job_id: ' .. job_id)
            end

            local function set_terminal()
                vim.fn.call('slime#config', {})
            end
            vim.keymap.set('n', '<leader>tm', mark_terminal, { desc = '[T]erminal [m]ark' })
            vim.keymap.set('n', '<leader>ts', set_terminal, { desc = '[T]erminal [s]et' })
        end,
    },
}
