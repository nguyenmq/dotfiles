let g:airline#themes#olive#palette = {}

function! airline#themes#olive#refresh()
    let s:NORM1 = [ '#12181a', '#2bb24c', '00', '07' ]
    let s:NORM2 = [ '#ffffff', '#2bb24c', '00', '02' ]
    let s:NORM3 = [ '#12181a', '#eeeeee', '231', '22' ]

    let g:airline#themes#olive#palette.normal = airline#themes#generate_color_map(s:NORM1, s:NORM2, s:NORM3)
    let g:airline#themes#olive#palette.insert = g:airline#themes#olive#palette.normal
    let g:airline#themes#olive#palette.replace = g:airline#themes#olive#palette.normal
    let g:airline#themes#olive#palette.visual = g:airline#themes#olive#palette.normal

    let s:IN1 = [ '#875faf', '#eeeeee', '00', '02' ]
    let s:IN2 = [ '#875faf', '#eeeeee', '00', '02' ]
    let s:IN3 = [ '#875faf', '#eeeeee', '00', '02' ]
    let g:airline#themes#olive#palette.inactive = airline#themes#generate_color_map(s:IN1, s:IN2, s:IN3)

    let s:WI = [ '#ffffff', '#875faf', '231', '06' ]
    let g:airline#themes#olive#palette.normal.airline_warning = [ s:WI[0], s:WI[1], s:WI[2], s:WI[3] ]
    let g:airline#themes#olive#palette.insert.airline_warning = g:airline#themes#olive#palette.normal.airline_warning
    let g:airline#themes#olive#palette.visual.airline_warning = g:airline#themes#olive#palette.normal.airline_warning
    let g:airline#themes#olive#palette.replace.airline_warning = g:airline#themes#olive#palette.normal.airline_warning

    let g:airline#themes#olive#palette.tabline = {
            \'airline_tab': ['#ffffff', '#5f0087', 231, 02],
            \'airline_tabfill': ['#767676', '#ffffff', 02, 02],
            \'airline_tabsel': ['#ffffff', '#875faf', 231, 22]}

endfunction

call airline#themes#olive#refresh()
