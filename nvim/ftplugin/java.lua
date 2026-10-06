local jdtls = require("jdtls")
local on_attach = function(client, bufnr)
    require("lsp.keymaps").on_attach(client, bufnr)
    -- jdtls-specific: organize imports
    vim.keymap.set('n', 'gp', '<cmd>lua require("jdtls").organize_imports()<cr>',
        { noremap = true, silent = true, buffer = bufnr })
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
            completion = {
                importOrder = {
                    "", -- all other imports
                    "java",
                    "javax",
                    "#", -- static imports will go last
                }
            }
        },
    }
}

jdtls.start_or_attach(config)
