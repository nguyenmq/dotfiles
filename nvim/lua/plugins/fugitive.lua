return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set('n', 'gs', '<cmd>Git!<cr>')
        vim.keymap.set('n', 'gb', '<cmd>Git blame<cr>')
    end
}
