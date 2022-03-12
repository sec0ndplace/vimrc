set nocompatible            "Make sure we have vim features (go past vi features)
filetype plugin on          "
colo slate                  "Decent enough colorscheme

set noerrorbells            "No annoying error sounds
set visualbell              "Flash for errors (disabling this in the next line)
set t_vb=                   "This line with the line above disables flashing on errors completely
set splitright              "Open new splits to the right by default
set splitbelow              "Open new splits below by default
set termwinsize=20x0        "Set default terminal size to 20x0
set tabstop=4 softtabstop=4 "Tab = 4 Spaces
set expandtab               "Inserts Spaces when tab is pressed
set shiftwidth=4            "Default indent is 4
set smartindent             "Smart indent
set nu                      "Enable line numbers
set noswapfile              "No swapfile (might set a directory for these in the future)
set nobackup                "No backups (might set a directory for these instead)
set undodir =~/.vim/undodir "Save undofile under .vim in home
set undofile                "Enable an undofile
set incsearch               "Enable incremental searching (vim searches as you type)
set wrap linebreak          "Wrap text but avoid wrapping in middle of words
set hlsearch                "Highlight searches

syntax enable on            "Enable vim syntax highlighting


""" WSL Copy-Paste (does not require vim with +clipboard, so will work with most base os vim packages)
" check if win32yank is installed (for windows copy-paste)
" how to install win32yank - https://stackoverflow.com/questions/44480829/how-to-copy-to-clipboard-in-vim-of-bash-on-windows
"
" curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
" unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
" chmod +x /tmp/win32yank.exe
" sudo mv /tmp/win32yank.exe /usr/local/bin/

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
    :set clipboard=unnamedplus "requires +clipboard to be enabled, check output of vim +version
endif


"Vim Statusline - https://www.tdaly.co.uk/projects/vim-statusline-generator/

set laststatus=2
set statusline=
set statusline+=%2*
set statusline+=%{StatuslineMode()}
set statusline+=%1*
set statusline+=\ 
set statusline+=<
set statusline+=<
set statusline+=\ 
set statusline+=%f
set statusline+=\ 
set statusline+=>
set statusline+=>
set statusline+=%=
set statusline+=%m
set statusline+=%h
set statusline+=%r
set statusline+=\ 
set statusline+=%3*
set statusline+=%{b:gitbranch}
set statusline+=%1*
set statusline+=\ 
set statusline+=%4*
set statusline+=%F
set statusline+=:
set statusline+=:
set statusline+=%5*
set statusline+=%l
set statusline+=/
set statusline+=%L
set statusline+=%1*
set statusline+=|
set statusline+=%y
hi User2 ctermbg=lightgreen ctermfg=black guibg=lightgreen guifg=black
hi User1 ctermbg=black ctermfg=white guibg=black guifg=white
hi User3 ctermbg=black ctermfg=lightblue guibg=black guifg=lightblue
hi User4 ctermbg=black ctermfg=lightgreen guibg=black guifg=lightgreen
hi User5 ctermbg=black ctermfg=magenta guibg=black guifg=magenta

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

