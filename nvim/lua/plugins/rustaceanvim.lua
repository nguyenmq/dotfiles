return {
    'mrcjkb/rustaceanvim',
    version = '^9',
    init = function()
        vim.g.rustaceanvim = {
            server = {
                default_settings = {
                    ['rust-analyzer'] = {
                        diagnostics = {
                            enable = false,
                        },
                    }
                },
            },
        }
    end,
}
