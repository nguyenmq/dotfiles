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
