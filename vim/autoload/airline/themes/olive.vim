let g:airline#themes#olive#palette = {}

function! airline#themes#olive#refresh()
    let s:NORM1 = [ '{{black_almost}}', '{{gray_dark}}', '00', '07' ]
    let s:NORM2 = [ '{{ui_text_accent}}', '{{ui_primary}}', '00', '02' ]
    let s:NORM3 = [ '{{white}}', '{{ui_accent}}', '231', '22' ]

    let g:airline#themes#olive#palette.normal = airline#themes#generate_color_map(s:NORM1, s:NORM2, s:NORM3)
    let g:airline#themes#olive#palette.insert = g:airline#themes#olive#palette.normal
    let g:airline#themes#olive#palette.replace = g:airline#themes#olive#palette.normal
    let g:airline#themes#olive#palette.visual = g:airline#themes#olive#palette.normal

    let s:IN1 = [ '{{ui_text_accent_alt}}', '{{ui_primary}}', '00', '02' ]
    let s:IN2 = [ '{{ui_text_accent_alt}}', '{{ui_primary}}', '00', '02' ]
    let s:IN3 = [ '{{ui_text_accent_alt}}', '{{ui_primary}}', '00', '02' ]
    let g:airline#themes#olive#palette.inactive = airline#themes#generate_color_map(s:IN1, s:IN2, s:IN3)

    let s:WI = [ '{{white}}', '{{lavender}}', '231', '06' ]
    let g:airline#themes#olive#palette.normal.airline_warning = [ s:WI[0], s:WI[1], s:WI[2], s:WI[3] ]
    let g:airline#themes#olive#palette.insert.airline_warning = g:airline#themes#olive#palette.normal.airline_warning
    let g:airline#themes#olive#palette.visual.airline_warning = g:airline#themes#olive#palette.normal.airline_warning
    let g:airline#themes#olive#palette.replace.airline_warning = g:airline#themes#olive#palette.normal.airline_warning

    let s:EI = [ '{{white}}', '{{yellow}}', '231', '06' ]
    let g:airline#themes#olive#palette.normal.airline_error = [ s:EI[0], s:EI[1], s:EI[2], s:EI[3] ]
    let g:airline#themes#olive#palette.insert.airline_error = g:airline#themes#olive#palette.normal.airline_error
    let g:airline#themes#olive#palette.visual.airline_error = g:airline#themes#olive#palette.normal.airline_error
    let g:airline#themes#olive#palette.replace.airline_error = g:airline#themes#olive#palette.normal.airline_error

    let g:airline#themes#olive#palette.tabline = {
            \'airline_tab': ['{{ui_text_accent}}', '{{ui_primary}}', 231, 02],
            \'airline_tabfill': ['{{green}}', '{{ui_primary}}', 02, 02],
            \'airline_tabsel': ['{{ui_text_accent}}', '{{ui_accent}}', 231, 22]}

endfunction

call airline#themes#olive#refresh()
