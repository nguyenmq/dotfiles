vim.opt.autoindent = true
vim.opt.backspace = {'indent', 'eol', 'start'}
vim.opt.background = 'light'
vim.opt.compatible = false
vim.opt.completeopt = {'menuone', 'longest', 'preview'}
vim.opt.cursorlineopt = 'screenline'
vim.opt.dir = '/tmp'
vim.opt.equalalways = false
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.foldnestmax = 1
vim.opt.formatoptions:append({j = true})
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.lazyredraw = true
vim.opt.modeline = true
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.relativenumber = true
vim.opt.sessionoptions = {'blank', 'buffers', 'curdir', 'folds', 'help', 'tabpages', 'winsize'}
vim.opt.shiftwidth = 4
vim.opt.showcmd = true
vim.opt.smartcase = true
vim.opt.softtabstop = 4
vim.opt.startofline = false
vim.opt.swapfile = true
vim.opt.switchbuf = 'useopen'
vim.opt.tabstop = 4
vim.opt.tag = '.tags;$HOME'
vim.opt.tagcase = 'smart'
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 10
vim.opt.undodir = os.getenv('HOME')..'/.cache/nvim/undo'
vim.opt.undofile = true
vim.opt.visualbell = false
vim.opt.wildignore = {'*.o', '*.so', '*.a', '*.o32', '*.obj', '*.out', '*.zip', '*.exe', '*.lib', '*.gca'}
vim.opt.wildmenu = true
vim.opt.wildmode = {'longest', 'list', 'full'}
vim.opt.wildoptions = {'pum'}
vim.opt.wrap = false

vim.cmd 'filetype indent off'
vim.cmd 'filetype plugin on'
vim.cmd 'syntax on'

vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"
