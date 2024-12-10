return {
    'nvim-telescope/telescope.nvim',
    name = 'telescope',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim'
    },
    config = function()
        local tags_file = '/tmp/tags'
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
                buffers = {
                    sort_mru = true
                },
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
                    ctags_file = tags_file,
                },
                diagnostics = {
                    bufnr = 0,
                },
                lsp_document_symbols = {
                    fname_width = 50,
                }
            }
        }
        local builtin = require('telescope.builtin')
        local extensions = require('telescope').extensions
        vim.keymap.set('n', '<leader>f', builtin.find_files, {})
        vim.keymap.set('n', '<leader>s', builtin.grep_string, {})
        vim.keymap.set('n', '<leader>S', extensions.live_grep_args.live_grep_args, {})
        vim.keymap.set('n', '<leader>b', builtin.buffers, {})
        vim.keymap.set('n', '<leader>r', builtin.command_history, {})
        vim.keymap.set('n', '<leader>T', function()
            local lsp_count = table.getn(vim.lsp.get_clients({bufnr=0}))
            if lsp_count > 0 then
                builtin.lsp_workspace_symbols()
            else
                builtin.tags()
            end
        end)
        vim.keymap.set('n', '<leader>t', function()
            local lsp_count = table.getn(vim.lsp.get_clients({bufnr=0}))

            if lsp_count > 0 then
                builtin.lsp_document_symbols({fname_width=50})
            else
                -- run ctags on the current buffer to get an updated tags file if no lsp client
                local filename = vim.fn.expand('%:p')
                os.execute('ctags -o ' .. tags_file .. ' ' .. filename)
                builtin.current_buffer_tags()
            end
        end)
        vim.keymap.set('n', '<leader>d', function() builtin.diagnostics({bufnr = 0}) end)
        vim.keymap.set('n', '<leader>lr', function() builtin.lsp_references({}) end)
        vim.keymap.set('n', '<leader>lc', function() builtin.lsp_incoming_calls({}) end)
    end,
}
