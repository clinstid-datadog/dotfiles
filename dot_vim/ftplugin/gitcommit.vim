setlocal spell

" automatically go to the top left position when entering the git commit message
au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
