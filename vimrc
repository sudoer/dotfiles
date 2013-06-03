
" NOTES
" - leader key is defined as backslash

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"=== GVIM === {{{1

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


"=== BACKUPS === {{{1

""  " save backup files~ to $HOME/.vim-save
""  " but don't freak out if $HOME/.vim-save does not exist
set backup
set backupdir=~/.vim-save,.


"=== EMBEDDED MODE LINES === {{{1
set modeline


"=== INDENTATION === {{{1

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


"=== FILE TYPES === {{{1

" non-standard file types
"au BufRead,BufNewFile *.t set filetype=perl
au BufRead,BufNewFile *.ino set filetype=cpp   " arduino CPP

syntax enable


"=== COLORS === {{{1

" color numbers >> http://upload.wikimedia.org/wikipedia/commons/9/95/Xterm_color_chart.png
set t_Co=256

" see :help group-name
set bg=dark
highlight Comment     ctermfg=cyan  ctermbg=none cterm=none
highlight Identifier  ctermfg=green ctermbg=none cterm=none
highlight PreProc     ctermfg=white ctermbg=none cterm=bold
highlight Ignore      ctermfg=grey  ctermbg=none cterm=none


"=== FOLDING === {{{1

set foldenable
set foldmethod=manual
set foldmarker={{{,}}}
highlight Folded      ctermfg=blue  ctermbg=none


"=== SEARCH === {{{1

set incsearch
set hlsearch
set noignorecase
set nosmartcase
highlight search    ctermfg=yellow ctermbg=darkblue cterm=bold
highlight incsearch ctermfg=white  ctermbg=cyan cterm=bold
set nogdefault  " (do not) assume global '/g' option when searching
nmap <silent> <leader>/ :nohlsearch<CR> " clear highlighted search


"=== MENU === {{{1

set wildmenu
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.


"=== SPELLING === {{{1

nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_us
set spell
highlight SpellBad   ctermfg=none ctermbg=none cterm=underline
highlight SpellCap   ctermfg=none ctermbg=none cterm=underline
highlight SpellRare  ctermfg=none ctermbg=none cterm=underline
highlight SpellLocal ctermfg=none ctermbg=none cterm=underline


"=== LINE NUMBERS === {{{1

nmap <silent> <leader>n :set number!<CR>
set number

" highlight parens
set showmatch
set matchpairs=(:),{:},[:]
set matchpairs+=<:>

" wrapping
set nowrap


"=== TABS / INDENT === {{{1

set tabstop=4
set softtabstop=4
set expandtab  " use :retab to convert existing tabs using expandtab (tab->4sp)

" indentation / prettification
set shiftwidth=4  " used by > indent and = reformat

" show tabs and trailing spaces
nmap <silent> <leader>l :set list!<CR>
set list listchars=tab:>-,trail:·,precedes:<,extends:>,eol:«
"set listchars= eol:\|
"set listchars=eol:·

" The listchars option uses:
"  - the "NonText" highlighting group for "eol", "extends" and "precedes"
"  - the "SpecialKey" highlighting group for "nbsp", "tab" and "trail"
" See ":help 'listchars'".
highlight NonText ctermfg=238 ctermbg=none cterm=none
highlight SpecialKey ctermfg=darkblue ctermbg=none cterm=none


"=== WINDOW === {{{1

" show status line on bottom (0=never, 1=when >1 windows, 2=always)
set laststatus=2

" stack windows very tightly
set winminheight=0

" I keep pressing ctrl-W in insert mode, which deletes the previous word.
imap <C-w> <Nop>


"=== CURSOR === {{{1

" remember last cursor position (if within file limits)
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" cursor limits:
set scrolloff=3          " within 3 of top/bottom
set virtualedit=onemore  " past right end by one
set cursorline           " highlight current line
highlight cursorline ctermfg=none ctermbg=234 cterm=none " highlight bg color of current line


"=== MOUSE === {{{1

" use mouse to switch windows and move cursor
set ttymouse=xterm2
set mouse=n
nmap <silent> <leader>m set mouse=<CR>


"=== WINDOWS === {{{1

""nnoremap <F5>   <C-W>W
""nnoremap <S-F5> <C-W>W<C-W>_
""nnoremap <F6>   <C-W>w
""nnoremap <S-F6> <C-W>w<C-W>_
nnoremap <C-Up>      <C-W>W<C-W>_
nnoremap <C-Down>    <C-W>w<C-W>_
nnoremap <C-W><Up>   <C-W>W<C-W>_
nnoremap <C-W><Down> <C-W>w<C-W>_
nnoremap <F2> <C-W>_


"=== KEYBOARD === {{{1

" ESCAPE & composed key timeouts
set notimeout timeoutlen=300
set ttimeout ttimeoutlen=100


"=== SCREEN / TMUX === {{{1

" Fix home and end keybindings for screen, particularly on Mac.
" (For some reason this fixes the arrow keys too. huh?.
map  [F $
imap [F $
map  [H g0
imap [H g0


" see http://tmux.cvs.sourceforge.net/viewvc/tmux/tmux/FAQ
if &term == "screen"
   set t_kN=[6;*~
   set t_kP=[5;*~
   " see also "ttyfast"
endif


"=== VIMDIFF === {{{1

if &diff
   "set t_Co=256
   "set background=dark
   "colorscheme peaksea
endif


"=== HUH? === {{{1
" For when you forget to sudo.. Really Write the file.
" (but this causes a weird pause on all W's in command line)
"" cmap w!! w !sudo tee % >/dev/null


"=== LOCAL === {{{1

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }


"=== FUNCTIONS === {{{1

" Quiet() {{{2
function! Quiet()
   set nolist
   set nospell
   set nonumber
endfunction
nmap <silent> <leader>q :call Quiet()<CR>


"=== LARGE FILES === {{{1

" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("alan_largefile_protection")
  let alan_largefile_protection = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
  augroup END
endif


"=== EXPERIMENTS === {{{1

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

" IDEAS >> http://spf13.com/post/perfect-vimrc-vim-config-file/


"=== END === 1}}}

" vim: foldmethod=marker

