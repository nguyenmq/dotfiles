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
set lines=50 columns=150
colorscheme summerfruit256

" some final things to set up in the gui
highlight ColorColumn guibg=MintCream
set colorcolumn+=25
set colorcolumn+=37
set colorcolumn+=60
set colorcolumn+=70
set colorcolumn+=81
" execute "set colorcolumn+=" . join(range(81,335), ',')

"-----------------------------------------------------------
" Highlight the current line in the current buffer window
"-----------------------------------------------------------
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

highlight Search guibg=limegreen
highlight CursorLine guibg=gray95
highlight DiffChange guibg=LavenderBlush2
highlight DiffText guibg=plum guifg=NavyBlue
