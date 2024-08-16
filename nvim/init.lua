-- import global vim settings
require("settings")

-- import key mappings
require("keymaps")

-- import custom commands
require("commands")

-- load lazy package manager
require("config.lazy")

vim.cmd('colorscheme olive')
