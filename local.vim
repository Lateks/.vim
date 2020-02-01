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

" Go
Plug 'fatih/vim-go'

" JS/TS/JSX etc.
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier'

" Lisp/Clojure/Racket etc.
Plug 'tpope/vim-fireplace'
Plug 'vim-scripts/paredit.vim'
Plug 'venantius/vim-cljfmt'
Plug 'bakpakin/janet.vim'

" Deoplete
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

Plug 'deoplete-plugins/deoplete-go'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

" Background color fix for kitty terminal emu
let &t_ut=''

set swapfile directory=~/.vim/tmp
set undofile undodir=~/.vim/tmp
set backup backupdir=~/.vim/tmp

filetype on

set hidden

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

set background=dark
colorscheme zenburn

if has("gui_running")
    set go-=T
    set go-=m
    set go-=r
    set go-=R
    set go-=l
    set go-=L
    set go+=c

    set visualbell t_vb=

    set guifont=Source\ Code\ Pro\ 11
endif

if has("autocmd")
    " Go
    au FileType go          setlocal noexpandtab
    au FileType go          setlocal nolist
    au FileType go          nmap <leader>b :GoBuild<cr>

    " Scripting
    au FileType sh          setlocal ts=2 sw=2 sts=2 expandtab
    au FileType ruby        setlocal ts=2 sw=2 sts=2 expandtab
    au FileType python      setlocal ts=4 sw=4 sts=4 expandtab

    " JavaScript and TypeScript
    au FileType javascript  setlocal ts=2 sw=2 sts=2 expandtab
    au FileType typescript  setlocal ts=2 sw=2 sts=2 expandtab
    au FileType javascript  nmap <leader>f :Prettier<cr>
    au FileType typescript  nmap <leader>f :Prettier<cr>
    au BufNewFile,BufRead,BufEnter *.tsx setlocal ts=2 sw=2 sts=2 expandtab
    autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.yaml,*.html PrettierAsync

    " Clojure
    au Filetype clojure     nmap <buffer> <leader>r :Require<cr>

    " C/C++ and graphics
    au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set syntax=cpp11
    au BufNewFile,BufRead,BufEnter *.glsl,*.vert,*.frag,*.geom set syntax=glsl
    au BufNewFile,BufRead,BufEnter *.qml set syntax=qml

    " General
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

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'javascriptreact': ['typescript-language-server', '--stdio'],
    \ 'typescriptreact': ['typescript-language-server', '--stdio'],
\ }

let g:LanguageClient_rootMarkers = {
    \ 'javascript': ['jsconfig.json'],
    \ 'typescript': ['tsconfig.json'],
    \ 'javascriptreact': ['jsconfig.json'],
    \ 'typescriptreact': ['tsconfig.json'],
\ }

call deoplete#custom#option('sources', {
\ '_': ['LanguageClient'],
\})

let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1

let g:syntastic_ocaml_checkers = ['merlin']

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libc++'

let g:ctrlp_extensions = ['line', 'dir']
let g:ctrlp_custom_ignore = { 'dir':  '\v[\/](node_modules|\.git)$' }

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1

let g:airline_theme='zenburn'
let g:airline_inactive_collapse=1
let g:airline_symbols_ascii = 1
let g:airline_extensions = ['branch', 'tabline', 'syntastic', 'languageclient', 'ctrlp']
" Show file name only instead of full path.
let g:airline_section_c = '%<%t%m%#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
" Hide file encoding/format section.
let g:airline_section_y = ''
" Show only column number in the rightmost regularly visible section.
let g:airline_section_z = '%3v'

let g:airline_mode_map = {
  \ '__'     : '-',
  \ 'c'      : 'C',
  \ 'i'      : 'I',
  \ 'ic'     : 'I',
  \ 'ix'     : 'I',
  \ 'n'      : 'N',
  \ 'multi'  : 'M',
  \ 'ni'     : 'N',
  \ 'no'     : 'N',
  \ 'R'      : 'R',
  \ 'Rv'     : 'R',
  \ 's'      : 'S',
  \ 'S'      : 'S',
  \ ''     : 'S',
  \ 't'      : 'T',
  \ 'v'      : 'V',
  \ 'V'      : 'V',
  \ ''     : 'V',
  \ }

let g:jsx_ext_required = 0

let mapleader = ";"
let maplocalleader = "\\"

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
nmap <leader>o :lopen<cr>
nmap <leader>m :marks<cr>
nmap <leader>a :Ack<Space>
nmap <leader>T :silent! lvimgrep /TODO\\|FIXME/ %<cr>:lopen<cr>

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType typescript,javascript,typescriptreact,javascriptreact call SetLSPShortcuts()
augroup END
