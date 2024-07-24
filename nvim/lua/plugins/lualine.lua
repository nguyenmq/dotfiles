return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require("lualine").setup {
            sections = {
                lualine_a = {'location'},
                lualine_b = {'branch', 'diagnostics'},
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
