-- Bash
---@type vim.lsp.Config
return {
    cmd = { "bash-language-server", "start" },
    settings = {
        bashIde = {
            -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
            globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
        },
    },
    filetypes = { 'bash', 'sh' },
    root_markers = { '.git' },
}
