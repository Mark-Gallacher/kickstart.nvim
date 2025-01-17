return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      {

        'L3MON4D3/LuaSnip',
        -- follow latest release.
        version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = 'make install_jsregexp',

        config = function()
          local ls = require 'luasnip'

          vim.keymap.set({ 'i' }, '<C-y>', function()
            ls.expand()
          end, { silent = true })
          vim.keymap.set({ 'i', 's' }, '<C-l>', function()
            ls.jump(1)
          end, { silent = true })
          vim.keymap.set({ 'i', 's' }, '<C-h>', function()
            ls.jump(-1)
          end, { silent = true })

          vim.keymap.set({ 'i', 's' }, '<C-E>', function()
            if ls.choice_active() then
              ls.change_choice(1)
            end
          end, { silent = true })

          ls.config.setup {

            enable_autosnippets = true,
            update_events = { 'TextChanged', 'TextChangedI' },
          }

          -- load in my custom lua snippets (snippets in lua not just for lua language)
          -- lazy load works better because it tracks the active filetype
          -- allows for overlapping triggers
          require('luasnip.loaders.from_lua').lazy_load { paths = { '~/AppData/Local/nvim/lua/custom/plugins/snippets' } }
        end,
      },
    },
    -- use a release tag to download pre-built binaries
    version = 'v0.*',

    opts = {

      keymap = { preset = 'default' },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      snippets = {
        preset = 'luasnip',
        expand = function(snippet)
          require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction)
          require('luasnip').jump(direction)
        end,
      },

      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- optionally disable cmdline completions
        -- cmdline = {},
      },

      -- experimental signature help support
      signature = { enabled = true },
    },
  },
}
