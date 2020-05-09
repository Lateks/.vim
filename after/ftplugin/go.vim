" Tab handling
setlocal noexpandtab
setlocal nolist

" Additional key bindings for use with vim-go
nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
nmap <leader>gi :GoInfo<cr>
nmap <leader>ga :GoAlternate<cr>
nmap <leader>gl :GoMetaLinter<cr>
map <C-n> :cnext<cr>
map <C-m> :cprevious<cr>

" Deoplete completion order
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" Vim-go configuration
let g:go_auto_type_info = 1
let g:go_rename_command = 'gopls'
let g:go_metalinter_enabled = ['vet', 'errcheck', 'staticcheck', 'unused', 'gosimple', 'structcheck', 'varcheck', 'ineffassign', 'deadcode', 'gosec', 'golint']

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
