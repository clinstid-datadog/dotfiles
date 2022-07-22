setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=120
setlocal smarttab
setlocal expandtab
" setlocal foldmethod=indent

nmap <leader>bp Oimport pdb; pdb.set_trace()<esc>
nmap <leader>tbp Ofrom nose.tools import set_trace; set_trace()<esc>

setlocal wrap

let b:coc_root_patterns = ['.git', '.env']

setlocal synmaxcol=300
