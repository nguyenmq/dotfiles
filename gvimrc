if has( "win32" )
    set guifont=Consolas:h10
else
    set guifont=Monospace\ 9
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

highlight Search guibg=limegreen
highlight CursorLine guibg=SkyBlue1
