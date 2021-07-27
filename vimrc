set nocompatible
filetype plugin on
colo default

set noerrorbells
set visualbell
set t_vb=
set splitright
set splitbelow
set termwinsize=20x0
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
set incsearch
set hlsearch

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'

call plug#end()

autocmd BufEnter NERD_tree_* | execute 'normal R'

syntax enable on
