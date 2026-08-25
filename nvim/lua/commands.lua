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

vim.api.nvim_create_user_command(
    'Gll',
    function(opts)
        local path = vim.fn.expand('%:p')
        vim.fn.setreg('+', path)
        print('Yanked: ' .. path)
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

-- search current buffer for the a search pattern an populations the buffer's location list
vim.api.nvim_create_user_command(
    'Lf',
    function(opts)
        local pattern = opts.args
        if pattern == '' then
            pattern = vim.fn.getreg('/')
        end
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local items = {}
        for i, line in ipairs(lines) do
            if vim.fn.match(line, pattern) >= 0 then
                table.insert(items, {
                    bufnr = vim.api.nvim_get_current_buf(),
                    lnum = i,
                    col = 1,
                    text = line,
                })
            end
        end
        vim.fn.setloclist(0, items, 'r')
        if #items > 0 then
            vim.cmd('lwindow 7')
        else
            print('No matches for: ' .. pattern)
        end
        vim.fn.setreg('/', pattern)
        vim.opt.hlsearch = true
        vim.cmd('redraw')
    end,
    { nargs = '?' }
)

vim.api.nvim_create_user_command(
    'LspStop',
    function(opts)
        vim.lsp.Client:stop()
    end,
    { nargs = '?' }
)

vim.api.nvim_create_user_command(
    'LspInfo',
    function(opts)
        vim.cmd('checkhealth vim.lsp')
    end,
    { nargs = '?' }
)
