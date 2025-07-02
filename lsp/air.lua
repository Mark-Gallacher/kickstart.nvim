-- R - air lsp and formaatter
---@type vim.lsp.Config
return {
  cmd = { 'air', 'language-server' },
  filetypes = { 'r', 'rmd', 'Rmd' },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, '.git') or vim.uv.os_homedir())
  end,
}
