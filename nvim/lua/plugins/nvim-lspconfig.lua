return {
    'neovim/nvim-lspconfig',
    name = 'nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
        -- require('lspconfig').rust_analyzer.setup{}

        require('mason').setup()

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local servers = {
            rust_analyzer = {}
        }
        local ensure_installed = vim.tbl_keys(servers or {})
        require('mason-tool-installer').setup {
            ensure_installed = ensure_installed
        }

        require('mason-lspconfig').setup {
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for tsserver)
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }

        -- configure borders in the floating lsp window
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover, {
            border = "single",
          }
        )
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help, {
                border = "single",
            }
        )
        vim.diagnostic.config{
            float = {
                border = "single"
            }
        }
    end,
}
