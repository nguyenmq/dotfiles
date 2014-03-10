runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

colorscheme noctu

syntax on
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set ai
set nowrap
set hlsearch
set wildmode=longest,list,full
set wildmenu
set expandtab
set backspace=2
set incsearch
set ignorecase

" set up macros
let @p='24|r*'

"abbreviations
abbr fbol FALSE
abbr tbol TRUE
abbr nll NULL
abbr mnu set guioptions+=m
abbr tw0 set tw=0
abbr tw60 set tw=60
abbr tw70 set tw=70
abbr tw80 set tw=80
abbr tnew tabnew

if has( "autocmd" )
    filetype on
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType gitcommit setlocal tw=72
endif

" highlight the current line in the current buffer window
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" define commands for setting height and width
command -nargs=1 Width vertical resize <args>
command -nargs=1 Height resize <args>

inoremap jk <Esc>

" use ctrl+s for saving
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" map ctrl+[hjkl] to switch to other buffers
noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l

" configure numbers plugin
noremap <silent> <C-N>          :NumbersToggle<CR>
" let g:enable_numbers = 0

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

