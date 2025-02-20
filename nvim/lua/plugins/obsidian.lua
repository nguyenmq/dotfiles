return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local util = require("obsidian.util")
        vim.keymap.set('ca', 'obn', 'ObsidianNew')
        vim.keymap.set('ca', 'obs', 'ObsidianQuickSwitch')
        vim.keymap.set('n', '<Leader>or', function()
            vim.cmd('global /^\\s*- \\[x\\]/ d')
        end)
        require("obsidian").setup {
            workspaces = {
                {
                    name = "kms",
                    path = "~/next/kms",
                },
                {
                    name = "work",
                    path = "~/notes",
                },
            },
            mappings = {
                -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                ["gf"] = {
                    action = function()
                        return util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                -- Smart action depending on context, either follow link or toggle checkbox.
                ["<cr>"] = {
                    action = function()
                        return util.smart_action()
                    end,
                    opts = { buffer = true, expr = true },
                }
            },
            notes_subdir = "inbox",
            new_notes_location = "notes_subdir",
            note_id_func = function(title)
                local prefix = os.date("%Y-%m-%dT%H-%M", os.time())
                if title ~= nil then
                    local suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                    return prefix .. "--" .. suffix
                else
                    return prefix
                end
            end,
            markdown_link_func = "prepend_note_path",
            preferred_link_styel = "markdown",
            ui = {
                enable = false,
                update_debounce = 200,
                checkboxes = {
                    [" "] = { char = "", hl_group = "ObsidianTodo" },
                    ["x"] = { char = "", hl_group = "ObsidianDone" },
                    [">"] = { char = "󰧚", hl_group = "ObsidianRightArrow" },
                    ["~"] = { char = "", hl_group = "ObsidianTilde" },
                    ["!"] = { char = "", hl_group = "ObsidianImportant" },
                },
                bullets = { char = "", hl_group = "ObsidianBullet" },
                external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
                reference_text = { hl_group = "ObsidianRefText" },
                highlight_text = { hl_group = "ObsidianHighlightText" },
                hl_groups = {
                    ObsidianTodo = { bold = false, fg = "{{blue_dark}}" },
                    ObsidianDone = { bold = false, fg = "{{blue_light}}" },
                    ObsidianRightArrow = { bold = true, fg = "{{magenta}}" },
                    ObsidianTilde = { bold = true, fg = "{{red}}" },
                    ObsidianImportant = { bold = true, fg = "{{yellow}}" },
                    ObsidianBullet = { bold = false, fg = "{{blue_dark}}" },
                    ObsidianRefText = { underline = true, fg = "{{blue}}" },
                    ObsidianExtLinkIcon = { fg = "{{gray_dark}}" },
                    ObsidianTag = { italic = true, fg = "{{lavender}}" },
                    ObsidianBlockID = { italic = true, fg = "{{lavender}}" },
                    ObsidianHighlightText = { bg = "{{yellow_light}}" },
                },
            },
        }
    end
}
