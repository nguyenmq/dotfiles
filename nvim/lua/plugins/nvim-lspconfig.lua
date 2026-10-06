{{lsp_workspace_setup_fn}}

return {
    'neovim/nvim-lspconfig',
    name = 'nvim-lspconfig',
    config = function()
        local on_attach = function(client, bufnr)
            require("lsp.keymaps").on_attach(client, bufnr)
            workspace_setup()
        end

        -- C/C++ language server. Need clangd installed
        vim.lsp.config('clangd', {
            on_attach = on_attach,
            cmd = {
                'clangd',
                '--background-index',
                '--clang-tidy',
                '--header-insertion=iwyu',
                '--completion-style=detailed',
            },
        })
        vim.lsp.enable('clangd')
    end,
}
