" args, default
function! neoterm#args#size(args, default)
  let l:size = matchstr(a:args, 'resize=\zs\d\+')
  let l:size = empty(l:size) ? a:default : l:size

  return str2nr(l:size)
endfunction
