return {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = true,
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
