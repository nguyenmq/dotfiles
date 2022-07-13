let g:airline#themes#olive#palette = {}

function! airline#themes#olive#refresh()
    let s:NORM1 = [ '{{black_almost}}', '{{gray_dark}}', '00', '07' ]
    let s:NORM2 = [ '{{black_almost}}', '{{green}}', '00', '02' ]
    let s:NORM3 = [ '{{white}}', '{{green_dark}}', '231', '22' ]

    let g:airline#themes#olive#palette.normal = airline#themes#generate_color_map(s:NORM1, s:NORM2, s:NORM3)
    let g:airline#themes#olive#palette.insert = g:airline#themes#olive#palette.normal
    let g:airline#themes#olive#palette.replace = g:airline#themes#olive#palette.normal
    let g:airline#themes#olive#palette.visual = g:airline#themes#olive#palette.normal

    let s:IN1 = [ '{{black_almost}}', '{{green}}', '00', '02' ]
    let s:IN2 = [ '{{black_almost}}', '{{green}}', '00', '02' ]
    let s:IN3 = [ '{{black_almost}}', '{{green}}', '00', '02' ]
    let g:airline#themes#olive#palette.inactive = airline#themes#generate_color_map(s:IN1, s:IN2, s:IN3)

    let s:WI = [ '{{white}}', '{{lavender}}', '231', '06' ]
    let g:airline#themes#olive#palette.normal.airline_warning = [ s:WI[0], s:WI[1], s:WI[2], s:WI[3] ]
    let g:airline#themes#olive#palette.insert.airline_warning = g:airline#themes#olive#palette.normal.airline_warning
    let g:airline#themes#olive#palette.visual.airline_warning = g:airline#themes#olive#palette.normal.airline_warning
    let g:airline#themes#olive#palette.replace.airline_warning = g:airline#themes#olive#palette.normal.airline_warning

    let g:airline#themes#olive#palette.tabline = {
            \'airline_tab': ['{{white}}', '{{green}}', 231, 02],
            \'airline_tabfill': ['{{green}}', '{{green}}', 02, 02],
            \'airline_tabsel': ['{{white}}', '{{green_dark}}', 231, 22]}

endfunction

call airline#themes#olive#refresh()
