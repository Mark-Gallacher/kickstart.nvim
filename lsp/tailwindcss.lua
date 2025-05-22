-- Tailwindcss
---@type vim.lsp.Config
---https://github.com/neovim/nvim-lspconfig/blob/master/lsp/tailwindcss.lua
return {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {
        "elixir",
        "eelixir",
        "html",
        "html-eex",
        "heex",
        "css",
        "scss"
    },
    root_markers = {
        "taindwind.config.js",
        "assets/taindwind.config.js",
        '.git',
    },
    settings = {
        tailwindCSS = {
            validate = true,
            lint = {
                cssConflict = 'warning',
                invalidApply = 'error',
                invalidScreen = 'error',
                invalidVariant = 'error',
                invalidConfigPath = 'error',
                invalidTailwindDirective = 'error',
                recommendedVariantOrder = 'warning',
            },
            classAttributes = {
                'class',
                'className',
                'class:list',
                'classList',
                'ngClass',
            },
            includeLanguages = {
                eelixir = 'html-eex',
                elixir = 'phoenix-heex',
                heex = 'phoenix-heex',
            }
        }

    },
}
