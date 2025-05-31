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
        vim.uv.cwd()
    },
    settings = {
        Lua = {
            runtime = {version = "LuaJIT"},
            hint = { enable = true },
            telemetry = { enable = false },
            workspace = { 
                preloadFileSize = 500,
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME},
            },
            completion = { callSnippet = "Replace" },
            diagnostics = {
                globals = { "vim" },
                disable = { "missing-fields" }
            },
        },
    },
}


