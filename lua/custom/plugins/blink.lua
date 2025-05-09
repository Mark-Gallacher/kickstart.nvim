local check_os = function()
  local unix = vim.fn.has 'unix'
  local windows = vim.fn.has 'windows'

  if unix == 1 and windows == 0 then
    return 'unix'
  end

  if unix == 0 and windows == 1 then
    return 'windows'
  end

  return nil
end

local get_custom_snippets = function()
  local my_os = check_os()
  if my_os == 'windows' then
    return { '~/AppData/Local/nvim/lua/custom/plugins/snippets' }
  end
  return { '~/.config/nvim/lua/custom/plugins/snippets' }
end

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

          -- load in my custom lua snippets (snippets in lua not just for lua language)
          -- lazy load works better because it tracks the active filetype
          -- allows for overlapping trigger
          require('luasnip.loaders.from_vscode').lazy_load()
          require('luasnip.loaders.from_lua').lazy_load { paths = get_custom_snippets() }

          ls.config.setup {

            enable_autosnippets = true,
            update_events = { 'TextChanged', 'TextChangedI' },
          }

          ls.filetype_extend('heex', { 'html', 'elixir' })
          ls.filetype_extend('quarto', { 'python' })

          local list_snips = function()
            local ft_list = require('luasnip').available()[vim.o.filetype]
            local ft_snips = {}
            for _, item in pairs(ft_list) do
              ft_snips[item.trigger] = item.name
            end
            print(vim.inspect(ft_snips))
          end

          vim.api.nvim_create_user_command('SnipList', list_snips, {})
        end,
      },
    },
    -- use a release tag to download pre-built binaries
    version = 'v0.*',

    opts = {

      keymap = { preset = 'default', ['<Tab>'] = {} },

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
        providers = {
          lsp = {
            name = 'lsp',
            score_offset = 0,
            max_items = 5,
          },
          path = {
            name = 'path',
            score_offset = 0,
            max_items = 5,
          },
          snippets = {
            name = 'snippets',
            score_offset = 5,
            min_keyword_length = 2,
            max_items = 5,
          },
          buffer = {
            name = 'buffer',
            score_offset = 10,
            min_keyword_length = 4,
            max_items = 4,
          },
        },
        -- optionally disable cmdline completions
        -- cmdline = {},
      },

      -- experimental signature help support
      signature = { enabled = true },
    },
  },
}
