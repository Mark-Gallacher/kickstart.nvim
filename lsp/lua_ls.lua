-- Lua
---@type vim.lsp.Config
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        '.git',
    },
    settings = {
        Lua = {
            hint = { enable = true },
            telemetry = { enable = false },
            workspace = { checkThirdParty = false },
            completion = { callSnippet = "Replace" },
            diagnostics = {
                globals = { "vim" },
                disable = { "missing-fields" }
            },
        },
    },
}
