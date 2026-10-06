return {
    'mrcjkb/rustaceanvim',
    version = '^9',
    init = function()
        vim.g.rustaceanvim = {
            server = {
                on_attach = function(client, bufnr)
                    require("lsp.keymaps").on_attach(client, bufnr)
                end,
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
