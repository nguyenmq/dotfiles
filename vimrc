runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

if has( "gui_running" )    
	"set guifont=Consolas\ 10
    set guifont=Oxygen\ Mono\ 9
	set guioptions-=T
    set guioptions-=m
    set guioptions+=P
    colors summerfruit256
    set guicursor+=a:blinkon0
    set lines=80 columns=110
else
    colors ron
endif

syntax on
set number
set ts=4
set sw=4
set ai
set nowrap
set hlsearch
set wildmode=longest,list,full
set wildmenu
set expandtab
set backspace=2
set incsearch

"abbreviations
abbr fbol FALSE
abbr tbol TRUE
abbr nll NULL
abbr mnu set guioptions+=m
abbr tw0 set tw=0
abbr tw60 set tw=60
abbr tw70 set tw=70
abbr tw72 set tw=72
abbr tw80 set tw=80
abbr tnew tabnew

" use ctrl+s for saving
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" minibufexpl settings
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1
if has( "gui_running" )    
    let g:miniBufExplorerMoreThanOne = 1
else
    let g:miniBufExplorerMoreThanOne = 2
endif

" tagbar settings
nnoremap <silent> <F1> :TagbarOpenAutoClose<CR>
nnoremap <silent> <F2> :TagbarToggle<CR>
let g:tagbar_width=23
let g:tagbar_type_c = {
    \ 'kinds' : [
        \ 'd:macros:1:0',
        \ 'g:enums',
        \ 'e:enumerators:0:0',
        \ 't:typedefs:0:0',
        \ 's:structs:1:0',
        \ 'u:unions',
        \ 'm:members:0:0',
        \ 'v:variables:0:0',
        \ 'p:prototypes:0:0',
        \ 'f:functions',
    \ ],
\ }
let g:tagbar_type_prslog = {
    \ 'ctagstype' : 'prslog',
    \ 'kinds' : [
        \ 'd:Date',
        \ 's:Reminders'
    \ ],
    \ 'sort'      : 0
\ }
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:1:0',
        \ 'g:enums:1:1',
        \ 'e:enumerators:1:1',
        \ 't:typedefs:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'm:members:0:0',
        \ 'v:variables:0:0',
        \ 'p:prototypes:0:0',
        \ 'f:functions',
    \ ],
\ }

" some final things to set up in the gui
if has( "gui_running" )    
    highlight ColorColumn guibg=AliceBlue
    set colorcolumn+=25
    set colorcolumn+=37
    set colorcolumn+=60
    set colorcolumn+=70
    execute "set colorcolumn+=" . join(range(81,335), ',')
endif

