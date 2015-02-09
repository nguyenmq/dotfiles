runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

"-----------------------------------------------------------
" General settings
"-----------------------------------------------------------
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
set backspace=2                     " backspace over everything
set incsearch                       " do search as user types
set ignorecase                      " ignore case when searching
set smartcase                       " match case when contains uppercase
set background=dark                 " set background to light for noctu
filetype plugin on                  " turn on filetype
set noequalalways                   " keep windows from automatically resizing
set laststatus=2                    " always show status line
set numberwidth=5                   " set the width of the number line
set switchbuf=useopen               " use current window if open when jumping from quickfix
set noerrorbells visualbell t_vb=   " turn off bells
set foldnestmax=1                   " set max fold level
set cscopequickfix=s-,c-,d-,i-,t-,e-
                                    " open cscope results in quickfix

"-----------------------------------------------------------
" Set up macros
"-----------------------------------------------------------
let @p='24|r*'
                                    " change variable to a pointer
let @c='O*/^60i-59|dt*O/*60a-61|D^'
                                    " insert C block comment
let @g='O#60a-61|Dyypko# '
                                    " insert script block comment
let @f='O69a*$a/O/69a*jo"0p$bmaj%f;xa{kO58a-a*/O/*58a-oLocal Variableskk%A 	/* */bmb`a"1yiw`b"1Pa() o`akkO** 	PROCEDURE NAME:* 	 	1** 	DESCRIPTION:* 	 	desc*kw'
                                    " insert C function block

"-----------------------------------------------------------
" Abbreviations
"-----------------------------------------------------------
abbr nll NULL
abbr tw0 set tw=0
abbr tw60 set tw=60
abbr tw70 set tw=70
abbr tw80 set tw=80
abbr tnew tabnew

"-----------------------------------------------------------
" Auto commands
"-----------------------------------------------------------
autocmd GUIEnter * set visualbell t_vb=
autocmd GUIEnter * let c_no_comment_fold=1

"-----------------------------------------------------------
" Define new commands
"-----------------------------------------------------------
command -nargs=1 Width vertical resize <args>
                                    " set width of window
command -nargs=1 Height resize <args>
                                    " set height of window
command -nargs=1 Csg :cs find g <args>
                                    " cscope find definition
command -nargs=1 Csf :cs find f <args>
                                    " cscope find file name
command -nargs=1 Css :cs find s <args>
                                    " cscope find all uses

"-----------------------------------------------------------
" New mappings
"-----------------------------------------------------------
let mapleader = "\<space>"
                                    " map leader key to space
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
noremap <silent> <Leader>w :%s/\s\+$//g<CR> :noh<CR>
                                    " delete trailing whitespace
noremap <Leader>n :noh<CR>
                                    " turn off highlighting
noremap <Leader>c :TagbarClose<CR>:bo 7cope<CR>:TagbarOpen<CR>k
                                    " open the quick fix menu
noremap <silent> <Leader>e :cn<CR>
                                    " go to next error in quickfix
noremap <silent> <Leader>E :cN<CR>
                                    " go to previous error in quickfix
noremap <silent> <Leader>v :vs<CR>
                                    " vertical split
noremap <silent> <Leader>h :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
                                    " horizonal split
noremap <silent> <Leader>i :!cscope -Rb<CR> :cs reset<CR>
                                    " rescan cscope from cwd
noremap <silent> <Leader>d za
                                    " map toggle fold
noremap <silent> <Leader>j zj za
                                    " move to next fold and toggle it

"-----------------------------------------------------------
" Configure airline
"-----------------------------------------------------------
let g:airline_theme = 'luna'
let g:airline_inactive_collapse=0
let g:airline#extensions#tagbar#enabled=0
let g:airline#extensions#default#section_truncate_width = {
  \ 'b': 120,
  \ 'x': 60,
  \ 'y': 88,
  \ 'z': 45,
  \ }

"-----------------------------------------------------------
" Configure CtrlP
"-----------------------------------------------------------
let g:ctrlp_switch_buffer = '0'
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_custom_ignore = {
    \ 'file': '\v\.(o|so|a|o32|jam|obj)$',
\ }
noremap <silent> <Leader>b :CtrlPBuffer<cr>
                                    " search open buffers
noremap <silent> <Leader>t :CtrlPBufTag<cr>
                                    " search tags in current buffer
noremap <silent> <Leader>f :CtrlP<cr>
                                    " search file recursively
noremap <silent> <Leader>l :CtrlPLine %<cr>
                                    " search lines in current buffer

"-----------------------------------------------------------
" Configure numbers plugin
"-----------------------------------------------------------
noremap <silent> <C-N> :NumbersToggle<CR>
                                    " toggle numbers on/off
let g:numbers_exclude = [ 'help' ]
                                    " excluded filetypes

"-----------------------------------------------------------
" Configure fugitive
"-----------------------------------------------------------
noremap <silent> <Leader>gb :Gblame<CR>
                                    " run git blame
noremap <silent> <Leader>gs :Gstatus<CR>
                                    " run git status

"-----------------------------------------------------------
" Configure tagbar
"-----------------------------------------------------------
nnoremap <silent> <F1> :TagbarOpenAutoClose<CR>
                                    " jump to tagbar window
nnoremap <silent> <F2> :TagbarToggle<CR>
                                    " open/close tagbar window
let g:tagbar_show_linenumbers = -1
                                    " show line numbers in tagbar
let g:tagbar_width = 34
                                    " set width of tagbar window
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
\ }                                 " customize display of C tags
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
\ }                                 " customize display of header files

