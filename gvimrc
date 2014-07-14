if has( "win32" )
    set guifont=Consolas:h10
else
    set guifont=Consolas\ 10
endif
set guioptions-=T
set guioptions-=m
set guioptions+=P
set guioptions+=c
set guicursor+=a:blinkon0
"set lines=50 columns=150
colorscheme lime

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
noremap <silent> <Leader>i :ColorColumnToggle<CR>
call ColorColumnToggle()

"highlight CursorLine guibg=gray95
"highlight DiffChange guibg=LavenderBlush2
"highlight DiffText guibg=plum guifg=NavyBlue
