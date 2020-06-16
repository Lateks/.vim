setlocal ts=2 sw=2 sts=2 expandtab
nmap <leader>f :Neoformat<cr>

" Ocamlformat configuration
let g:neoformat_ocaml_ocamlformat = {
            \ 'exe': 'ocamlformat',
            \ 'no_append': 1,
            \ 'stdin': 1,
            \ 'args': ['--disable-outside-detected-project', '--name', '"%:p"', '-']
            \ }

let g:neoformat_enabled_ocaml = ['ocamlformat']
