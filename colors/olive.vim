" GUI color definitions
let s:gui00 = "ffffff"          " white
let s:gui01 = "000000"          " black
let s:gui02 = "f2fff8"          " very light green
let s:gui03 = "438ec3"          " sky blue
let s:gui04 = "9bd4a9"          " olive green
let s:gui05 = "43a064"          " dark olive green
let s:gui06 = "22a21f"          " green
let s:gui07 = "0086d2"          " blue
let s:gui08 = "d3d3d3"          " light grey
let s:gui09 = "d22e2e"          " red
let s:gui0A = "ff0086"          " pink
let s:gui0B = "e6cf07"          " pale yellow
let s:gui0C = "70796b"          " grey
let s:gui0D = "d16cfb"          " lavender
let s:gui0E = "dbf3cd"          " light olive green

let s:gui0F = "ffffff"          " white duh
let s:gui10 = "106510"          " green
let s:gui11 = "12181a"          " dark grey, but lighter than gui00

" Terminal color definitions
let s:cterm00 = "00"
let s:cterm03 = "08"
let s:cterm05 = "07"
let s:cterm07 = "15"
let s:cterm08 = "01"
let s:cterm0A = "03"
let s:cterm0B = "02"
let s:cterm0C = "06"
let s:cterm0D = "04"
let s:cterm0E = "05"
if exists('base16colorspace') && base16colorspace == "256"
  let s:cterm01 = "18"
  let s:cterm02 = "19"
  let s:cterm04 = "20"
  let s:cterm06 = "21"
  let s:cterm09 = "16"
  let s:cterm0F = "17"
else
  let s:cterm01 = "10"
  let s:cterm02 = "11"
  let s:cterm04 = "12"
  let s:cterm06 = "13"
  let s:cterm09 = "09"
  let s:cterm0F = "14"
endif

" Theme setup
hi clear
syntax reset
let g:colors_name = "lime"

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

" Return GUI color for light/dark variants
fun s:gui(color)
  if &background == "dark"
    return a:color
  endif

  if a:color == s:gui00
    return s:gui07
  elseif a:color == s:gui01
    return s:gui06
  elseif a:color == s:gui02
    return s:gui05
  elseif a:color == s:gui03
    return s:gui04
  elseif a:color == s:gui04
    return s:gui03
  elseif a:color == s:gui05
    return s:gui02
  elseif a:color == s:gui06
    return s:gui01
  elseif a:color == s:gui07
    return s:gui00
  endif

  return a:color
endfun

" Return terminal color for light/dark variants
fun s:cterm(color)
  if &background == "dark"
    return a:color
  endif

  if a:color == s:cterm00
    return s:cterm07
  elseif a:color == s:cterm01
    return s:cterm06
  elseif a:color == s:cterm02
    return s:cterm05
  elseif a:color == s:cterm03
    return s:cterm04
  elseif a:color == s:cterm04
    return s:cterm03
  elseif a:color == s:cterm05
    return s:cterm02
  elseif a:color == s:cterm06
    return s:cterm01
  elseif a:color == s:cterm07
    return s:cterm00
  endif

  return a:color
endfun

