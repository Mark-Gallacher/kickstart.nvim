-- R
---@type vim.lsp.Config
return {
  cmd = { 'R', '--no-echo', '--no-save', '--no-init-file', '-e', 'languageserver::run()' },
  filetypes = { 'r', 'rmd', 'Rmd' },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, '.git') or vim.uv.os_homedir())
  end,
}
