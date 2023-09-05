" GUI color definitions
let s:gui00 = "{{black_almost}}"
let s:gui01 = "{{red}}"
let s:gui02 = "{{green}}"
let s:gui03 = "{{yellow}}"
let s:gui04 = "{{blue}}"
let s:gui05 = "{{magenta}}"
let s:gui06 = "{{lavender}}"
let s:gui07 = "{{gray_dark}}"

let s:gui08 = "#767676"          " dark grey
let s:gui09 = "#afffff"          " light blue, can replace
let s:gui0A = "#e7ffec"          " light green, used only for diffs
let s:gui0B = "#ffff87"          " pale yellow, used only for cursor line
let s:gui0C = "#875faf"          " lavender
let s:gui0D = "{{green_dark}}"   " dark green
let s:gui0E = "{{white}}"        " white
let s:gui0F = "#eeeeee"          " light gray
let s:gui10 = "#ffe4e6"          " light red, used only diffs
let s:gui11 = "{{yellow_light}}" " used only for search
let s:gui12 = "#cfe5d4"          " more green, used only for diff

" d6f3ff light blue

" Terminal color definitions
let s:cterm00 = "00"            " terminal black
let s:cterm01 = "01"            " terminal red
let s:cterm02 = "02"            " terminal green
let s:cterm03 = "03"            " terminal yellow
let s:cterm04 = "04"            " terminal blue
let s:cterm05 = "05"            " terminal magenta
let s:cterm06 = "06"            " terminal cyan
let s:cterm07 = "07"            " terminal white

let s:cterm08 = "243"           " dark grey
let s:cterm09 = "159"           " light blue
let s:cterm0A = "194"           " light green
let s:cterm0B = "228"           " light yellow
let s:cterm0C = "97"            " lavender
let s:cterm0D = "22"            " dark green
let s:cterm0E = "231"           " white
let s:cterm0F = "255"           " light grey
let s:cterm10 = "217"           " light red
let s:cterm11 = "183"           " light lavender
let s:cterm12 = "42"            " moar green

" Theme setup
hi clear
syntax reset
let g:colors_name = "olive"

" Highlighting function
fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=" . s:gui(a:guifg)
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=" . s:gui(a:guibg)
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . s:cterm(a:ctermfg)
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . s:cterm(a:ctermbg)
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun

fun! <sid>link_group(fromgroup, togroup)
    exec "hi! link " . a:fromgroup . " " . a:togroup
endfun

" Return GUI color for light/dark variants
fun s:gui(color)
return a:color
endfun

" Return terminal color for light/dark variants
fun s:cterm(color)
return a:color
endfun

