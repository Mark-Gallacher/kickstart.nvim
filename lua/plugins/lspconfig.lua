-- LspConfig.lua
return {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        dependencies = {
            { 'Bilal2453/luvit-meta', lazy = true }
        },
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
        },
    },

    {
        "mason-org/mason.nvim",
        opts = {},
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            -- Notification Configuration
            { "j-hui/fidget.nvim", opts = {} },
        },
    },
}
