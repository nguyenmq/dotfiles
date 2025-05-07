local jdtls = require("jdtls")
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', 'ge', '<cmd>botright lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
end

local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
local home = os.getenv("HOME")
local eclipse_workspace = home .. "/.cache/jdtls/workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local jdtls_bin = home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher.jar"
local configuration = home .. "/.local/share/nvim/lsp_servers/jdtls/config_linux"
local lombok_path = home .. "/.local/share/nvim/dependencies/lombok.jar"
local java_path = "{{lsp_java_path}}"

local ws_folders_jdtls = {}

if root_dir then
    local file = io.open(root_dir .. "/.bemol/ws_root_folders")
    if file then
        for line in file:lines() do
            table.insert(ws_folders_jdtls, "file://" .. line)
        end
        file:close()
    end
end

local config = {
    on_attach = on_attach,
    cmd = {
        java_path,
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx2g',
        '-javaagent:' .. lombok_path,
        '-Xbootclasspath/a:' .. lombok_path,
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', jdtls_bin,
        "-data", eclipse_workspace,
        "-configuration", configuration,
    },
    root_dir = root_dir,
    init_options = {
        workspaceFolders = ws_folders_jdtls,
    },
    capabilities = {
        workspace = {
            configuration = true
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    },
    settings = {
        java = {
            references = {
                includeDecompiledSources = true,
            },
            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSources = true,
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
        }
    },
}

jdtls.start_or_attach(config)
