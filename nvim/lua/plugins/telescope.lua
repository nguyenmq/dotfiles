return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        require("telescope").setup {
            defaults = {
                layout_strategy = 'vertical',
                layout_config = {
                    vertical = {
                        width = 0.5,
                        mirror = true
                    }
                }
            },
            pickers = {
                find_files = {
                    find_command = {
                        'rg',
                        '--files',
                        '--hidden',
                        '--no-ignore-vcs',
                        '--follow'
                    }
                },
                tags = {
                    only_sort_tags = true,
                    fname_width = 50,
                },
                current_buffer_tags = {
                    only_sort_tags = true,
                    fname_width = 50,
                }
            }
        }
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>f', builtin.find_files, {})
        vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>b', builtin.buffers, {})
        vim.keymap.set('n', '<leader>r', builtin.command_history, {})
        vim.keymap.set('n', '<leader>t', builtin.current_buffer_tags, {})
        vim.keymap.set('n', '<leader>T', builtin.tags, {})
    end,
}
