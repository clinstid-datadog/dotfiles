" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal smarttab
setlocal autoindent
setlocal smartindent
setlocal textwidth=100
setlocal foldmethod=indent
setlocal cursorcolumn
