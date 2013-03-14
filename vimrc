
" NOTES
" - leader key is defined as backslash

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"=== GVIM ===

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


"=== BACKUPS ===

""  " save backup files~ to $HOME/.vim-save
""  " but don't freak out if $HOME/.vim-save does not exist
set backup
set backupdir=~/.vim-save,.


"=== INDENTATION ===

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


"=== FILE TYPES ===

" non-standard file types
"au BufRead,BufNewFile *.t set filetype=perl
au BufRead,BufNewFile *.ino set filetype=cpp   " arduino CPP

syntax enable


"=== COLORS ===

set t_Co=256

" see :help group-name
set bg=dark
highlight Comment     ctermfg=cyan  ctermbg=none cterm=none
highlight Identifier  ctermfg=green ctermbg=none cterm=none
highlight PreProc     ctermfg=white ctermbg=none cterm=bold
highlight Ignore      ctermfg=grey  ctermbg=none cterm=none


"=== FOLDING ===

highlight Folded      ctermfg=blue  ctermbg=none


"=== SEARCH ===

set hlsearch
highlight search    ctermfg=yellow ctermbg=darkblue cterm=bold
highlight incsearch ctermfg=white  ctermbg=cyan cterm=bold


"=== SPELLING ===

nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_us
set spell
highlight SpellBad   ctermfg=none ctermbg=none cterm=underline
highlight SpellCap   ctermfg=none ctermbg=none cterm=underline
highlight SpellRare  ctermfg=none ctermbg=none cterm=underline
highlight SpellLocal ctermfg=none ctermbg=none cterm=underline


"=== LINE NUMBERS ===

nmap <silent> <leader>n :set number!<CR>
set number

" highlight searches
set hlsearch

" highlight parens
set matchpairs=(:),{:},[:]
set matchpairs+=<:>

" wrapping
set nowrap


"=== WINDOW ===

" show status line on bottom (0=never, 1=when >1 windows, 2=always)
set laststatus=2

" stack windows very tightly
set winminheight=0

" scrolling
set scrolloff=3


"=== CURSOR ===

" remember last cursor position (if within file limits)
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif


"=== MOUSE ===

" use mouse to switch windows and move cursor
set ttymouse=xterm2
set mouse=n


"=== TABS / INDENT ===

set tabstop=4
set softtabstop=4
set expandtab  " use :retab to convert existing tabs using expandtab (tab->4sp)

" indentation / prettification
set shiftwidth=4  " used by > indent and = reformat

" show tabs and trailing spaces
nmap <silent> <leader>l :set list!<CR>
set list listchars=tab:>-,trail:·,precedes:<,extends:>,eol:\|
"set listchars=eol:·

" The listchars option uses:
"  - the "NonText" highlighting group for "eol", "extends" and "precedes"
"  - the "SpecialKey" highlighting group for "nbsp", "tab" and "trail"
" See ":help 'listchars'".
highlight NonText ctermfg=darkblue ctermbg=none cterm=none
highlight SpecialKey ctermfg=blue ctermbg=none cterm=none


"=== WINDOWS ===

""nnoremap <F5>   <C-W>W
""nnoremap <S-F5> <C-W>W<C-W>_
""nnoremap <F6>   <C-W>w
""nnoremap <S-F6> <C-W>w<C-W>_
nnoremap <C-Up>      <C-W>W<C-W>_
nnoremap <C-Down>    <C-W>w<C-W>_
nnoremap <C-W><Up>   <C-W>W<C-W>_
nnoremap <C-W><Down> <C-W>w<C-W>_
nnoremap <F2> <C-W>_


"=== KEYBOARD ===

" ESCAPE & composed key timeouts
set timeout timeoutlen=3000 ttimeout ttimeoutlen=100


"=== SCREEN / TMUX ===

" see http://tmux.cvs.sourceforge.net/viewvc/tmux/tmux/FAQ
if &term == "screen"
   set t_kN=^[[6;*~
   set t_kP=^[[5;*~
   " see also "ttyfast"
endif


"=== VIMDIFF ===

if &diff
   "set t_Co=256
   "set background=dark
   "colorscheme peaksea
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Quiet()
   set nolist
   set nospell
   set nonumber
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXPERIMENTS

"if !exists("autocommands_loaded")
"  let autocommands_loaded = 1
"   " but you SHOULD do syntax highlighting if possible
"   autocmd Filetype * syntax on
"   " custom colors for syntax highlighting
"   autocmd Filetype * highlight Comment ctermfg=blue
"endif

" vim outliner
"autocmd Filetype vo_base filetype plugin indent on

""map <silent> <f12> :colorscheme dark<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

