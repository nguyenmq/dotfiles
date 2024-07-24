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
