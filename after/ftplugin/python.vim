setlocal ts=4 sw=4 sts=4 expandtab

if has('nvim')
  nnoremap <buffer> <F5> :w<cr>:vs<cr>:te python3 "%"<cr>
else
  nnoremap <buffer> <F5> :w<cr>:vert ter python3 "%"<cr>
endif

let g:python_highlight_all = 1

let b:ale_fixers = ['black']
let b:ale_linters = ['mypy', 'pylint']
