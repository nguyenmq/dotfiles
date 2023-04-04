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

function! functions#GetLocation()
    let l:filepath = expand("%")
    let l:line_number = line(".")
    let @+ = l:filepath . ":" . l:line_number
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
    let l:win_cnt = winnr('$')
    let l:qf_open = len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"'))

    if l:qf_open
        let l:win_cnt = l:win_cnt - 1
    endif

    if l:win_cnt > 1
        execute "vertical resize" . float2nr(&columns * a:percent)
    else
        execute "vertical " . float2nr(&columns * a:percent) . "split"
    endif
endfun

" Toggle strike through of a bullet item in markdown planner
function! functions#TaskStrikethroughToggle()
    let l:is_task = match(getline("."), '^\s*-\s\[.\]')

    if l:is_task == 0
        call functions#TaskDoneToggle()
    else
        call functions#TaskStrikeToggle()
    endif
endfun

" Toggle a markdown task as done/not done
function! functions#TaskDoneToggle()
    let l:is_done = split(getline("."), '\[\|\]')[1]

    if l:is_done == "x"
        execute 's/\~//g'
        execute 's/\[\zsx\ze\]/ /'
    else
        let @/ = '^\s*-\s\[.\] \zs.'
        execute "normal! 0ni~~"
        execute "normal! A~~"
        execute 's/\[\zs\s\ze\]/x/'
    endif
endfun

" Toggle a markdown line to be striked through
function! functions#TaskStrikeToggle()
    let l:is_strikethrough = match(getline("."), '\~\~')

    if l:is_strikethrough >= 0
        execute 's/\~//g'
    else
        let @/ = '^\s*-*\s*\zs.'
        execute "normal! 0ni~~"
        execute "normal! A~~"
    endif
endfun

function! functions#RotateCapture()
    execute 'global /\~\~$/ delete'
    silent execute '%s/\(^\n\)*##\s\d\+\n\(^\n\)*//g'

    let l:current_day = trim(system('date +%A'))

    if l:current_day ==# "Monday"
        let l:current_epoch_time = strftime("%s")
    else
        let l:current_epoch_time = system('date +%s -d "last Monday"')
    endif

    let l:seconds_in_day = 86400
    normal G
    normal o

    for i in [0, 1, 2, 3, 4]
        execute 'normal o## ' . strftime("%d", l:current_epoch_time + (l:seconds_in_day * i))
        normal 2o

        if i == 0
            execute 'normal I- [ ] Weekly backup'
            normal o
        endif
    endfor
endfun

" Move open tasks to the next day
function! functions#PuntTasks()
    normal "myip
    execute 'normal vip'
    execute '''<,''>g /[^~]\{2}$/ d'
    let @/ = '^##\s\w\{2}\n\zs'
    execute 'normal n"mpvip'
    execute '''<,''>g /\~\~/ d'
endfun

" Create a work-in-progress parent task in the current day so that the task
" can be punted to the next day
function! functions#WipTask()
    normal yypA (wip)
    call functions#TaskStrikethroughToggle()
endfun

function! functions#SearchWithHighlight(search_term)
    call clearmatches()
    execute "let @/='" . a:search_term . "'"
    call histadd("search", a:search_term)
endfun

function! functions#SearchTurnOffHighlight()
    call clearmatches()
endfun

function! functions#Search(search_term)
    execute "Ag! " . a:search_term
    call functions#SearchWithHighlight(a:search_term)
endfun

let s:wrapenabled = 0
function! functions#ToggleWrap()
  if s:wrapenabled
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    setlocal nowrap
    setlocal nolinebreak
    setlocal nospell
    setlocal textwidth=0
    let s:wrapenabled = 0
  else
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
    setlocal wrap
    setlocal linebreak
    setlocal spell
    setlocal textwidth=0
    let s:wrapenabled = 1
  endif
endfunction
