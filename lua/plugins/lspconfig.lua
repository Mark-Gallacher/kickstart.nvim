-- LspConfig.lua

-- local lls_root = os.getenv("localappdata") .. "/lua-language-server"
-- local lls_main = lls_root .. "/main.lua"
-- this could be windows specific

local check_os = function()
    local unix = vim.fn.has 'unix'
    local windows = vim.fn.has 'windows'

    if unix == 1 and windows == 0 then
        return 'unix'
    end

    if unix == 0 and windows == 1 then
        return 'windows'
    end

    return nil
end

local get_lua_cmd = function()
    local my_os = check_os()
    if my_os == 'windows' then
        local path = os.getenv 'localappdata'

        return { 'lua-language-server', '-E', path .. '/lua-language-server/main.lua' }
    end
    return { 'lua-language-server' }
end

local get_lexical_cmd = function()
    local my_os = check_os()
    if my_os == 'windows' then
        return nil
    end

    return { '/home/markgallacher/.config/lexical/_build/dev/package/lexical/bin/start_lexical.sh' }
end

local lua_cmd = get_lua_cmd()

return {
    -- LSP Plugins
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
        },
    },

    { 'Bilal2453/luvit-meta', lazy = true },

    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',

        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { 'mason-org/mason.nvim', config = true },
            'mason-org/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            'saghen/blink.cmp',

            -- Useful status updates for LSP.
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',    opts = {} },
        },

        opts = {

            servers = {

                -- Python LSP
                -- pyright = {
                --     cmd = { 'pyright-langserver', '--stdio' },
                --     filetypes = { 'python', 'py' },
                -- },
                ruff = {},

                -- R LSP
                r_language_server = {
                    cmd = { 'R', '--no-echo', '-e', 'languageserver::run()' },
                    filetypes = { 'r', 'rmd', 'Rmd' },
                },

                -- BASH LSP
                bashls = {
                    cmd = { 'bash-language-server', 'start' },
                    filetypes = { 'sh' },
                    settings = {
                        bashIde = {
                            globPattern = '*@(.sh|.inc|.bash|.command)',
                        },
                    },
                },

                marksman = {
                    cmd = { 'marksman', 'server' },
                    filetypes = { 'markdown', 'markdown.mdx', 'quarto' },
                },

                -- -- C, C++
                -- clangd = {
                --   cmd = { 'clangd' },
                -- },

                -- Lua LSP

                lua_ls = {
                    -- cmd = { "lua-language-server", "-E", lls_main },
                    cmd = lua_cmd,
                    filetypes = { 'lua' },
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },

                lexical = {
                    cmd = get_lexical_cmd(),
                    root_dir = function(fname)
                        local lspconfig = require 'lspconfig'
                        return lspconfig.util.root_pattern('mix.exs', '.git')(fname) or vim.loop.cwd()
                    end,
                    filetypes = { 'elixir', 'eelixir', 'heex' },
                    -- optional settings
                    settings = {},
                },

                tailwindcss_language_server = {},

                html_lsp = { filetypes = { 'html', 'heex' } },
            },
        },

        config = function(_, opts)
            local lspconfig = require 'lspconfig'
            local ensure_installed = vim.tbl_keys(opts.servers or {})

            -- extend the list to include lua formatter
            -- vim.list_extend(ensure_installed, { 'stylua' })

            -- use mason to ensure every server is installed.
            require('mason').setup()
            require('mason-lspconfig').setup { ensure_installed = ensure_installed }
            require('lspconfig.ui.windows').default_options.border = 'rounded'

            -- for every server, set it up and ensure it knows about blink.
            for server, config in pairs(opts.servers) do
                -- passing config.capabilities to blink.cmp merges with the capabilities in your
                -- `opts[server].capabilities, if you've defined it
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                    -- to define small helper and utility functions so you don't have to repeat yourself.
                    --
                    -- In this case, we create a function that lets us more easily define mappings specific
                    -- for LSP related items. It sets the mode, buffer and description for us each time.
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

                    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

                    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

                    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                    map('K', vim.lsp.buf.hover, 'Hover Documentation')

                    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end

                    -- The following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are  using supports them
                    --
                    -- This may be unwanted, since they displace some of your code
                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        end, '[T]oggle Inlay [H]ints')
                    end
                end,
            })
        end,
    },
}
