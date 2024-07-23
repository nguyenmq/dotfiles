-- exit insert mode and update the file
vim.keymap.set('i', 'jk', '<esc><cmd>update<cr>')

-- quit the buffer
vim.keymap.set('n', '<Leader>x', '<cmd>q<cr>')

-- buffer navigation
vim.keymap.set('n', '<C-J>', '<C-W>j')
vim.keymap.set('n', '<C-K>', '<C-W>k')
vim.keymap.set('n', '<C-H>', '<C-W>h')
vim.keymap.set('n', '<C-L>', '<C-W>l')

-- toggle cursorline
vim.keymap.set('n', '<Leader>cl', function() vim.opt.cursorline = not vim.o.cursorline end)

-- turn off search highlight
vim.keymap.set('n', '<Leader>n', function() vim.cmd('nohlsearch') end)

-- windows and tabs
vim.keymap.set('n', '<Leader>v', function() vim.fn['functions#VertSplitPercent'](0.41) end)
vim.keymap.set('n', '<Leader>gx', function() vim.cmd('tabclose'); vim.cmd('normal gT') end)
vim.keymap.set('n', '<Leader>z', function() vim.cmd('tab split'); vim.cmd('diffoff') end)