" Vim editor colors
call <sid>hi("Bold",          "", "", "", "", "bold")
call <sid>hi("Directory",     s:gui0C, "", s:cterm0D, "", "")
call <sid>hi("ErrorMsg",      s:gui08, s:gui00, s:cterm08, s:cterm00, "")
call <sid>hi("Exception",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("FoldColumn",    "", s:gui01, "", s:cterm01, "")
call <sid>hi("Folded",        s:gui03, s:gui11, s:cterm03, s:cterm01, "")
call <sid>hi("IncSearch",     s:gui09, s:gui04, s:cterm01, s:cterm09, "none")
call <sid>hi("Italic",        "", "", "", "", "none")
call <sid>hi("Macro",         s:gui09, "", s:cterm08, "", "")
call <sid>hi("MatchParen",    "", s:gui0B, s:cterm00, s:cterm03,  "")
call <sid>hi("ModeMsg",       s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("MoreMsg",       s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("Question",      s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("Search",        s:gui09, s:gui04, s:cterm03, s:cterm0A,  "")
call <sid>hi("SpecialKey",    s:gui03, "", s:cterm03, "", "")
call <sid>hi("TooLong",       s:gui08, "", s:cterm08, "", "")
call <sid>hi("Underlined",    s:gui07, "", s:cterm08, "", "")
call <sid>hi("Visual",        "", s:gui08, "", s:cterm02, "")
call <sid>hi("VisualNOS",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("WarningMsg",    s:gui08, "", s:cterm08, "", "")
call <sid>hi("WildMenu",      s:gui00, s:gui05, s:cterm08, "", "")
call <sid>hi("Title",         s:gui0C, "", s:cterm0D, "", "none")
call <sid>hi("Conceal",       s:gui0C, s:gui00, s:cterm0D, s:cterm00, "")
call <sid>hi("Cursor",        s:gui00, s:gui11, s:cterm00, s:cterm05, "")
call <sid>hi("NonText",       "",      s:gui02, s:cterm03, "", "")
call <sid>hi("Normal",        s:gui01, s:gui00, s:cterm05, s:cterm00, "")
call <sid>hi("LineNr",        s:gui05, s:gui0E, s:cterm03, s:cterm01, "")
call <sid>hi("SignColumn",    s:gui03, s:gui01, s:cterm03, s:cterm01, "")
call <sid>hi("SpecialKey",    s:gui03, "", s:cterm03, "", "")
call <sid>hi("StatusLine",    s:gui0E, s:gui05, s:cterm04, s:cterm02, "none")
call <sid>hi("StatusLineNC",  s:gui00, s:gui04, s:cterm03, s:cterm01, "none")
call <sid>hi("VertSplit",     s:gui02, s:gui04, s:cterm02, s:cterm02, "none")
call <sid>hi("ColorColumn",   "", s:gui02, "", s:cterm01, "none")
call <sid>hi("CursorColumn",  "", s:gui01, "", s:cterm01, "none")
call <sid>hi("CursorLine",    "", s:gui02, "", s:cterm01, "none")
call <sid>hi("CursorLineNr",  s:gui05, s:gui02, s:cterm03, s:cterm01, "")
call <sid>hi("PMenu",         s:gui00, s:gui05, s:cterm04, s:cterm01, "none")
call <sid>hi("PMenuSel",      s:gui00, s:gui05, s:cterm01, s:cterm04, "")
call <sid>hi("TabLine",       s:gui03, s:gui01, s:cterm03, s:cterm01, "none")
call <sid>hi("TabLineFill",   s:gui03, s:gui01, s:cterm03, s:cterm01, "none")
call <sid>hi("TabLineSel",    s:gui09, s:gui01, s:cterm0B, s:cterm01, "none")

" Standard syntax highlighting
call <sid>hi("Boolean",         s:gui07, "", s:cterm09, "", "")
call <sid>hi("Character",       s:gui07, "", s:cterm08, "", "")
call <sid>hi("Comment",         s:gui06, "", s:cterm03, "", "")
call <sid>hi("Conditional",     s:gui0B, "", s:cterm0E, "", "bold")
call <sid>hi("Constant",        s:gui07, "", s:cterm09, "", "")
call <sid>hi("Define",          s:gui09, "", s:cterm0E, "", "none")
call <sid>hi("Debug",           s:gui0D, "", s:cterm0E, "", "none")
call <sid>hi("Delimiter",       s:gui0D, "", s:cterm0F, "", "")
call <sid>hi("Exception",       s:gui0B, "", s:cterm09, "", "bold")
call <sid>hi("Float",           s:gui07, "", s:cterm09, "", "")
call <sid>hi("Function",        s:gui0A, "", s:cterm0D, "", "")
call <sid>hi("Identifier",      s:gui0A, "", s:cterm08, "", "none")
call <sid>hi("Include",         s:gui09, "", s:cterm0D, "", "")
call <sid>hi("Keyword",         s:gui0B, "", s:cterm0E, "", "bold")
call <sid>hi("Label",           s:gui0D, "", s:cterm0A, "", "")
call <sid>hi("Number",          s:gui07, "", s:cterm09, "", "")
call <sid>hi("Operator",        s:gui0B, "", s:cterm05, "", "bold")
call <sid>hi("PreCondit",       s:gui09, "", s:cterm0A, "", "")
call <sid>hi("PreProc",         s:gui09, "", s:cterm0A, "", "")
call <sid>hi("Repeat",          s:gui0B, "", s:cterm0A, "", "bold")
call <sid>hi("Special",         s:gui0D, "", s:cterm0C, "", "")
call <sid>hi("SpecialChar",     s:gui0D, "", s:cterm0F, "", "")
call <sid>hi("SpecialComment",  s:gui0D, "", s:cterm0F, "", "")
call <sid>hi("Statement",       s:gui0B, "", s:cterm08, "", "")
call <sid>hi("StorageClass",    s:gui0C, "", s:cterm0A, "", "bold")
call <sid>hi("String",          s:gui07, "", s:cterm0B, "", "")
call <sid>hi("Structure",       s:gui0C, "", s:cterm0E, "", "bold")
call <sid>hi("Tag",             s:gui0D, "", s:cterm0A, "", "")
call <sid>hi("Todo",            s:gui09, s:gui0E, s:cterm0A, s:cterm01, "")
call <sid>hi("Type",            s:gui0C, "", s:cterm09, "", "bold")
call <sid>hi("Typedef",         s:gui0C, "", s:cterm0A, "", "bold")

" Spelling highlighting
call <sid>hi("SpellBad",     "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellLocal",   "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellCap",     "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellRare",    "", s:gui00, "", s:cterm00, "undercurl")

" Additional diff highlighting
call <sid>hi("DiffAdd",      s:gui0B, s:gui00, s:cterm0B, s:cterm00, "")
call <sid>hi("DiffChange",   s:gui0C, s:gui00, s:cterm0D, s:cterm00, "")
call <sid>hi("DiffDelete",   s:gui08, s:gui00, s:cterm08, s:cterm00, "")
call <sid>hi("DiffText",     s:gui0C, s:gui00, s:cterm0D, s:cterm00, "")
call <sid>hi("DiffAdded",    s:gui0B, s:gui00, s:cterm0B, s:cterm00, "")
call <sid>hi("DiffFile",     s:gui08, s:gui00, s:cterm08, s:cterm00, "")
call <sid>hi("DiffNewFile",  s:gui0B, s:gui00, s:cterm0B, s:cterm00, "")
call <sid>hi("DiffLine",     s:gui0C, s:gui00, s:cterm0D, s:cterm00, "")
call <sid>hi("DiffRemoved",  s:gui08, s:gui00, s:cterm08, s:cterm00, "")

" Ruby highlighting
call <sid>hi("rubyAttribute",               s:gui0C, "", s:cterm0D, "", "")
call <sid>hi("rubyConstant",                s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("rubyInterpolation",           s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("rubyInterpolationDelimiter",  s:gui0C, "", s:cterm0F, "", "")
call <sid>hi("rubyRegexp",                  s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("rubySymbol",                  s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("rubyStringDelimiter",         s:gui0B, "", s:cterm0B, "", "")

" PHP highlighting
call <sid>hi("phpMemberSelector",  s:gui05, "", s:cterm05, "", "")
call <sid>hi("phpComparison",      s:gui05, "", s:cterm05, "", "")
call <sid>hi("phpParent",          s:gui05, "", s:cterm05, "", "")

" HTML highlighting
call <sid>hi("htmlBold",    s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("htmlItalic",  s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("htmlEndTag",  s:gui05, "", s:cterm05, "", "")
call <sid>hi("htmlTag",     s:gui05, "", s:cterm05, "", "")

" CSS highlighting
call <sid>hi("cssBraces",      s:gui05, "", s:cterm05, "", "")
call <sid>hi("cssClassName",   s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("cssColor",       s:gui0C, "", s:cterm0C, "", "")

" SASS highlighting
call <sid>hi("sassidChar",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("sassClassChar",  s:gui09, "", s:cterm09, "", "")
call <sid>hi("sassInclude",    s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("sassMixing",     s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("sassMixinName",  s:gui0C, "", s:cterm0D, "", "")

" JavaScript highlighting
call <sid>hi("javaScript",        s:gui05, "", s:cterm05, "", "")
call <sid>hi("javaScriptBraces",  s:gui05, "", s:cterm05, "", "")
call <sid>hi("javaScriptNumber",  s:gui09, "", s:cterm09, "", "")

" Markdown highlighting
call <sid>hi("markdownCode",              s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("markdownCodeBlock",         s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("markdownHeadingDelimiter",  s:gui0C, "", s:cterm0D, "", "")

" Git highlighting
call <sid>hi("gitCommitOverflow",  s:gui08, "", s:cterm08, "", "")
call <sid>hi("gitCommitSummary",   s:gui0B, "", s:cterm0B, "", "")

" GitGutter highlighting
call <sid>hi("GitGutterAdd",     s:gui0B, s:gui01, s:cterm0B, s:cterm01, "")
call <sid>hi("GitGutterChange",  s:gui0C, s:gui01, s:cterm0D, s:cterm01, "")
call <sid>hi("GitGutterDelete",  s:gui08, s:gui01, s:cterm08, s:cterm01, "")
call <sid>hi("GitGutterChangeDelete",  s:gui0E, s:gui01, s:cterm0E, s:cterm01, "")

" Signify highlighting
call <sid>hi("SignifySignAdd",     s:gui0B, s:gui01, s:cterm0B, s:cterm01, "")
call <sid>hi("SignifySignChange",  s:gui0C, s:gui01, s:cterm0D, s:cterm01, "")
call <sid>hi("SignifySignDelete",  s:gui08, s:gui01, s:cterm08, s:cterm01, "")

" NERDTree highlighting
call <sid>hi("NERDTreeDirSlash",  s:gui0C, "", s:cterm0D, "", "")
call <sid>hi("NERDTreeExecFile",  s:gui05, "", s:cterm05, "", "")

" Remove functions
delf <sid>hi
delf <sid>gui
delf <sid>cterm

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F s:gui10 s:gui11
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F
