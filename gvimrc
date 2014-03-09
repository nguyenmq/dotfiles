set guifont=Oxygen\ Mono\ 9
set guioptions-=T
set guioptions-=m
set guioptions+=P
set guicursor+=a:blinkon0
set lines=70 columns=180
colorscheme summerfruit

" gvim minibufexp settings
let g:miniBufExplorerMoreThanOne = 1
let g:miniBufExplVSplit = 23

" some final things to set up in the gui
highlight ColorColumn guibg=AliceBlue
set colorcolumn+=25
set colorcolumn+=37
set colorcolumn+=60
set colorcolumn+=70
execute "set colorcolumn+=" . join(range(81,335), ',')
