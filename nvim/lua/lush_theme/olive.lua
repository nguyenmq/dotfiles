-- Built from Lush template: https://github.com/rktjmp/lush-template/tree/main

local lush = require('lush')
local hsl = lush.hsl

-- colors
local black = hsl("{{black}}")
local black_almost = hsl("{{black_almost}}")
local blue = hsl("{{blue}}")
local gray_dark = hsl("{{gray_dark}}")
local gray_darker = hsl("{{gray_darker}}")
local gray_light = hsl("{{gray_light}}")
local green = hsl("{{green}}")
local green_dark = hsl("{{green_dark}}")
local green_bright = hsl("{{green_bright}}")
local lavender = hsl("{{lavender}}")
local magenta = hsl("{{magenta}}")
local red = hsl("{{red}}")
local white_almost = hsl("{{white_almost}}")
local white = hsl("{{white}}")
local yellow = hsl("{{yellow}}")
local yellow_light = hsl("{{yellow_light}}")
local yellow_pale = hsl("{{yellow_pale}}")
local ui_primary = hsl("{{ui_primary}}")
local ui_accent = hsl("{{ui_accent}}")
local ui_accent_alt = hsl("{{ui_accent_alt}}")
local ui_text_accent = hsl("{{ui_text_accent}}")
local ui_text_accent_alt = hsl("{{ui_text_accent_alt}}")

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    --
    Normal          { fg = black_almost, bg = white }, -- Normal text
    ColorColumn     { fg = Normal.fg, bg = gray_light }, -- Columns set with 'colorcolumn'
    Cursor          { bg = Normal.fg, fg = Normal.bg }, -- Character under the cursor
    Search          { fg = Normal.fg, bg = yellow_light }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    CurSearch       { Search, bg = Search.bg.darken(35) }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    IncSearch       { Search }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute      { Search }, -- |:substitute| replacement text highlighting
    Conceal         { fg = gray_dark.darken(50), bg = Normal.bg }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    -- lCursor        { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
    CursorLine      { fg = Normal.fg, bg = yellow_pale }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorColumn    { CursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    Directory       { fg = blue } , -- Directory names (and other special names in listings)
    DiffAdd         { bg = green.desaturate(30).lighten(85) }, -- Diff mode: Added line |diff.txt|
    DiffChange      { DiffAdd }, -- Diff mode: Changed line |diff.txt|
    DiffDelete      { fg = red, bg = red.desaturate(30).lighten(85) }, -- Diff mode: Deleted line |diff.txt|
    DiffText        { fg = Normal.fg, bg = DiffAdd.bg }, -- Diff mode: Changed text within a changed line |diff.txt|
    -- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor     { }, -- Cursor in a focused terminal
    -- TermCursorNC   { }, -- Cursor in an unfocused terminal
    ErrorMsg        { fg = white, bg = magenta }, -- Error messages on the command line
    VertSplit       { fg = ui_primary, bg = ui_primary }, -- Column separating vertically split windows
    Folded          { fg = blue, bg = white }, -- Line used for closed folds
    FoldColumn      { fg = ui_text_accent, bg = ui_accent }, -- 'foldcolumn'
    SignColumn      { fg = ui_primary, bg = gray_light }, -- Column where |signs| are displayed
    LineNr          { fg = ui_primary, bg = white }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    LineNrAbove     { fg = ui_primary, bg = gray_light }, -- Line number for when the 'relativenumber' option is set, above the cursor line
    LineNrBelow     { LineNrAbove }, -- Line number for when the 'relativenumber' option is set, below the cursor line
    CursorLineNr    { LineNr }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    -- CursorLineFold { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
    -- CursorLineSign { }, -- Like SignColumn when 'cursorline' is set for the cursor line
    MatchParen      { fg = blue, bg = gray_dark }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg         { fg = ui_primary }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea         { Normal }, -- Area for messages and cmdline
    -- MsgSeparator   { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg         { fg = yellow }, -- |more-prompt|
    NonText         { fg = gray_dark }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    NormalFloat     { Normal }, -- Normal text in floating windows.
    FloatBorder     { VertSplit }, -- Border of floating windows.
    FloatTitle      { fg = ui_primary }, -- Title of floating windows.
    -- NormalNC       { }, -- normal text in non-current windows
    Pmenu           { fg = green, bg = gray_light }, -- Popup menu: Normal item.
    PmenuSel        { fg = white, bg = green }, -- Popup menu: Selected item.
    PmenuKind       { Pmenu }, -- Popup menu: Normal item "kind"
    PmenuKindSel    { PmenuSel }, -- Popup menu: Selected item "kind"
    PmenuExtra      { Pmenu }, -- Popup menu: Normal item "extra text"
    PmenuExtraSel   { PmenuSel }, -- Popup menu: Selected item "extra text"
    PmenuSbar       { Pmenu }, -- Popup menu: Scrollbar.
    -- PmenuThumb     { }, -- Popup menu: Thumb of the scrollbar.
    Question        { fg = magenta }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine    { fg = green }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    SpecialKey      { fg = yellow }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad        { fg = red, gui = "underline" }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap        { fg = blue, gui = "underline" }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    -- SpellLocal     { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare      { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine      { fg = white, bg = ui_primary }, -- Status line of current window
    StatusLineNC    { fg = gray_light, bg = ui_primary }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine         { fg = white, bg = ui_primary }, -- Tab pages line, not active tab page label
    TabLineFill     { TabLine }, -- Tab pages line, where there are no labels
    TabLineSel      { fg = white, bg = ui_accent }, -- Tab pages line, active tab page label
    -- Title          { }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual          { bg = gray_light }, -- Visual mode selection
    -- VisualNOS      { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg      { fg = gray_darker }, -- Warning messages
    -- Whitespace     { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    Winseparator   { VertSplit }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    WildMenu        { fg = gray_darker }, -- Current match in 'wildmenu' completion
    -- WinBar         { }, -- Window bar of current window
    -- WinBarNC       { }, -- Window bar of not-current windows

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment         { fg = green }, -- Any comment
    String          { fg = blue }, --   A string constant: "this is a string"
    Constant        { fg = blue }, -- (*) Any constant
    Character       { fg = blue }, --   A character constant: 'c', '\n'
    Number          { fg = blue }, --   A number constant: 234, 0xff
    Boolean         { fg = blue }, --   A boolean constant: TRUE, false
    Float           { fg = blue }, --   A floating point constant: 2.3e10
    Identifier      { fg = gray_darker }, -- (*) Any variable name
    Function        { fg = magenta, gui = "bold" }, --   Function name (also: methods for classes)
    Statement       { fg = magenta, gui = "bold" }, -- (*) Any statement
    Conditional     { fg = magenta, gui = "bold" }, --   if, then, else, endif, switch, etc.
    Repeat          { fg = magenta, gui = "bold" }, --   for, do, while, etc.
    Label           { fg = gray_darker }, --   case, default, etc.
    Operator        { fg = magenta, gui = "bold" }, --   "sizeof", "+", "*", etc.
    Keyword         { fg = magenta, gui = "bold" }, --   any other keyword
    Exception       { fg = lavender, gui = "bold" }, --   try, catch, throw
    PreProc         { fg = red }, -- (*) Generic Preprocessor
    Include         { fg = magenta }, --   Preprocessor #include
    Define          { fg = magenta }, --   Preprocessor #define
    Macro           { fg = magenta }, --   Same as Define
    PreCondit       { fg = red }, --   Preprocessor #if, #else, #endif, etc.

    Type            { fg = lavender }, -- (*) int, long, char, etc.
    StorageClass    { fg = lavender, gui = "bold" }, --   static, register, volatile, etc.
    Structure       { fg = lavender, gui = "bold" }, --   struct, union, enum, etc.
    Typedef         { fg = lavender, gui = "bold" }, --   A typedef

    Special         { fg = lavender }, -- (*) Any special symbol
    SpecialChar     { fg = lavender }, --   Special character in a constant
    Tag             { fg = lavender }, --   You can use CTRL-] on this
    Delimiter       { fg = lavender }, --   Character that needs attention
    SpecialComment  { fg = green }, --   Special things inside a comment (e.g. '\n')
    Debug           { fg = lavender }, --   Debugging statements

    Underlined      { fg = blue, gui = "underline" }, -- Text that stands out, HTML links
    -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error           { fg = white, bg = red }, -- Any erroneous construct
    Todo            { fg = red, bg = gray_light }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            { } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- DiagnosticError            { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticWarn             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticInfo             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticHint             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticOk               { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
    -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
    -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    -- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
    -- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
    -- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
    -- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
    -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
    -- DiagnosticUnderlineOk      { } , -- Used to underline "Ok" diagnostics.
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
    -- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    -- sym"@text.literal"      { }, -- Comment
    -- sym"@text.reference"    { }, -- Identifier
    -- sym"@text.title"        { }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    -- sym"@text.todo"         { }, -- Todo
    -- sym"@comment"           { }, -- Comment
    -- sym"@punctuation"       { }, -- Delimiter
    -- sym"@constant"          { }, -- Constant
    -- sym"@constant.builtin"  { }, -- Special
    -- sym"@constant.macro"    { }, -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    -- sym"@string"            { }, -- String
    -- sym"@string.escape"     { }, -- SpecialChar
    -- sym"@string.special"    { }, -- SpecialChar
    -- sym"@character"         { }, -- Character
    -- sym"@character.special" { }, -- SpecialChar
    -- sym"@number"            { }, -- Number
    -- sym"@boolean"           { }, -- Boolean
    -- sym"@float"             { }, -- Float
    -- sym"@function"          { }, -- Function
    -- sym"@function.builtin"  { }, -- Special
    -- sym"@function.macro"    { }, -- Macro
    -- sym"@parameter"         { }, -- Identifier
    -- sym"@method"            { }, -- Function
    -- sym"@field"             { }, -- Identifier
    -- sym"@property"          { }, -- Identifier
    -- sym"@constructor"       { }, -- Special
    -- sym"@conditional"       { }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
    -- sym"@label"             { }, -- Label
    -- sym"@operator"          { }, -- Operator
    -- sym"@keyword"           { }, -- Keyword
    -- sym"@exception"         { }, -- Exception
    -- sym"@variable"          { }, -- Identifier
    -- sym"@type"              { }, -- Type
    -- sym"@type.definition"   { }, -- Typedef
    -- sym"@storageclass"      { }, -- StorageClass
    -- sym"@structure"         { }, -- Structure
    -- sym"@namespace"         { }, -- Identifier
    -- sym"@include"           { }, -- Include
    -- sym"@preproc"           { }, -- PreProc
    -- sym"@debug"             { }, -- Debug
    -- sym"@tag"               { }, -- Tag
}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
