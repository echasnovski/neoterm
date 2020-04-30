call vmtest#plugin('neoterm')
let g:vmtests.neoterm._name = 'Neoterm Test'

function! g:vmtests.neoterm._after()
  silent! TcloseAll!
endfunction

function! g:vmtests.neoterm.test_new_instance_keys()
  silent let instance = neoterm#new()
  call assert_equal([
        \ 'normal', 'id', 'mod', 'name', 'termsend', 'from_event', 'buffer_id',
        \ 'handlers', 'exec', 'on_exit', 'on_stdout', 'on_stderr', 'shell',
        \ 'vim_exec', 'termid', 'origin'],
        \ keys(instance)
        \ )
endfunction

function! g:vmtests.neoterm.test_new()
  let original_buffer = helper#current_buffer()
  let instance = neoterm#new()
  let current_window = helper#current_window()
  let buffer = helper#current_buffer()

  call assert_equal(g:neoterm.last_id, instance.id, 'id')
  call assert_equal('', instance.mod, 'mod')
  call assert_equal(printf('neoterm-%s', g:neoterm.last_id), instance.name, 'name')
  call assert_equal(0, instance.from_event, 'from_event')
  call assert_equal(buffer, instance.buffer_id, 'buffer_id')
  call assert_equal({}, instance.handlers, 'handlers')
  call assert_equal(g:neoterm_shell, instance.shell, 'shell')
  call assert_equal(g:neoterm.get_current_termid(), instance.termid, 'termid')
  call assert_equal({
        \ 'last_buffer_id': original_buffer,
        \ 'win_id': current_window
        \ }, instance.origin, 'origin')
  call assert_equal(2, type(instance.normal), 'normal')
  call assert_equal(2, type(instance.termsend), 'termsend')
  call assert_equal(2, type(instance.exec), 'exec')
  call assert_equal(2, type(instance.on_exit), 'on_exit')
  call assert_equal(2, type(instance.on_stdout), 'on_stdout')
  call assert_equal(2, type(instance.on_stderr), 'on_stderr')
  call assert_equal(2, type(instance.vim_exec), 'vim_exec')
endfunction
