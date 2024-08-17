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

function! functions#RotateCapture()
    let l:current_day = trim(system('date +%A'))

    if l:current_day ==# "Monday"
        let l:current_epoch_time = strftime("%s")
    else
        let l:current_epoch_time = system('date +%s -d "last Monday"')
    endif

    let l:next_friday = system('date +%s -d "next Friday"')

    execute '%s/^## Daily \zs\d\{1,2}-\d\{1,2}/' . strftime("%d", l:current_epoch_time) . '-' . strftime("%d", l:next_friday) . '/g'
    normal o
    execute 'normal o- [ ] Weekly backup'
    normal jdd
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
    setlocal nobreakindent
    setlocal columns=9999
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
    setlocal breakindent
    setlocal columns=120
    let s:wrapenabled = 1
  endif
endfunction

function! functions#PasteCRLink()
    normal O
    normal "+gp
    execute 's/CR-\d\{8,} \(.*\) - Code Browser/\1/g'
    execute "let @/='\\d\\+'"
    normal $F[r(f]r)$Nyt#F]i (rev 0)
endfun
