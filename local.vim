runtime vimrc_example.vim
call pathogen#infect()

syntax on
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
        set guifont=Menlo\ Regular:h14
        colorscheme solarized
    elseif has("unix")
        set guifont=Inconsolata\ 10
        colorscheme oceandeep
    endif

endif

if has("autocmd")
    au FileType ruby        setlocal ts=2 sw=2 sts=2 expandtab
    au FileType python      setlocal ts=4 sw=4 sts=4 expandtab
    au FileType javascript  setlocal ts=2 sw=2 sts=2 expandtab
    au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set syntax=cpp11
    au BufNewFile,BufRead,BufEnter *.glsl,*.vert,*.frag,*.geom set syntax=glsl
endif

if executable('ocamlmerlin') && has('python')
  let s:ocamlmerlin = substitute(system('opam config var share'), '\n$', '', '''') . "/ocamlmerlin"
  execute "set rtp+=".s:ocamlmerlin."/vim"
  execute "set rtp+=".s:ocamlmerlin."/vimbufsync"
endif
