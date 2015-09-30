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
