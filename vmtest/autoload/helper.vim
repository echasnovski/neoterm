function! helper#current_buffer()
  return bufnr('%')
endfunction

function! helper#current_window()
  return win_getid()
endfunction
