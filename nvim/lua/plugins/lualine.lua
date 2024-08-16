return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require("lualine").setup {
            options = {
                theme = 'olive',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
            },
            sections = {
                lualine_a = {'location'},
                lualine_b = { },
                lualine_c = {'filename'},
                lualine_x = {},
                lualine_y = {'filetype'},
                lualine_z = {'progress'}
            },
            inactive_sections = {
                lualine_a = {'location'},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
        }
    end
}
