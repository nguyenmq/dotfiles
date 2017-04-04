" GUI color definitions
let s:gui00 = "f9fdff"          " very light blue
let s:gui01 = "000000"          " black
let s:gui02 = "ffffff"          " white
let s:gui03 = "0064ff"          " sky blue
let s:gui04 = "9bd4a9"          " olive green
let s:gui05 = "43a064"          " dark olive green
let s:gui06 = "22a21f"          " green
let s:gui07 = "0086d2"          " blue
let s:gui08 = "d3d3d3"          " light grey
let s:gui09 = "d22e2e"          " red
let s:gui0A = "ff0086"          " pink
let s:gui0B = "d99a16"          " pale yellow
let s:gui0C = "70796b"          " grey
let s:gui0D = "d16cfb"          " lavender
let s:gui0E = "dbf3cd"          " light olive green
let s:gui0F = "d6f3ff"          " light blue
let s:gui10 = "ffd2d2"          " light red
let s:gui11 = "12181a"          " dark grey

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
let s:cterm09 = "123"           " light blue
let s:cterm0A = "41"            " light green
let s:cterm0B = "228"           " light yellow
let s:cterm0C = "97"            " lavender
let s:cterm0D = "22"            " dark green
let s:cterm0E = "231"           " white
let s:cterm0F = "255"           " light grey
let s:cterm10 = "217"           " light red
let s:cterm11 = "183"           " light lavender

" Theme setup
hi clear
syntax reset
let g:colors_name = "olive"

" Highlighting function
fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=#" . s:gui(a:guifg)
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=#" . s:gui(a:guibg)
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
call <sid>hi("Directory",     s:gui0C, "", s:cterm05, "", "")
call <sid>hi("ErrorMsg",      s:gui01, s:gui00, s:cterm0E, s:cterm05, "")
call <sid>hi("Exception",     s:gui01, "", s:cterm08, "", "")
call <sid>hi("FoldColumn",    "", s:gui04, s:cterm0E, s:cterm02, "")
call <sid>hi("Folded",        s:gui05, s:gui0E, s:cterm04, s:cterm0E, "")
call <sid>hi("Italic",        "", "", "", "", "none")
call <sid>hi("MatchParen",    "", s:gui08, s:cterm05, s:cterm07,  "")
call <sid>hi("ModeMsg",       s:gui0B, "", s:cterm03, "", "")
call <sid>hi("MoreMsg",       s:gui0B, "", s:cterm03, "", "")
call <sid>hi("Question",      s:gui0A, "", s:cterm05, "", "")
call <sid>hi("SpecialKey",    s:gui03, "", s:cterm03, "", "")
call <sid>hi("TooLong",       s:gui01, "", s:cterm08, "", "")
call <sid>hi("Visual",        "", s:gui08, "", s:cterm0F, "")
call <sid>hi("VisualNOS",     s:gui01, "", s:cterm08, "", "")
call <sid>hi("WarningMsg",    s:gui01, "", s:cterm08, "", "")
call <sid>hi("WildMenu",      s:gui00, s:gui05, s:cterm08, "", "")
call <sid>hi("Title",         s:gui0C, "", s:cterm06, "", "none")
call <sid>hi("Conceal",       s:gui0C, s:gui00, s:cterm05, s:cterm00, "")
call <sid>hi("Cursor",        s:gui00, s:gui11, s:cterm00, s:cterm05, "")
call <sid>hi("NonText",       s:gui05, s:gui02, s:cterm03, "", "")
call <sid>hi("Normal",        s:gui01, s:gui00, "", "", "none")
call <sid>hi("LineNr",        s:gui05, s:gui0E, s:cterm02, s:cterm0F, "")
call <sid>hi("SignColumn",    s:gui03, s:gui01, s:cterm03, s:cterm01, "")
call <sid>hi("StatusLine",    s:gui0E, s:gui05, s:cterm02, s:cterm02, "none")
call <sid>hi("StatusLineNC",  s:gui00, s:gui04, s:cterm02, s:cterm02, "none")
call <sid>hi("VertSplit",     s:gui02, s:gui04, s:cterm02, s:cterm02, "none")
call <sid>hi("ColorColumn",   "", s:gui02, "", s:cterm09, "none")
call <sid>hi("CursorColumn",  "", s:gui01, "", s:cterm0E, "none")
call <sid>hi("CursorLine",    "", s:gui02, "", s:cterm0E, "none")
call <sid>hi("CursorLineNr",  s:gui05, s:gui02, s:cterm02, "", "")
call <sid>hi("PMenu",         s:gui02, s:gui0C, s:cterm02, s:cterm0F, "none")
call <sid>hi("PMenuSel",      s:gui02, s:gui05, s:cterm0E, s:cterm02, "")
call <sid>hi("TabLine",       s:gui03, s:gui01, s:cterm0E, s:cterm02, "none")
call <sid>hi("TabLineFill",   s:gui03, s:gui01, s:cterm0D, s:cterm02, "none")
call <sid>hi("TabLineSel",    s:gui09, s:gui01, s:cterm0E, s:cterm0D, "none")
call <sid>hi("Search",        s:gui09, s:gui04, s:cterm00, s:cterm0B,  "none")
call <sid>link_group("IncSearch", "Search")
call <sid>hi("CtrlPMatch",    "",      "",      s:cterm06, s:cterm0F, "")

