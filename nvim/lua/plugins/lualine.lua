return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require("lualine").setup {
            options = {
                theme = 'olive',
                component_separators = { left = '│', right = '│'},
                section_separators = '',
                always_divide_middle = true,
            },
            sections = {
                lualine_a = {'location'},
                lualine_b = {'branch' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = {'searchcount'},
                lualine_y = { { 'diagnostics', colored = false }, { 'filetype', colored = false } },
                lualine_z = {'selectioncount', 'progress'}
            },
            inactive_sections = {
                lualine_a = {'location'},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {
                lualine_a = { {
                    'tabs',
                    mode = 2,
                    show_modified_status = false,
                    tabs_color = {
                        active = 'lualine_b_normal',
                        inactive = 'lualine_c_normal',
                    }
                } },
            }
        }
    end
}
