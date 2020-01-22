call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'mattn/calendar-vim'

Plug 'jceb/vim-orgmode'
Plug 'vimwiki/vimwiki'

Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fugitive-blame-ext'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'vim-syntastic/syntastic'

" Colors
Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'

Plug 'fatih/vim-go'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" JS/TS/JSX etc.
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier'

" Lisp/Clojure/Racket etc.
Plug 'tpope/vim-fireplace'
Plug 'vim-scripts/paredit.vim'
Plug 'venantius/vim-cljfmt'
Plug 'bakpakin/janet.vim'

call plug#end()

" Background color fix for kitty terminal emu
let &t_ut=''

set swapfile directory=~/.vim/tmp
set undofile undodir=~/.vim/tmp
set backup backupdir=~/.vim/tmp

filetype on

set background=light
set nocompatible
set number

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
set listchars=tab:»\ ,extends:❯,precedes:❮,trail:.,nbsp:.

if has("gui_running")
    set go-=T
    set go-=m
    set go-=r
    set go-=R
    set go-=l
    set go-=L
    set go+=c

    set visualbell t_vb=

    if has("linux")
        colorscheme solarized
        set guifont=Source\ Code\ Pro\ 11
    else
        colorscheme autumnleaf
        if has("win32")
            set guifont=Consolas:h12
        elseif has("macunix")
            set guifont=Menlo:h13
        elseif has("unix")
            set guifont=Fira\ Mono\ 11
        endif
    endif
elseif has("gui_vimr")
    colorscheme autumnleaf
else
    set background=dark
    colorscheme zenburn
endif

if has("autocmd")
    au FileType go          setlocal noexpandtab
    au FileType go          setlocal nolist
    au FileType ruby        setlocal ts=2 sw=2 sts=2 expandtab
    au FileType python      setlocal ts=4 sw=4 sts=4 expandtab
    au FileType javascript  setlocal ts=2 sw=2 sts=2 expandtab
    au FileType typescript  setlocal ts=2 sw=2 sts=2 expandtab
    au FileType javascript  nmap <leader>f :Prettier<cr>
    au FileType typescript  nmap <leader>f :Prettier<cr>
    au Filetype clojure     nmap <buffer> <leader>r :Require<cr>
    au BufNewFile,BufRead,BufEnter *.tsx setlocal ts=2 sw=2 sts=2 expandtab
    au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set syntax=cpp11
    au BufNewFile,BufRead,BufEnter *.glsl,*.vert,*.frag,*.geom set syntax=glsl
    au BufNewFile,BufRead,BufEnter *.qml set syntax=qml
    au FocusGained,BufEnter * :checktime

    set autoread
endif

if has("nvim")
    :tnoremap <Esc> <C-\><C-n>
endif

if executable('ocamlmerlin') && has('python')
  let s:ocamlmerlin = substitute(system('opam config var share'), '\n$', '', '''') . "/ocamlmerlin"
  execute "set rtp+=".s:ocamlmerlin."/vim"
  execute "set rtp+=".s:ocamlmerlin."/vimbufsync"
endif

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1

let g:syntastic_ocaml_checkers = ['merlin']

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libc++'

let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']

let g:ctrlp_extensions = ['line', 'dir']
let g:ctrlp_custom_ignore = { 'dir':  '\v[\/](node_modules|\.git)$' }

let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1

let g:jsx_ext_required = 0

let mapleader = ";"
let maplocalleader = "\\"

let g:syntastic_mode_map = { 'passive_filetypes': ['typescript', 'javascript'] }

nmap <leader>n :bn<cr>
nmap <leader>p :bp<cr>
nmap <leader>w :w<cr>
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
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gt <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>T :silent! lvimgrep /TODO\\|FIXME/ %<cr>:lopen<cr>

nnoremap <leader>t :call <sid>show_documentation()<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
