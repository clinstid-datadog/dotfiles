" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" From vim-go
" nmap <leader>gi :GoImports<cr>
" nmap <leader>gf :GoFmt<cr>
" nnoremap <leader>gt :GoTest<cr>
" nnoremap <leader>gr :GoTest<cr>
" autocmd BufWritePre *.go :silent !goimports -w %
nnoremap <leader>gi :silent !goimports -w %<cr>
nnoremap <leader>gf :silent !go fmt %<cr>
nnoremap <leader>gt :!go test %<cr>

setlocal shiftwidth=4
setlocal tabstop=4
setlocal noexpandtab
setlocal smarttab
setlocal autoindent
setlocal smartindent

"let b:ale_linters = ['gofmt', 'golint', 'govet', 'golangserver']

" vim-go configuration
let g:go_fmt_autosave = 1
let g:go_metalinter_autosave = 1
