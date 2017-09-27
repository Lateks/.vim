runtime vimrc_example.vim
call pathogen#infect()

syntax on
filetype on
filetype plugin indent on

set background=light
set nocompatible

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set smartindent
set hlsearch
set laststatus=2

set backspace=indent,eol,start

set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:.,nbsp:.

if has("gui_running")
    set go-=T
    set go-=m
    set go-=r
    set go-=R
    set go-=l
    set go-=L
    set go+=c

    set visualbell t_vb=

    if has("win32")
        set guifont=Consolas:h12
        colorscheme solarized
    elseif has("macunix")
        set guifont=Menlo\ Regular:h12
        colorscheme flattown
    elseif has("unix")
        set guifont=Inconsolata\ 10
        colorscheme oceandeep
    endif
else
    colorscheme flattown
endif

if has("autocmd")
    au FileType ruby        setlocal ts=2 sw=2 sts=2 expandtab
    au FileType python      setlocal ts=4 sw=4 sts=4 expandtab
    au FileType javascript  setlocal ts=2 sw=2 sts=2 expandtab
    au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set syntax=cpp11
    au BufNewFile,BufRead,BufEnter *.glsl,*.vert,*.frag,*.geom set syntax=glsl
    au BufNewFile,BufRead,BufEnter *.qml set syntax=qml

    set autoread
endif

if executable('ocamlmerlin') && has('python')
  let s:ocamlmerlin = substitute(system('opam config var share'), '\n$', '', '''') . "/ocamlmerlin"
  execute "set rtp+=".s:ocamlmerlin."/vim"
  execute "set rtp+=".s:ocamlmerlin."/vimbufsync"
endif

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = './node_modules/.bin/eslint'

let g:syntastic_ocaml_checkers = ['merlin']

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libc++'

let g:ctrlp_extensions = ['line', 'dir']

let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1

let g:jsx_ext_required = 0

let mapleader = ";"

nmap <leader>n :bn<cr>
nmap <leader>p :bp<cr>
nmap <leader>d :bd<cr>
nmap <leader>r :CtrlPMRU<cr>
nmap <leader>b :CtrlPBuffer<cr>

