syntax on

set noerrorbells
set visualbell
set tabstop=4 softtabstop=4
set expandtab
set shiftwidth=4
set smartindent
set nu
set noswapfile
set nobackup
set undodir =~/.vim/undodir
set undofile
set incsearch
set nowrap

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'

call plug#end()


colorscheme gruvbox
set background=dark


