-- exit insert mode and update the file
vim.keymap.set('i', 'jk', '<esc><cmd>update<cr>')

-- buffer
vim.keymap.set('n', '<C-J>', '<C-W>j')
vim.keymap.set('n', '<C-K>', '<C-W>k')
vim.keymap.set('n', '<C-H>', '<C-W>h')
vim.keymap.set('n', '<C-L>', '<C-W>l')
vim.keymap.set('n', '<Leader>x', '<cmd>q<cr>')
vim.keymap.set('n', '<Leader>l', function() print(vim.fn.expand('%:p')) end)

-- toggle cursorline
vim.keymap.set('n', '<Leader>cl', function() vim.opt.cursorline = not vim.o.cursorline end)

-- search
vim.keymap.set('n', '<Esc>', function() vim.cmd('nohlsearch') end)
vim.keymap.set('n', '<Leader>h', function()
    local word = vim.fn.expand("<cword>")
    vim.fn['functions#SearchWithHighlight']('\\<'..word..'\\>')
    vim.cmd('set hlsearch')
end)

-- windows and tabs
vim.keymap.set('n', '<Leader>v', function() vim.fn['functions#VertSplitPercent'](0.41) end)
vim.keymap.set('n', '<Leader>gx', function()
    local tab_count = table.getn(vim.fn['gettabinfo']())
    local current_tab_number = vim.fn['tabpagenr']()
    vim.cmd('tabclose')

    -- Closing the last tab means the "left" tab comes into focus. Closing a
    -- tab in the middle shifts focus to the "right". Make the behavior
    -- consistent by always bringing the "left" tab into focus after closing.
    if current_tab_number ~= tab_count then
        vim.cmd('normal gT')
    end
end)
vim.keymap.set('n', '<Leader>z', function() vim.cmd('tab split'); vim.cmd('diffoff') end)

-- completion
vim.keymap.set('i', '<C-j>', function()
    return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-x><C-n>"
end, { expr = true })
vim.keymap.set('i', '<C-k>', function()
    return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-x><C-p>"
end, { expr = true })

-- quickfix
vim.keymap.set('n', '<Leader>e', '<cmd>cn<cr>zz', { silent = true })
vim.keymap.set('n', '<Leader>E', '<cmd>cN<cr>zz', { silent = true })

-- diff
vim.keymap.set('n', '<Leader>co', function()
    vim.cmd('tab split')
    vim.cmd('normal 0f]wgf')
    vim.cmd('Gvdiffsplit ' .. os.getenv('GIT_DIFF_OBJECT'))
    vim.cmd('normal zR]czz')
    vim.fn['functions#VertSplitPercent'](0.41)
end)

-- yanks
vim.keymap.set('n', '<Leader>y', function()
    vim.cmd('normal "+yiw')
    vim.cmd('echo "Yanked: " . @+')
end)
vim.keymap.set('n', '<Leader>Y', function()
    vim.cmd('normal "+y$')
    vim.cmd('echo "Yanked: " . @+')
end)

-- puts
vim.keymap.set('n', '<Leader>cr', function() vim.fn['functions#PasteCRLink']() end)

-- abbreviation to insert date
vim.keymap.set('ia', 'dt', vim.fn['strftime']("%Y-%m-%d"))
