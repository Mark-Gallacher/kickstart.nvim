return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            options = {
                component_separators = '',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = {
                    { "diagnostics",
                        source = "nvim-diagnostics",
                        symbols = {
                            hint = "● ",
                            info = "● ",
                            warn = "● ",
                            error = "● ", }
                    },
                    { "diff",
                        symbols = {
                            added = ' ',
                            modified = '󰝤 ',
                            removed = ' ' }
                    },
                },
                lualine_c = {
                    '%=', "filename" --[[ add your center components here in place of this comment ]]
                },
                lualine_x = {},
                lualine_y = {
                    "filetype",
                    {
                        "lsp_status",
                        icons_enabled = false,
                    },
                    "progress"
                },
                lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                },
            },
            inactive_sections = {},
            tabline = {},
            extensions = {},
        }
    end
}