" Standard syntax highlighting
call <sid>hi("Boolean",         s:gui07, "", s:cterm04, "", "")
call <sid>hi("Character",       s:gui07, "", s:cterm04, "", "")
call <sid>hi("Comment",         s:gui06, "", s:cterm02, "", "")
call <sid>hi("Conditional",     s:gui0B, "", s:cterm05, "", "bold")
call <sid>hi("Constant",        s:gui07, "", s:cterm04, "", "")
call <sid>hi("Debug",           s:gui0D, "", s:cterm0C, "", "none")
call <sid>hi("Define",          s:gui09, "", s:cterm01, "", "none")
call <sid>hi("Delimiter",       s:gui0D, "", s:cterm0C, "", "")
call <sid>hi("Error",           s:gui01, s:gui09, s:cterm0F, s:cterm01, "")
call <sid>hi("Exception",       s:gui0B, "", s:cterm06, "", "bold")
call <sid>hi("Float",           s:gui07, "", s:cterm04, "", "")
call <sid>hi("Function",        s:gui0A, "", s:cterm01, "", "bold")
call <sid>hi("Identifier",      s:gui0A, "", s:cterm03, "", "none")
call <sid>hi("Include",         s:gui09, "", s:cterm01, "", "")
call <sid>hi("Keyword",         s:gui0B, "", s:cterm05, "", "bold")
call <sid>hi("Label",           s:gui03, "", s:cterm03, "", "")
call <sid>hi("Macro",           s:gui09, "", s:cterm01, "", "")
call <sid>hi("Number",          s:gui07, "", s:cterm04, "", "")
call <sid>hi("Operator",        s:gui0B, "", s:cterm05, "", "bold")
call <sid>hi("PreCondit",       s:gui09, "", s:cterm01, "", "")
call <sid>hi("PreProc",         s:gui09, "", s:cterm01, "", "")
call <sid>hi("Repeat",          s:gui0B, "", s:cterm05, "", "bold")
call <sid>hi("Special",         s:gui0D, "", s:cterm06, "", "")
call <sid>hi("SpecialChar",     s:gui0D, "", s:cterm0C, "", "")
call <sid>hi("SpecialComment",  s:gui0D, "", s:cterm0C, "", "")
call <sid>hi("Statement",       s:gui0B, "", s:cterm05, "", "bold")
call <sid>hi("StorageClass",    s:gui0C, "", s:cterm06, "", "bold")
call <sid>hi("String",          s:gui07, "", s:cterm04, "", "")
call <sid>hi("Structure",       s:gui0C, "", s:cterm06, "", "bold")
call <sid>hi("Tag",             s:gui0D, "", s:cterm0C, "", "")
call <sid>hi("Todo",            s:gui09, s:gui0E, s:cterm01, s:cterm0F, "bold")
call <sid>hi("Type",            s:gui0C, "", s:cterm06, "", "bold")
call <sid>hi("Typedef",         s:gui0C, "", s:cterm06, "", "bold")
call <sid>hi("Underlined",      s:gui07, "", s:cterm04, "", "")

" Spelling highlighting
call <sid>hi("SpellBad",     "", s:gui00, s:cterm01, "", "undercurl")
call <sid>hi("SpellLocal",   "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellCap",     "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellRare",    "", s:gui00, "", s:cterm00, "undercurl")

" Additional diff highlighting
call <sid>hi("DiffAdd",      "",      s:gui0F, "", s:cterm09, "")
call <sid>hi("DiffChange",   "",      s:gui0F, s:cterm00, s:cterm0F, "")
call <sid>hi("DiffDelete",   s:gui01, s:gui10, s:cterm01, s:cterm10, "")
call <sid>hi("DiffText",     "",      s:gui0F, s:cterm00, s:cterm11, "none")
call <sid>hi("DiffAdded",    "",      s:gui0F, s:cterm02, "",        "")
call <sid>hi("DiffFile",     s:gui08, s:gui0F, s:cterm0C, "",        "")
call <sid>hi("DiffNewFile",  s:gui0B, s:gui0F, s:cterm04, "",        "")
call <sid>hi("DiffLine",     s:gui01, s:gui0F, s:cterm02, "",        "")
call <sid>hi("DiffRemoved",  s:gui08, s:gui0F, s:cterm01, "",        "")

