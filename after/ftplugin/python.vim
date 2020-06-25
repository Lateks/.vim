setlocal ts=4 sw=4 sts=4 expandtab

let g:python_highlight_all = 1

let b:ale_fixers = ['black']
let b:ale_linters = ['mypy', 'pylint']
