-- import global vim settings
require("settings")

-- import key mappings
require("keymaps")

-- import custom commands
require("commands")

-- load lazy package manager
require("config.lazy")

-- status line plugin
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

-- for navigating between neovim and tmux panes
require("nvim-tmux-navigation").setup {
    disable_when_zoomed = true,
    keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
    }
}

-- fuzzy finding
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
        }
    }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>r', builtin.command_history, {})
vim.keymap.set('n', '<leader>t', builtin.current_buffer_tags, {})