" HTML highlighting
call <sid>hi("htmlBold",    s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("htmlItalic",  s:gui06, "", s:cterm02, "", "")
call <sid>hi("htmlEndTag",  s:gui05, "", s:cterm05, "", "")
call <sid>hi("htmlTag",     s:gui05, "", s:cterm05, "", "")

" CSS highlighting
call <sid>hi("cssBraces",      s:gui05, "", s:cterm05, "", "")
call <sid>hi("cssClassName",   s:gui0E, "", s:cterm06, "", "")
call <sid>hi("cssColor",       s:gui0C, "", s:cterm0C, "", "")

" SASS highlighting
call <sid>hi("sassidChar",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("sassClassChar",  s:gui09, "", s:cterm09, "", "")
call <sid>hi("sassInclude",    s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("sassMixing",     s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("sassMixinName",  s:gui0C, "", s:cterm05, "", "")

" JavaScript highlighting
call <sid>hi("javaScript",        s:gui05, "", s:cterm05, "", "")
call <sid>hi("javaScriptBraces",  s:gui05, "", s:cterm05, "", "")
call <sid>hi("javaScriptNumber",  s:gui08, "", s:cterm08, "", "")

" Markdown highlighting
call <sid>hi("markdownCode",              s:gui05, "", s:cterm06, "", "")
call <sid>hi("markdownCodeBlock",         s:gui0B, "", s:cterm03, "", "")
call <sid>hi("markdownHeadingDelimiter",  s:gui06, "", s:cterm02, "", "")
call <sid>hi("markdownH1",                s:gui06, "", s:cterm02, "", "")
call <sid>hi("markdownH2",                s:gui06, "", s:cterm02, "", "")
call <sid>hi("markdownH3",                s:gui06, "", s:cterm02, "", "")
call <sid>hi("markdownH4",                s:gui06, "", s:cterm02, "", "")
call <sid>hi("markdownH5",                s:gui06, "", s:cterm02, "", "")
call <sid>hi("markdownH6",                s:gui06, "", s:cterm02, "", "")
call <sid>hi("markdownItalic",            s:gui11, "", s:cterm08, "", "")
call <sid>hi("markdownBold",              s:gui11, "", s:cterm08, "", "")
call <sid>hi("markdownBoldItalic",        s:gui11, "", s:cterm08, "", "")
call <sid>hi("markdownUrl",               s:gui07, "", s:cterm04, "", "")
call <sid>hi("markdownUrlTitle",          s:gui07, "", s:cterm04, "", "")
call <sid>hi("markdownListMarker",        s:gui03, "", s:cterm06, "", "")
call <sid>hi("markdownError",             "", "", s:cterm05, "", "")
call <sid>hi("markdownCodeDelimiter",     s:gui06, "", s:cterm02, "", "")
call <sid>hi("markdownHighlight",         s:gui06, "", s:cterm02, "", "")
call <sid>hi("markdownCodeBlock",         s:gui03, "", s:cterm00, "", "")
call <sid>hi("markdownBlockquote",        s:gui03, "", s:cterm06, "", "")
call <sid>hi("markdownBlock",             s:gui03, "", s:cterm06, "", "")
call <sid>hi("markdownEscape",            "", "", s:cterm05, "", "")

" Git highlighting
call <sid>hi("gitCommitOverflow",  s:gui08, "", s:cterm01, "", "")
call <sid>hi("gitCommitSummary",   s:gui0B, "", s:cterm06, "", "")

" CtrlP highlighting
call <sid>hi("CtrlPBufferNr",     "", "", s:cterm06, "", "")
call <sid>hi("CtrlPBufferInd",    "", "", "", "", "")
call <sid>hi("CtrlPBufferHid",    "", "", s:cterm00, "", "")
call <sid>hi("CtrlPBufferHidMod", "", "", s:cterm00, "", "")
call <sid>hi("CtrlPBufferVis",    "", "", s:cterm00, "", "")
call <sid>hi("CtrlPBufferVisMod", "", "", s:cterm01, "", "bold")
call <sid>hi("CtrlPBufferCur",    "", "", s:cterm00, "", "")
call <sid>hi("CtrlPBufferCurMod", "", "", s:cterm01, "", "bold")
call <sid>hi("CtrlPBufferPath",   "", "", s:cterm05, "", "")

" Java Highlighting
call <sid>hi("javaCommentTitle",   s:gui06, "", s:cterm02, "", "")

" xml Highlighting
call <sid>hi("xmlTagName", "", "", s:cterm06, "", "")
call <sid>hi("xmlTag",     "", "", s:cterm06, "", "")
call <sid>hi("xmlEndTag",  "", "", s:cterm06, "", "")
call <sid>hi("xmlAttrib",  "", "", s:cterm01, "", "")

" Remove functions
delf <sid>hi
delf <sid>gui
delf <sid>cterm


" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F s:gui10 s:gui11
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F s:cterm10 s:cterm11
