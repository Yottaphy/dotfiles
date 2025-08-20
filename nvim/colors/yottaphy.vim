" yottaphy.vim

let g:colors_name = "yottaphy"

let s:colors = {
      \ "bg":         "#1E1E2E",
      \ "bg_light":   "#3E4451",
      \ "fg":         "#CDD6F4",
      \ "black":      "#45475A",
      \ "red":        "#F38BA8",
      \ "green":      "#A6E3A1",
      \ "yellow":     "#F9E2AF",
      \ "blue":       "#89B4FA",
      \ "magenta":    "#F5C2E7",
      \ "cyan":       "#94E2D5",
      \ "orange":     "#F6B6AB",
      \ "white":      "#A6ADC8",
      \ "gray":       "#969896",
      \ }

function! Highlight(group, fg, bg, attr)
  let l:cmd = 'highlight ' . a:group
  if !empty(a:fg)
    let l:cmd .= ' guifg=' . a:fg
  endif
  if !empty(a:bg)
    let l:cmd .= ' guibg=' . a:bg
  endif
  if !empty(a:attr)
    let l:cmd .= ' gui=' . a:attr
  endif
  execute l:cmd
endfunction


" Set highlight groups
call Highlight('Normal', s:colors.fg, s:colors.bg, '')
call Highlight('Comment', s:colors.gray, '', 'italic')
call Highlight('Constant', s:colors.yellow, '', '')
call Highlight('String', s:colors.green, '', '')
call Highlight('Function', s:colors.blue, '', '')
call Highlight('Identifier', s:colors.yellow, '', '')
call Highlight('Keyword', s:colors.yellow, '', '')
call Highlight('Statement', s:colors.red, '', '')
call Highlight('Type', s:colors.blue, '', '')
call Highlight('CursorLine', '', s:colors.bg_light, '')
call Highlight('CursorLineNr', s:colors.yellow, s:colors.bg_light, '')
call Highlight('LineNr', s:colors.black, s:colors.bg, '')
call Highlight('StatusLine', s:colors.bg, s:colors.gray, '')


