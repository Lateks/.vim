runtime vimrc_example.vim
call pathogen#infect()

syntax on

set background=dark
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

    if has("gui_macvim")
        set guifont=Consolas:h12
    elseif has("unix")
        set guifont=Consolas\ 9
    endif

    colorscheme oceandeep
endif

if has("autocmd")
    filetype on

    au FileType ruby     setlocal ts=2 sw=2 sts=2 expandtab
    au FileType python   setlocal ts=4 sw=4 sts=4 expandtab
endif