" Vim editor colors
call <sid>hi("Bold",          "", "", "", "", "bold")
call <sid>hi("Directory",     s:gui05, "", s:cterm05, "", "")
call <sid>hi("ErrorMsg",      s:gui0E, s:gui05, s:cterm0E, s:cterm05, "")
call <sid>hi("Exception",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("FoldColumn",    s:gui0E, s:gui02, s:cterm0E, s:cterm02, "")
call <sid>hi("Folded",        s:gui04, s:gui0E, s:cterm04, s:cterm0E, "")
call <sid>hi("Italic",        "", "", "", "", "none")
call <sid>hi("MatchParen",    s:gui05, s:gui07, s:cterm05, s:cterm07,  "")
call <sid>hi("ModeMsg",       s:gui03, "", s:cterm03, "", "")
call <sid>hi("MoreMsg",       s:gui03, "", s:cterm03, "", "")
call <sid>hi("Question",      s:gui05, "", s:cterm05, "", "")
call <sid>hi("SpecialKey",    s:gui03, "", s:cterm03, "", "")
call <sid>hi("TooLong",       s:gui08, "", s:cterm08, "", "")
call <sid>hi("Visual",        "", s:gui0F, "", s:cterm0F, "")
call <sid>hi("VisualNOS",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("WarningMsg",    s:gui08, "", s:cterm08, "", "")
call <sid>hi("WildMenu",      s:gui08, "", s:cterm08, "", "")
call <sid>hi("Title",         s:gui02, "", s:cterm02, "", "bold")
call <sid>hi("Conceal",       s:gui05, s:gui00, s:cterm05, s:cterm00, "")
call <sid>hi("Cursor",        "", s:gui00, s:cterm00, s:cterm05, "")
call <sid>hi("NonText",       s:gui03, "", s:cterm03, "", "")
call <sid>hi("Normal",        "", "", "", "", "none")
call <sid>hi("LineNr",        "{{green}}", "{{white}}", s:cterm02, s:cterm0E, "none")
call <sid>hi("LineNrAbove",   "{{green}}", "{{gray_light}}", s:cterm02, s:cterm0F, "none")
call <sid>hi("LineNrBelow",   "{{green}}", "{{gray_light}}", s:cterm02, s:cterm0F, "none")
call <sid>hi("SignColumn",    "{{green}}", "{{gray_light}}", s:cterm03, s:cterm01, "")
call <sid>hi("StatusLine",    "{{ui_primary}}", "{{ui_primary}}", s:cterm02, s:cterm02, "none")
call <sid>hi("StatusLineNC",  "{{ui_primary}}", "{{ui_primary}}", s:cterm0D, s:cterm02, "none")
call <sid>hi("VertSplit",     "{{ui_primary}}", "{{ui_primary}}", s:cterm02, s:cterm02, "none")
call <sid>hi("ColorColumn",   "", s:gui0F, "", s:cterm0F, "none")
call <sid>hi("CursorColumn",  "", s:gui0E, "", s:cterm0E, "none")
call <sid>hi("CursorLine",    "", s:gui0B, "", s:cterm0B, "none")
call <sid>hi("CursorLineNr",  s:gui02, s:gui0B, s:cterm02, s:cterm0B, "none")
call <sid>hi("PMenu",         s:gui02, s:gui0F, s:cterm02, s:cterm0F, "none")
call <sid>hi("PMenuSel",      s:gui0E, s:gui02, s:cterm0E, s:cterm02, "")
call <sid>hi("TabLine",       s:gui0E, s:gui02, s:cterm0E, s:cterm02, "none")
call <sid>hi("TabLineFill",   s:gui0D, s:gui02, s:cterm0D, s:cterm02, "none")
call <sid>hi("TabLineSel",    s:gui0E, s:gui0D, s:cterm0E, s:cterm0D, "none")
call <sid>hi("Search",        "{{black}}", s:gui11, s:cterm00, s:cterm11,  "")
call <sid>link_group("IncSearch", "Search")
call <sid>hi("CtrlPMatch",    s:gui06, s:gui0F, s:cterm06, s:cterm0F, "")

" Standard syntax highlighting
call <sid>hi("Boolean",         s:gui04, "", s:cterm04, "", "")
call <sid>hi("Character",       s:gui04, "", s:cterm04, "", "")
call <sid>hi("Comment",         s:gui02, "", s:cterm02, "", "")
call <sid>hi("Conditional",     s:gui05, "", s:cterm05, "", "bold")
call <sid>hi("Constant",        s:gui04, "", s:cterm04, "", "")
call <sid>hi("Debug",           s:gui0C, "", s:cterm0C, "", "none")
call <sid>hi("Define",          s:gui01, "", s:cterm01, "", "none")
call <sid>hi("Delimiter",       s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("Error",           "{{white}}", "{{red}}", s:cterm0F, s:cterm01, "")
call <sid>hi("Exception",       s:gui06, "", s:cterm06, "", "bold")
call <sid>hi("Float",           s:gui04, "", s:cterm04, "", "")
call <sid>hi("Function",        s:gui01, "", s:cterm01, "", "bold")
call <sid>hi("Identifier",      s:gui08, "", s:cterm08, "", "none")
call <sid>hi("Include",         s:gui01, "", s:cterm01, "", "")
call <sid>hi("Keyword",         s:gui05, "", s:cterm05, "", "bold")
call <sid>hi("Label",           s:gui08, "", s:cterm08, "", "")
call <sid>hi("Macro",           s:gui01, "", s:cterm01, "", "")
call <sid>hi("Number",          s:gui04, "", s:cterm04, "", "")
call <sid>hi("Operator",        s:gui05, "", s:cterm05, "", "bold")
call <sid>hi("PreCondit",       s:gui01, "", s:cterm01, "", "")
call <sid>hi("PreProc",         s:gui01, "", s:cterm01, "", "")
call <sid>hi("Repeat",          s:gui05, "", s:cterm05, "", "bold")
call <sid>hi("Special",         s:gui06, "", s:cterm06, "", "")
call <sid>hi("SpecialChar",     s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("SpecialComment",  s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("Statement",       s:gui05, "", s:cterm05, "", "bold")
call <sid>hi("StorageClass",    s:gui06, "", s:cterm06, "", "bold")
call <sid>hi("String",          s:gui04, "", s:cterm04, "", "")
call <sid>hi("Structure",       s:gui06, "", s:cterm06, "", "bold")
call <sid>hi("Tag",             s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("Todo",            s:gui01, s:gui0F, s:cterm01, s:cterm0F, "bold")
call <sid>hi("Type",            s:gui06, "", s:cterm06, "", "bold")
call <sid>hi("Typedef",         s:gui06, "", s:cterm06, "", "bold")
call <sid>hi("Underlined",      s:gui04, "", s:cterm04, "", "")

" Spelling highlighting
call <sid>hi("SpellBad",     s:gui01, "", s:cterm01, "", "undercurl")
call <sid>hi("SpellLocal",   "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellCap",     "", "", "", "", "undercurl")
call <sid>hi("SpellRare",    "", s:gui00, "", s:cterm00, "undercurl")

" Additional diff highlighting
call <sid>hi("DiffAdd",      "", s:gui0A, "", s:cterm0A, "")
call <sid>hi("DiffChange",   "", s:gui0A, "", s:cterm0A, "")
call <sid>hi("DiffDelete",   s:gui01, s:gui10, s:cterm01, s:cterm10, "")
call <sid>hi("DiffText",     s:gui00, s:gui12, s:cterm00, s:cterm12, "none")
call <sid>hi("DiffAdded",    s:gui02, "", s:cterm02, "", "")
call <sid>hi("DiffFile",     s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("DiffNewFile",  s:gui04, "", s:cterm04, "", "")
call <sid>hi("DiffLine",     s:gui02, "", s:cterm02, "", "")
call <sid>hi("DiffRemoved",  s:gui01, "", s:cterm01, "", "")

" HTML highlighting
call <sid>hi("htmlBold",    "", "", "", "", "bold")
call <sid>hi("htmlItalic",  "", "", "", "", "italic")
call <sid>hi("htmlEndTag",  s:gui05, "", s:cterm05, "", "")
call <sid>hi("htmlTag",     s:gui05, "", s:cterm05, "", "")
call <sid>hi("htmlStrike",  s:gui08, "", s:cterm08, "", "strikethrough")
call <sid>hi("htmlLink",    s:gui04, "", s:cterm04, "", "")

" CSS highlighting
call <sid>hi("cssBraces",      s:gui05, "", s:cterm05, "", "")
call <sid>hi("cssClassName",   s:gui06, "", s:cterm06, "", "")
call <sid>hi("cssColor",       s:gui0C, "", s:cterm0C, "", "")

" SASS highlighting
call <sid>hi("sassidChar",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("sassClassChar",  s:gui09, "", s:cterm09, "", "")
call <sid>hi("sassInclude",    s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("sassMixing",     s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("sassMixinName",  s:gui05, "", s:cterm05, "", "")

" JavaScript highlighting
call <sid>hi("javaScript",        s:gui05, "", s:cterm05, "", "")
call <sid>hi("javaScriptBraces",  s:gui05, "", s:cterm05, "", "")
call <sid>hi("javaScriptNumber",  s:gui08, "", s:cterm08, "", "")

" Markdown highlighting
call <sid>hi("markdownCode",              s:gui08, "", s:cterm08, "", "")
call <sid>hi("markdownHeadingDelimiter",  s:gui02, "", s:cterm02, "", "")
call <sid>hi("markdownH1",                s:gui02, "", s:cterm02, "", "")
call <sid>hi("markdownH2",                s:gui02, "", s:cterm02, "", "")
call <sid>hi("markdownH3",                s:gui02, "", s:cterm02, "", "")
call <sid>hi("markdownH4",                s:gui02, "", s:cterm02, "", "")
call <sid>hi("markdownH5",                s:gui02, "", s:cterm02, "", "")
call <sid>hi("markdownH6",                s:gui02, "", s:cterm02, "", "")
call <sid>hi("markdownItalic",            s:gui06, "", s:cterm06, "", "")
call <sid>hi("markdownBold",              s:gui06, "", s:cterm06, "", "")
call <sid>hi("markdownBoldItalic",        s:gui06, "", s:cterm06, "", "")
call <sid>hi("markdownUrl",               s:gui04, "", s:cterm04, "", "")
call <sid>hi("markdownUrlTitle",          s:gui04, "", s:cterm04, "", "")
call <sid>hi("markdownListMarker",        s:gui06, "", s:cterm06, "", "")
call <sid>hi("markdownError",             s:gui05, "", s:cterm05, "", "")
call <sid>hi("markdownCodeDelimiter",     s:gui02, "", s:cterm02, "", "")
call <sid>hi("markdownHighlight",         s:gui02, "", s:cterm02, "", "")
call <sid>hi("markdownCodeBlock",         s:gui08, "", s:cterm08, "", "")
call <sid>hi("markdownBlockquote",        s:gui06, "", s:cterm06, "", "")
call <sid>hi("markdownBlock",             s:gui06, "", s:cterm06, "", "")
call <sid>hi("markdownEscape",            s:gui05, "", s:cterm05, "", "")

call <sid>hi("mkdBold",                   s:gui00, "", s:cterm00, "", "")
call <sid>hi("mkdCode",                   s:gui08, "", s:cterm08, "", "")
call <sid>link_group("mkdCodeDelimiter",  "mkdCode")
call <sid>link_group("mkdCodeStart",      "mkdCode")
call <sid>link_group("mkdCodeEnd",        "mkdCode")
call <sid>hi("mkdBlockquote",             s:gui05, "", s:cterm05, "", "italic")

" Git highlighting
call <sid>hi("gitCommitOverflow",  s:gui01, "", s:cterm01, "", "")
call <sid>hi("gitCommitSummary",   s:gui06, "", s:cterm06, "", "")

" ALE highlighting
call <sid>hi("ALEErrorSign",   "{{red}}",   "{{gray_light}}", "", "", "")
call <sid>hi("ALEError",       "{{white}}", "{{red}}",        "", "", "")
call <sid>hi("ALEWarningSign", "{{blue}}",  "{{gray_light}}", "", "", "")
call <sid>hi("ALEWarning",     "{{blue}}",  "",               "", "", "underline")

" Java Highlighting
call <sid>hi("javaCommentTitle",   s:gui02, "", s:cterm02, "", "")

" xml Highlighting
call <sid>hi("xmlTagName", s:gui06, "", s:cterm06, "", "")
call <sid>hi("xmlTag",     s:gui06, "", s:cterm06, "", "")
call <sid>hi("xmlEndTag",  s:gui06, "", s:cterm06, "", "")
call <sid>hi("xmlAttrib",  s:gui01, "", s:cterm01, "", "")

" Remove functions
delf <sid>hi
delf <sid>gui
delf <sid>cterm

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F s:gui10 s:gui11 s:gui12
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F s:cterm10 s:cterm11
