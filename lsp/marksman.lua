-- Markdown
---@type vim.lsp.Config
return {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "quarto", "markdown.mdx" },
    root_markers = { '.marksman.toml', '.git' },
}
