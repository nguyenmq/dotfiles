runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

colorscheme noctu

syntax on
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set nowrap
set hlsearch
set wildmode=longest,list,full
set wildmenu
set expandtab
set backspace=2
set incsearch
set ignorecase
set background=light
filetype plugin on

"---------------------------------------------------------
" Set up macros
"---------------------------------------------------------
let @p='24|r*'                                              " change variable to a pointer
let @c='O/*59a-61|Do-58a-59|C*/k^'                " insert C block comment
let @g='O#60a-61|Do#60a-61|DO# '                    " insert script block comment
let @f='O/69a*o69a*a/o"0p$bmaj%f;xa{O/59a*ok59a*a/OLocal Variableskk%A /* */bmb`a"1yiw`b"1Pa o`akkO**	PROCEDURE NAME:*		1**	DESCRIPTION:*		desc*kw'
                                                            " insert C function block

"-----------------------------------------------------------
" Abbreviations
"----------------------------------------------------------- abbr nll NULL
abbr tw0 set tw=0
abbr tw60 set tw=60
abbr tw70 set tw=70
abbr tw80 set tw=80
abbr tnew tabnew

"-----------------------------------------------------------
" Highlight the current line in the current buffer window
"-----------------------------------------------------------
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

"-----------------------------------------------------------
" Define new commands
"-----------------------------------------------------------
command -nargs=1 Width vertical resize <args>               " set width of window
command -nargs=1 Height resize <args>                       " set height of window
command -nargs=1 Csg :cs find g <args>                      " cscope find definition
command -nargs=1 Csf :cs find f <args>                      " cscope find file name
command -nargs=1 Css :cs find s <args>                      " cscope find all uses

"-----------------------------------------------------------
" New mappings
"-----------------------------------------------------------
inoremap jk <Esc>
                                                            " map jk to escape
noremap  <silent> <C-S> :update<CR>
                                                            " ctrl+s to save
vnoremap <silent> <C-S> <C-C>:update<CR>
                                                            " ctrl+s to save
inoremap <silent> <C-S> <C-O>:update<CR>
                                                            " ctrl+s to save
noremap <C-J>     <C-W>j
                                                            " move to window below
noremap <C-K>     <C-W>k
                                                            " move to window above
noremap <C-H>     <C-W>h
                                                            " move to left window
noremap <C-L>     <C-W>l
                                                            " move to right window
noremap <Leader>w :%s/\s\+$//g<cr>
                                                            " delete trailing whitespace
noremap <Leader>n :noh
                                                            " turn off highlighting

" configure numbers plugin
noremap <silent> <C-N>          :NumbersToggle<CR>
let g:numbers_exclude = ['tagbar', 'minibufexpl', 'help' ]

" minibufexpl settings
if has( "gui_running" )
    let g:miniBufExplorerMoreThanOne = 1
else
    let g:miniBufExplorerMoreThanOne = 2
endif

" tagbar settings
nnoremap <silent> <F1> :TagbarOpenAutoClose<CR>
nnoremap <silent> <F2> :TagbarToggle<CR>
let g:tagbar_width = 25
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

