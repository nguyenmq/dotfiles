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

function! functions#SearchWithHighlight(search_term)
    call clearmatches()
    execute "let @/='" . a:search_term . "'"
    call histadd("search", a:search_term)
endfun
