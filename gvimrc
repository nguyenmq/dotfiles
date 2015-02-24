if has( "win32" )
    set guifont=Consolas:h10:cANSI
else
    set guifont=Consolas\ 10
endif
set guioptions-=T
set guioptions-=m
set guioptions+=P
set guioptions+=c
set guicursor+=a:blinkon0

let g:airline_theme = 'monochrome'
colorscheme olive

"-----------------------------------------------------------
" Highlight the current line in the current buffer window
"-----------------------------------------------------------
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

let s:color_column_enable=0
function! ColorColumnToggle()
    if( s:color_column_enable == 1 )
        let s:color_column_enable=0
        set colorcolumn=0
    else
        let s:color_column_enable=1
        set colorcolumn=25
        set colorcolumn+=37
        set colorcolumn+=60
        set colorcolumn+=70
        set colorcolumn+=81
    endif
endfunc
command! -nargs=0 ColorColumnToggle call ColorColumnToggle()
noremap <silent> <Leader>a :ColorColumnToggle<CR>
call ColorColumnToggle()
