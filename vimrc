
" gvim stuff
if has('gui_running')
   " colors
   """color vo_dark
   hi Normal guibg=black guifg=grey90
   set bg=dark
   syn on
   " size
   set lines=50
   set columns=120
endif

""  " save backup files~ to $HOME/.vim-save
""  " but don't freak out if $HOME/.vim-save does not exist
set backup
set backupdir=~/.vim-save,.

" under no circumstances should you auto-indent
set nocindent
set nosmartindent
set noautoindent
if $OSTYPE != "solaris"
   " SUNOS/SOLARIS does not support these
   set indentexpr=
   filetype indent off
   filetype plugin indent off
endif

" non-standard file types
"au BufRead,BufNewFile *.t set filetype=perl
au BufRead,BufNewFile *.ino set filetype=cpp   " arduino CPP

"if !exists("autocommands_loaded")
"  let autocommands_loaded = 1
"   " but you SHOULD do syntax highlighting if possible
"   autocmd Filetype * syntax on
"   " custom colors for syntax highlighting
"   autocmd Filetype * highlight Comment ctermfg=blue
"endif

syntax enable

" colors
"Comment - Comments within a program
"Constant - Program constants, such as numbers, quoted strings, or true/false
"Identifier - Variable identifier names
"Statement - A programming language statement, usually a keyword like "if" or "while"
"PreProc - A preprocessor, such as "#include" in C
"Type - A variable datatype, such as "int"
"Special - A special symbol, usually used for special characters like "\n" in strings
"Underlined - Text that should be underlined
"Error - Text which contains a programming language error
"Normal - everything else

" COLOR SET #1 - dark
"1 highlight Normal      ctermfg=grey ctermbg=none cterm=none
"1 highlight Comment     ctermfg=blue ctermbg=none cterm=bold
"1 highlight Statement   ctermfg=yellow ctermbg=none cterm=none
"1 highlight Constant    ctermfg=red ctermbg=none cterm=none
"1 highlight Identifier  ctermfg=cyan ctermbg=none cterm=none
"1 highlight PreProc     ctermfg=magenta ctermbg=none cterm=none
"1 highlight Type        ctermfg=green ctermbg=none cterm=none
"1 highlight Special     ctermfg=magenta ctermbg=none cterm=none
"1 highlight Error       ctermfg=white ctermbg=red cterm=bold
"1 "highlight Underlined  cterm=underline
"1 "highlight Cursor      ctermfg=white ctermbg=darkyellow cterm=bold

" COLOR SET #2 - lighter
set bg=dark
highlight Identifier  ctermfg=green ctermbg=none cterm=none
highlight PreProc     ctermfg=white ctermbg=none cterm=bold
highlight Folded      ctermfg=blue  ctermbg=none

" color of the search / incremental search
hi search    ctermfg=yellow ctermbg=darkblue cterm=bold
hi incsearch ctermfg=white  ctermbg=cyan cterm=bold

" show status line on bottom (0=never, 1=when >1 windows, 2=always)
set laststatus=2

" stack windows very tightly
set winminheight=0

" use mouse to switch windows and move cursor
set ttymouse=xterm2
set mouse=a

" tabs
set tabstop=4
set softtabstop=4
set expandtab  " use :retab to convert existing tabs using expandtab (tab->4sp)

" indentation / prettification
set shiftwidth=4  " used by > indent and = reformat

" scrolling
set scrolloff=3

" show tabs and trailing spaces
set list listchars=tab:>-,trail:·,precedes:<,extends:>
"set listchars=eol:·

" The listchars option uses the "NonText" highlighting group for "eol", "extends" and "precedes",
" and the "SpecialKey" highlighting group for "nbsp", "tab" and "trail". see ":help 'listchars'"
" (see ":help 'listchars'")
highlight NonText    ctermfg=darkgrey ctermbg=none cterm=none
highlight SpecialKey ctermfg=blue ctermbg=none cterm=none

" highlight searches
set hlsearch

" highlight parens
set matchpairs=(:),{:},[:]
set matchpairs+=<:>

" custom key mapping
""map <silent> <f12> :colorscheme dark<CR>
""nnoremap <F5>   <C-W>W
""nnoremap <S-F5> <C-W>W<C-W>_
""nnoremap <F6>   <C-W>w
""nnoremap <S-F6> <C-W>w<C-W>_
nnoremap <F2> <C-W>_

" ESCAPE & composed key timeouts
set timeout timeoutlen=3000 ttimeout ttimeoutlen=100

" remember last cursor position (if within file limits)
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" other
set nowrap
set number

" vim outliner
"autocmd Filetype vo_base filetype plugin indent on

" screen / tmux stuff
" see http://tmux.cvs.sourceforge.net/viewvc/tmux/tmux/FAQ
if &term == "screen"
   set t_kN=^[[6;*~
   set t_kP=^[[5;*~
   " see also "ttyfast"
endif

" vimdiff preferences
if &diff
   "set t_Co=256
   "set background=dark
   "colorscheme peaksea
endif


