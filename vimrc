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

syntax enable on

" check if win32yank is installed (for windows copy-paste)
" how to install win32yank - https://stackoverflow.com/questions/44480829/how-to-copy-to-clipboard-in-vim-of-bash-on-windows
"
" curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
" unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
" chmod +x /tmp/win32yank.exe
" sudo mv /tmp/win32yank.exe /usr/local/bin/
" set clipboard=unnamed

if filereadable("/usr/local/bin/win32yank.exe")
    autocmd TextYankPost * call YankDebounced()

    function! Yank(timer)
        call system('win32yank.exe -i --crlf', @")
        redraw!
    endfunction

    let g:yank_debounce_time_ms = 500
    let g:yank_debounce_timer_id = -1

    function! YankDebounced()
        let l:now = localtime()
        call timer_stop(g:yank_debounce_timer_id)
        let g:yank_debounce_timer_id = timer_start(g:yank_debounce_time_ms, 'Yank')
    endfunction

    function! Paste(mode)
        let @" = system('win32yank.exe -o --lf')
        return a:mode
    endfunction

    map <expr> p Paste('p')
    map <expr> P Paste('P')
else
    :set clipboard=unnamedplus
endif
