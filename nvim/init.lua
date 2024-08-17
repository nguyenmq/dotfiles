-- import global vim settings
require("settings")

-- import key mappings
require("keymaps")

-- import custom commands
require("commands")

-- load lazy package manager
require("config.lazy")

-- settings after loading plugins
vim.cmd('colorscheme olive')
vim.opt.showtabline = 1
