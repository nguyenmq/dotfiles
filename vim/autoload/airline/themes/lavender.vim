let g:airline#themes#lavender#palette = {}

function! airline#themes#lavender#refresh()
    let s:NORM1 = [ '#000000', '#2bb24c', '00', '07' ]
    let s:NORM2 = [ '#ffffff', '#2bb24c', '231', '06' ]
    let s:NORM3 = [ '#000000', '#eeeeee', '00', '03' ]

    let g:airline#themes#lavender#palette.normal = airline#themes#generate_color_map(s:NORM1, s:NORM2, s:NORM3)
    let g:airline#themes#lavender#palette.insert = g:airline#themes#lavender#palette.normal
    let g:airline#themes#lavender#palette.replace = g:airline#themes#lavender#palette.normal
    let g:airline#themes#lavender#palette.visual = g:airline#themes#lavender#palette.normal

    let s:IN1 = [ '#875faf', '#eeeeee', '00', '06' ]
    let s:IN2 = [ '#875faf', '#eeeeee', '00', '06' ]
    let s:IN3 = [ '#875faf', '#eeeeee', '00', '06' ]
    let g:airline#themes#lavender#palette.inactive = airline#themes#generate_color_map(s:IN1, s:IN2, s:IN3)

    let s:WI = [ '#ffffff', '#875faf', '231', '06' ]
    let g:airline#themes#lavender#palette.normal.airline_warning = [ s:WI[0], s:WI[1], s:WI[2], s:WI[3] ]
    let g:airline#themes#lavender#palette.insert.airline_warning = g:airline#themes#lavender#palette.normal.airline_warning
    let g:airline#themes#lavender#palette.visual.airline_warning = g:airline#themes#lavender#palette.normal.airline_warning
    let g:airline#themes#lavender#palette.replace.airline_warning = g:airline#themes#lavender#palette.normal.airline_warning

    let g:airline#themes#lavender#palette.tabline = {
            \'airline_tab': ['#ffffff', '#5f0087', 231, 06],
            \'airline_tabfill': ['#767676', '#ffffff', 06, 06],
            \'airline_tabsel': ['#ffffff', '#875faf', 00, 03]}

endfunction

call airline#themes#lavender#refresh()
