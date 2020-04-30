call vmtest#plugin('neoterm')
let g:vmtests.neoterm.origin = { '_name': 'Origin Test' }

function! g:vmtests.neoterm.origin._before()
  let self.original_win = helper#current_window()
  let self.original_buffer = helper#current_buffer()
  new
endfunction

function! g:vmtests.neoterm.origin._after()
  bd
endfunction

function! g:vmtests.neoterm.origin.test_new()
  call assert_equal(
        \ {'win_id': helper#current_window(), 'last_buffer_id': self.original_buffer},
        \ neoterm#origin#new())
endfunction

function! g:vmtests.neoterm.origin.return_to_buffer()
  call assert_notequal(self.original_buffer, helper#current_buffer())

  call neoterm#origin#return({'last_buffer_id': self.original_buffer}, 'buffer')

  call assert_equal(self.original_buffer, helper#current_buffer())
endfunction

function! g:vmtests.neoterm.origin.return_to_window()
  call assert_notequal(self.original_win, helper#current_window())

  call neoterm#origin#return({'win_id': self.original_win})

  call assert_equal(self.original_win, helper#current_window())
endfunction

function! g:vmtests.neoterm.origin.return_to_previous_window()
  call assert_notequal(self.original_win, helper#current_window())

  call neoterm#origin#return({'win_id': 0})

  call assert_equal(self.original_win, helper#current_window())
endfunction
