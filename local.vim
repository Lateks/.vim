call plug#begin('~/.vim/plugged')

" Search and navigation
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'mattesgroeger/vim-bookmarks'

" Utility
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-endwise'
Plug 'mattn/calendar-vim'
Plug 'sbdchd/neoformat'

" Org and documentation
Plug 'jceb/vim-orgmode'
Plug 'vimwiki/vimwiki'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fugitive-blame-ext'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colors
Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'
Plug 'tjammer/blayu.vim'
Plug 'vim-scripts/autumnleaf_modified.vim'
Plug 'vim-scripts/summerfruit256.vim'
Plug 'chrisbra/Colorizer'

" Language server integration and error checking
Plug 'vim-syntastic/syntastic'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Ctags
Plug 'majutsushi/tagbar'

" Go
Plug 'fatih/vim-go'

" Rust
Plug 'rust-lang/rust.vim'

" Zig
Plug 'ziglang/zig.vim'

" JS/TS/JSX etc.
Plug 'leafgarland/typescript-vim'

" Lisp/Clojure/Racket etc.
Plug 'tpope/vim-fireplace'
Plug 'vim-scripts/paredit.vim'
Plug 'venantius/vim-cljfmt'
Plug 'bakpakin/janet.vim'

" Completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'deoplete-plugins/deoplete-go'

call plug#end()

" Background color fix for kitty terminal emu
let &t_ut=''

set swapfile directory=~/.vim/tmp
set undofile undodir=~/.vim/tmp
set backup backupdir=~/.vim/tmp

filetype on
filetype plugin on

set nocompatible
set number

set hidden

set autowrite
set updatetime=500

set expandtab
set autoindent
set smartindent
set hlsearch
set laststatus=2
set smartcase

set backspace=indent,eol,start

set list
set listchars=tab:»\ ,extends:❯,precedes:❮,trail:.,nbsp:.

set ts=2 sw=2 sts=2 expandtab

" Colors
set termguicolors
if hostname() == "saraswati"
    set background=light
    colorscheme summerfruit256
else
    set background=dark
    colorscheme zenburn
endif

" GUI vim
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

" Neovim
if has("nvim")
    :tnoremap <Esc> <C-\><C-n>
endif

if has("autocmd")
    " JavaScript and TypeScript
    au CursorHold *.js,*.ts,*.tsx,*.jsx call LanguageClient#textDocument_hover()

    " General
    au FocusGained,BufEnter * :checktime

    set autoread
endif

" Ack configuration
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" LanguageClient configuration
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'typescriptreact': ['typescript-language-server', '--stdio'],
\ }

function SetLSPShortcuts()
  nnoremap gd :call LanguageClient#textDocument_definition()<CR>
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
  autocmd FileType typescript,javascript,typescriptreact,javascriptreact,rust,c,cpp call SetLSPShortcuts()
augroup END

" Deoplete completion configuration
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option('sources', {
\ '_': ['LanguageClient'],
\})

" Merlin configuration
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" Syntastic configuration
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++17 -stdlib=libc++'

" Fuzzy search configuration
let g:ctrlp_extensions = ['line', 'dir']
let g:ctrlp_custom_ignore = { 'dir':  '\v[\/](node_modules|\.git|target|dist)$' }
let g:ctrlp_mruf_relative = 1
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*

" Vim-bookmarks configuration
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1

" Airline configuration
let g:airline_theme='zenburn'
let g:airline_inactive_collapse=1
let g:airline_symbols_ascii = 1
let g:airline_extensions = ['branch', 'syntastic', 'languageclient', 'ctrlp']
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

" Leader bindings
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
nmap <leader>q :qa<cr>
nmap <leader>co :copen<cr>
nmap <leader>o :lopen<cr>
nmap <leader>m :marks<cr>
nmap <leader>a :Ack<Space>
nmap <leader>T :silent! lvimgrep /TODO\\|FIXME/ %<cr>:lopen<cr>
nmap <leader>tt :TagbarToggle<CR>
nmap <leader>f :Neoformat<cr>

" Clear sign column (if signs left over by e.g. rls + LanguageClient).
nmap <leader>cl :sign unplace *<cr>

" Show syntax highlighting groups for the element under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
