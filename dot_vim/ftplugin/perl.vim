" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" All of the perl I mess with uses tabs for indentation :sadpanda:
setlocal tabstop=8
setlocal shiftwidth=8
setlocal noexpandtab
setlocal smarttab
setlocal autoindent
setlocal smartindent
