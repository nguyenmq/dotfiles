"-----------------------------------------------------------
" Looks for the given regex or the one already in the '/'
" register if no argument given. The results are opened in a
" local jump list.
"-----------------------------------------------------------
function! functions#Lookfor( ... )
    if a:0 > 0
        let @/ = a:1
    endif

    try
        lvim //j %
        lwindow 7
    catch /E.*/
        echo v:exception
    endtry

    set hlsearch
    redraw
endfunc

"-----------------------------------------------------------
" Align the next 'cnt' relative lines to 'width'
"-----------------------------------------------------------
function! functions#Align( cnt, width )
    execute 'set textwidth=' . a:width
    let l:real_cnt = a:cnt + 1
    execute 'normal ' . l:real_cnt . 'gqq'
    set textwidth=0
endfunc

"-----------------------------------------------------------
" Saves the basename of the current file to the system
" clipboard register
"-----------------------------------------------------------
function! functions#Basename()
    execute "let @+ = fnamemodify('" . @% . "',':t')"
    echo 'Yanked: ' . @+
endfun

"-----------------------------------------------------------
" Undefines the #define located at the cursor position
"-----------------------------------------------------------
function! functions#Undefine()
    execute "s/.*\\s\\([A-Z_]\\+\\)\\s.*/#undef \\1/"
    execute "noh"
endfun

"-----------------------------------------------------------
" Cleanup trailing whitespace and tabs in the file
"-----------------------------------------------------------
function! functions#CleanWhitespace()
    silent! execute "%s/\\s\\+$//g"
    silent! execute "%s/\\t/    /g"
    execute "noh"
    execute "update"
endfun

"-----------------------------------------------------------
" Check the current buffer for unused java imports
"-----------------------------------------------------------
function! functions#CheckImports()
    execute "cexpr system('~/.dotfiles/scripts/check_imports.sh ' . expand('%'))"
endfun

" Create or resize a vertical split to a certain percentage
function! functions#VertSplitPercent(percent)
    if winnr('$') > 1
        execute "vertical resize" . float2nr(&columns * a:percent)
    else
        execute "vertical " . float2nr(&columns * a:percent) . "split"
    endif
endfun
