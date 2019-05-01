call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fugitive-blame-ext'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'vim-syntastic/syntastic'

Plug 'tpope/vim-surround'

Plug 'altercation/vim-colors-solarized'

" JS/TS/JSX etc.
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'prettier/vim-prettier'

" Lisp/Clojure/Racket etc.
Plug 'tpope/vim-fireplace'
Plug 'vim-scripts/paredit.vim'
Plug 'venantius/vim-cljfmt'

call plug#end()

filetype on

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
set smartcase

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
        set guifont=Menlo:h13
        colorscheme autumnleaf
    elseif has("unix")
        set guifont=Inconsolata\ 10
        colorscheme oceandeep
    endif
elseif has("gui_vimr")
    colorscheme autumnleaf
else
    colorscheme flattown
endif

if has("autocmd")
    au FileType ruby        setlocal ts=2 sw=2 sts=2 expandtab
    au FileType python      setlocal ts=4 sw=4 sts=4 expandtab
    au FileType javascript  setlocal ts=2 sw=2 sts=2 expandtab
    au FileType typescript  setlocal ts=2 sw=2 sts=2 expandtab
    au FileType typescript  nmap <buffer> <leader>t : <C-u>echo tsuquyomi#hint()<cr>
    au Filetype clojure     nmap <buffer> <leader>r :Require<cr>
    au BufNewFile,BufRead,BufEnter *.tsx setlocal ts=2 sw=2 sts=2 expandtab
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

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = './node_modules/.bin/eslint'

let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint']

let g:syntastic_ocaml_checkers = ['merlin']

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libc++'

let g:ctrlp_extensions = ['line', 'dir']
let g:ctrlp_custom_ignore = { 'dir':  '\v[\/](node_modules|\.git)$' }

let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1

let g:jsx_ext_required = 0

let mapleader = ";"

nmap <leader>n :bn<cr>
nmap <leader>p :bp<cr>
nmap <leader>w :w<cr>
nmap <leader>f :Prettier<cr>
nmap <leader>d :bd<cr>
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>s :CtrlPMixed<cr>
nmap <leader>to :NERDTree<cr>
nmap <leader>tc :NERDTreeClose<cr>
nmap <leader>l f<space>r<cr>
nmap <leader>q :qa<cr>
nmap <leader>co :copen<cr>
nmap <leader>cc :ccl<cr>
nmap <leader>lo :lopen<cr>
nmap <leader>lc :lcl<cr>
nmap <leader>m :marks<cr>
nmap <leader>a :Ack<Space>
