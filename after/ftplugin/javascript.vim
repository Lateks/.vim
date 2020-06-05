setlocal ts=2 sw=2 sts=2 expandtab
nmap <leader>f :Prettier<cr>

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = './node_modules/.bin/eslint'
