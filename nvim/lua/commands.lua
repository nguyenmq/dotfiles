-- resize window the specified height
vim.api.nvim_create_user_command(
    'H',
    function(opts)
        vim.cmd('resize '..opts.args)
    end,
    { nargs = 1 }
)

-- resize window the specified width
vim.api.nvim_create_user_command(
    'W',
    function(opts)
        vim.cmd('vertical resize '..opts.args)
    end,
    { nargs = 1 }
)

-- rotate the capture/focus file to the current week
vim.api.nvim_create_user_command(
    'RotateCapture',
    function(opts)
        vim.fn['functions#RotateCapture']()
    end,
    { nargs  = 0 }
)

-- toggle line wrapping
vim.api.nvim_create_user_command(
    'RotateCapture',
    function(opts)
        vim.fn['functions#RotateCapture']()
    end,
    { nargs  = 0 }
)

-- writing/prose mode
vim.api.nvim_create_user_command(
    'Wm',
    function(opts)
        vim.fn['functions#ToggleWrap']()
    end,
    { nargs  = 0 }
)

vim.api.nvim_create_user_command(
    'Bn',
    function(opts)
        vim.fn['functions#Basename']()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'Gl',
    function(opts)
        vim.fn['functions#GetLocation']()
    end,
    { nargs = 0 }
)

-- search with all characters escaped
vim.api.nvim_create_user_command(
    'ES',
    function(opts)
        search_args = '\\V' .. vim.fn.escape(opts.args, '\\')
        vim.fn.setreg('/', search_args)
        vim.fn.histadd('search', search_args)
        vim.cmd('set hlsearch')
    end,
    { nargs = 1 }
)

vim.api.nvim_create_user_command(
    'Dt',
    function(opts)
        date_cmd = 'date -d "' .. opts.args .. '" +"%Y-%m-%d"'
        date = vim.fn.system(date_cmd)
        vim.cmd('normal A' .. date)
    end,
    { nargs = 1 }
)
