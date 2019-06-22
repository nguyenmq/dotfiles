scriptencoding utf-8

function! airline#extensions#tabline#formatters#colon#format(tab_nr_type, nr)
    return (g:airline_symbols.space) . a:nr . ":"
endfunction
