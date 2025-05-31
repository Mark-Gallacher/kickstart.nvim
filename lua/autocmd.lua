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
            set('n', '<leader><leader>w', '<cmd>write<cr><cmd>!python %<cr>',
                { desc = 'write and execute the current file' })
        end
    end,
})

-- Autucommands to attach on buffers
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(b)
        local set = vim.keymap.set

        set('n', 'gd', function()
            vim.lsp.buf.definition()
        end, { buffer = b.buf, desc = 'LSP - [G]o to [D]efinition' })
        set('n', 'K', function()
            vim.lsp.buf.hover()
        end, { buffer = b.buf, desc = 'LSP - Hover' })
        set('n', '<leader>gs', function()
            vim.lsp.buf.workspace_symbol()
        end, { buffer = b.buf, desc = 'LSP - [G]et Workspace [S]ymbols' })
        set('n', '<leader>ge', function()
            vim.diagnostic.open_float()
        end, { buffer = b.buf, desc = 'LSP - [G]et Diagnostic [E]rrors?' })
        set('n', '<leader>ga', function()
            vim.lsp.buf.code_action()
        end, { buffer = b.buf, desc = 'LSP - [G]et Code [A]ction' })
        set('n', '<leader>gr', function()
            vim.lsp.buf.references()
        end, { buffer = b.buf, desc = 'LSP - [G]et [R]eference' })
        set('n', '<leader>gn', function()
            vim.lsp.buf.rename()
        end, { buffer = b.buf, desc = 'LSP - Reference re[N]ame' })
        set('i', '<C-s>', function()
            vim.lsp.buf.signature_help()
        end, { buffer = b.buf, desc = 'LSP - [S]ignature' })
    end,
})
