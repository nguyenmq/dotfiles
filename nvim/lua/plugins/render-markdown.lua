return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require('render-markdown').setup {
            render_modes = true,
            debounce = 100,
            heading = {
                -- Turn on / off heading icon & background rendering
                enabled = true,
                sign = false,
                -- Replaces '#+' of 'atx_h._marker'
                -- The number of '#' in the heading determines the 'level'
                -- The 'level' is used to index into the list using a cycle
                -- If the value is a function the input is the nesting level of the heading within sections
                icons = { '󰎤 ', '󰎧󱓻 ', '󰎪󱓻󱓻 ', '󰎭󱓻󱓻󱓻 ', '󰎱󱓻󱓻󱓻󱓻 ', '󰎳󱓻󱓻󱓻󱓻󱓻 ' },
                position = 'overlay',
                width = 'block',
                -- Amount of margin to add to the left of headings
                -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
                -- Margin available space is computed after accounting for padding
                -- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
                left_margin = 0,
                -- Amount of padding to add to the left of headings
                -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
                -- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
                left_pad = 1,
                -- Amount of padding to add to the right of headings when width is 'block'
                -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
                -- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
                right_pad = 1,
                -- Minimum width to use for headings when width is 'block'
                -- Can also be a list of integers in which case the 'level' is used to index into the list using a clamp
                min_width = 120,
                -- Determines if a border is added above and below headings
                -- Can also be a list of booleans in which case the 'level' is used to index into the list using a clamp
                border = true,
                -- Always use virtual lines for heading borders instead of attempting to use empty lines
                border_virtual = true,
                -- Highlight the start of the border using the foreground highlight
                border_prefix = false,
                -- Used above heading for border
                above = '▄',
                -- Used below heading for border
                below = '▀',
                -- The 'level' is used to index into the list using a clamp
                -- Highlight for the heading icon and extends through the entire line
                backgrounds = {
                    'RenderMarkdownH1Bg',
                },
                -- The 'level' is used to index into the list using a clamp
                -- Highlight for the heading and sign icons
                foregrounds = {
                    'RenderMarkdownH1',
                },
            },
            checkbox = {
                enabled = true,
                position = 'overlay',
                unchecked = {
                    icon = ' ',
                    highlight = 'RenderMarkdownUnchecked',
                    scope_highlight = nil,
                },
                checked = {
                    icon = ' ',
                    highlight = 'RenderMarkdownChecked',
                    scope_highlight = nil,
                },
            },
            code = {
                enabled = true,
                sign = false,
                -- Determines how code blocks & inline code are rendered:
                --  none:     disables all rendering
                --  normal:   adds highlight group to code blocks & inline code, adds padding to code blocks
                --  language: adds language icon to sign column if enabled and icon + name above code blocks
                --  full:     normal + language
                style = 'full',
                -- Determines where language icon is rendered:
                --  right: right side of code block
                --  left:  left side of code block
                position = 'left',
                -- Amount of padding to add around the language
                -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
                language_pad = 1,
                -- Whether to include the language name next to the icon
                language_name = true,
                -- A list of language names for which background highlighting will be disabled
                -- Likely because that language has background highlights itself
                -- Or a boolean to make behavior apply to all languages
                -- Borders above & below blocks will continue to be rendered
                disable_background = { 'diff' },
                -- Width of the code block background:
                --  block: width of the code block
                --  full:  full width of the window
                width = 'block',
                -- Amount of margin to add to the left of code blocks
                -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
                -- Margin available space is computed after accounting for padding
                left_margin = 0,
                -- Amount of padding to add to the left of code blocks
                -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
                left_pad = 1,
                -- Amount of padding to add to the right of code blocks when width is 'block'
                -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
                right_pad = 1,
                -- Minimum width to use for code blocks when width is 'block'
                min_width = 120,
                -- Determines how the top / bottom of code block are rendered:
                --  none:  do not render a border
                --  thick: use the same highlight as the code body
                --  thin:  when lines are empty overlay the above & below icons
                border = 'thin',
                -- Used above code blocks for thin border
                above = '▄',
                -- Used below code blocks for thin border
                below = '▀',
                -- Highlight for code blocks
                highlight = 'RenderMarkdownCode',
                -- Highlight for language, overrides icon provider value
                highlight_language = nil,
                -- Padding to add to the left & right of inline code
                inline_pad = 0,
                -- Highlight for inline code
                highlight_inline = 'RenderMarkdownCodeInline',
            },
            paragraph = {
                enabled = true,
                left_margin = 0,
                min_width = 0,
            },
            dash = {
                enabled = true,
                -- Replaces '---'|'***'|'___'|'* * *' of 'thematic_break'
                -- The icon gets repeated across the window's width
                icon = '─',
                -- Width of the generated line:
                --  <number>: a hard coded width value, if a floating point value < 1 is provided it is
                --            treated as a percentage of the available window space
                --  full:     full width of the window
                width = 120,
                -- Amount of margin to add to the left of dash
                -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
                left_margin = 0,
                -- Highlight for the whole line generated from the icon
                highlight = 'RenderMarkdownDash',
            },
            bullet = {
                -- Turn on / off list bullet rendering
                enabled = true,
                -- Replaces '-'|'+'|'*' of 'list_item'
                -- How deeply nested the list is determines the 'level', how far down at that level determines the 'index'
                -- If a function is provided both of these values are passed in using 1 based indexing
                -- If a list is provided we index into it using a cycle based on the level
                -- If the value at that level is also a list we further index into it using a clamp based on the index
                -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
                icons = { '' },
                -- Replaces 'n.'|'n)' of 'list_item'
                -- How deeply nested the list is determines the 'level', how far down at that level determines the 'index'
                -- If a function is provided both of these values are passed in using 1 based indexing
                -- If a list is provided we index into it using a cycle based on the level
                -- If the value at that level is also a list we further index into it using a clamp based on the index
                ordered_icons = function(level, index, value)
                    value = vim.trim(value)
                    local value_index = tonumber(value:sub(1, #value - 1))
                    return string.format('%d.', value_index > 1 and value_index or index)
                end,
                -- Padding to add to the left of bullet point
                left_pad = 1,
                -- Padding to add to the right of bullet point
                right_pad = 0,
                -- Highlight for the bullet icon
                highlight = 'RenderMarkdownBullet',
            },
            sign = {
                enabled = false,
            },
            link = {
                -- Turn on / off inline link icon rendering
                enabled = true,
                -- How to handle footnote links, start with a '^'
                footnote = {
                    -- Replace value with superscript equivalent
                    superscript = true,
                    -- Added before link content when converting to superscript
                    prefix = '',
                    -- Added after link content when converting to superscript
                    suffix = '',
                },
                -- Inlined with 'image' elements
                image = '󰋩 ',
                -- Inlined with 'email_autolink' elements
                email = '󰇮 ',
                -- Fallback icon for 'inline_link' and 'uri_autolink' elements
                hyperlink = ' ',
                -- Applies to the inlined icon as a fallback
                highlight = 'RenderMarkdownLink',
                -- Applies to WikiLink elements
                wiki = { icon = '󱗖 ', highlight = 'RenderMarkdownWikiLink' },
                custom = {
                    web = { pattern = '^http', icon = ' ' },
                    youtube = { pattern = 'youtube%.com', icon = '󰗃 ' },
                    github = { pattern = 'github%.com', icon = '󰊤 ' },
                    neovim = { pattern = 'neovim%.io', icon = ' ' },
                    stackoverflow = { pattern = 'stackoverflow%.com', icon = '󰓌 ' },
                    discord = { pattern = 'discord%.com', icon = '󰙯 ' },
                    reddit = { pattern = 'reddit%.com', icon = '󰑍 ' },
                },
            },
        }
    end
}
