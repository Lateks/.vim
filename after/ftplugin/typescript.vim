setlocal ts=2 sw=2 sts=2 expandtab
nmap <leader>f :Prettier<cr>

let g:syntastic_typescript_checkers = ['tslint', 'eslint']
let g:syntastic_typescript_eslint_exec = './node_modules/.bin/eslint'
