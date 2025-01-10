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
    end,
    config = function()
    end,
}
