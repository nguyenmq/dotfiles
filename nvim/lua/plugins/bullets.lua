return {
    'bullets-vim/bullets.vim',
    name = 'bullets',
    init = function()
        vim.g.bullets_set_mappings = 0
        vim.g.bullets_custom_mappings = {
            { 'imap', '<cr>', '<Plug>(bullets-newline)' },
            { 'inoremap', '<C-cr>', '<cr>' },
            { 'nmap', 'o', '<Plug>(bullets-newline)' },
            { 'vmap', 'gN', '<Plug>(bullets-renumber)' },
            { 'nmap', 'gN', '<Plug>(bullets-renumber)' },
            { 'imap', '<C-t>', '<Plug>(bullets-demote)' },
            { 'nmap', '>>', '<Plug>(bullets-demote)' },
            { 'vmap', '>', '<Plug>(bullets-demote)' },
            { 'imap', '<C-d>', '<Plug>(bullets-promote)' },
            { 'nmap', '<<', '<Plug>(bullets-promote)' },
            { 'vmap', '<', '<Plug>(bullets-promote)' },
        }
        vim.g.bullets_outline_levels = {'ROM', 'ABC', 'num', 'abc', 'rom', 'std-'}
        vim.g.bullets_checkbox_markers = '    x'
        vim.g.bullets_nested_checkboxes = 1
    end,
    config = function()
        vim.keymap.set('n', '<C-Space>', function()
            vim.cmd('ToggleCheckbox')
            vim.cmd('update')
        end)
    end,
}
