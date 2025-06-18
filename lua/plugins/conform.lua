-- conform.lua

return {
  -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre', 'BufEnter' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    -- silence the notification if conform runs into an error
    notify_on_error = false,

    -- customise the behaviour of the linters, based on filetype in this example.
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },

    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      python = { 'ruff_format' },
      sql = { 'sqlfluff' },
      rmd = { 'injected' },
      quarto = { 'injected' },
      r = { 'air' },
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
