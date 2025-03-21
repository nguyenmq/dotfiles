return {
    'vimwiki/vimwiki',
    enabled = false,
    init = function()
        vim.g.vimwiki_list = {
            {
            path = '~/notes/src/',
            index = 'SUMMARY',
            syntax = 'markdown',
            ext = '.md',
            }
        }
        vim.g.vimwiki_list_margin = 0
        vim.g.vimwiki_listsyms = ' .:ox'
    end,
    config = function()
        vim.keymap.set('v', '<Leader>wrm', '<cmd>VimwikiRemoveDone<cr>')
    end
}
