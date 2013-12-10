
" NOTES
" - <leader> key is defined as backslash, used for my custom keystrokes
" - This file starts off FOLDED. To unfold, use zo or zr.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"{{{1 === BACKUPS ===

""  " save backup files~ to $HOME/.vim-save
""  " but don't freak out if $HOME/.vim-save does not exist
set backup
set backupdir=~/.vim-save,.


"{{{1 === EMBEDDED MODE LINES ===

set modeline


"{{{1 === INDENTATION ===

" under no circumstances should you auto-indent
set nocindent
set nosmartindent
set noautoindent


"{{{1 === FILE TYPES ===

" non-standard file types
"au BufRead,BufNewFile *.t set filetype=perl
au BufRead,BufNewFile *.ino set filetype=cpp   " arduino CPP

syntax enable


"{{{1 === COLORS ===

" color numbers >> http://upload.wikimedia.org/wikipedia/commons/9/95/Xterm_color_chart.png
set t_Co=256

" see :help group-name
set bg=dark
highlight Comment     ctermfg=cyan  ctermbg=none cterm=none
highlight Identifier  ctermfg=green ctermbg=none cterm=none
highlight PreProc     ctermfg=white ctermbg=none cterm=bold
highlight Ignore      ctermfg=grey  ctermbg=none cterm=none


"{{{1 === FOLDING ===

set foldenable
set foldmethod=manual
set foldmarker={{{,}}}
highlight Folded      ctermfg=blue  ctermbg=none


"{{{1 === SEARCH ===

set incsearch
set hlsearch
set noignorecase
set nosmartcase
highlight search    ctermfg=yellow ctermbg=darkblue cterm=bold
highlight incsearch ctermfg=white  ctermbg=cyan cterm=bold
set nogdefault  " (do not) assume global '/g' option when searching
nmap <silent> <leader>/ :nohlsearch<CR> " clear highlighted search


"{{{1 === MENU ===

set wildmenu
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.


"{{{1 === SPELLING ===

nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_us
set spell
highlight SpellBad   ctermfg=none ctermbg=none cterm=underline
highlight SpellCap   ctermfg=none ctermbg=none cterm=underline
highlight SpellRare  ctermfg=none ctermbg=none cterm=underline
highlight SpellLocal ctermfg=none ctermbg=none cterm=underline


"{{{1 === LINE NUMBERS ===

nmap <silent> <leader>n :set number!<CR>
set number

" highlight parens
set showmatch
set matchpairs=(:),{:},[:]
set matchpairs+=<:>

" wrapping
set nowrap


"{{{1 === TABS / INDENT ===

set tabstop=4
set softtabstop=4
set expandtab  " use :retab to convert existing tabs using expandtab (tab->4sp)
autocmd FileType make set noexpandtab

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


"{{{1 === SCREEN LAYOUT ===

" show status line on bottom (0=never, 1=when >1 windows, 2=always)
set laststatus=2


"{{{1 === WINDOWS ===

" NOTES
" start horizontal split by "vim -o file1 file2"
" start vertical split by "vim -O file1 file2"
" at run-time, use :sp file1 and :vsp file2
" navigate with <C-w>h/j/k/l
" wrapped navigate with <C-w>w/W
" move windows with <C-w>H/J/K/L
" resize less/more/equal/max with <C-w>-/+/=/_
" vertical resize less/more/equal with <C-w></>/=/|

" stack windows very tightly
set winminheight=0
set winminwidth=0

" I keep pressing ctrl-W in insert mode, which deletes the previous word.
imap <C-w> <Nop>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" After moving to a new window, maximize it.
"" nnoremap <C-W><Up>   <C-W>W<C-W>_
"" nnoremap <C-W><Down> <C-W>w<C-W>_

" Quicker window movement with control up/down.
" NOTE - This does not work on Mac OSX.
nnoremap <C-Up>    <C-W>k<C-W>_
nnoremap <C-Down>  <C-W>j<C-W>_
nnoremap <C-Left>  <C-W>h<C-W>_
nnoremap <C-Right> <C-W>l<C-W>_

" Quicker window movement with control h/j/k/l.
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" function keys: F5=equal, F4=max
nnoremap <F3> <C-W>=
nnoremap <F4> <C-W>_

" function keys: F5=left, F6=shorter, F7=taller, F8=right
nnoremap <F5> <C-W><
nnoremap <F6> <C-W>-
nnoremap <F7> <C-W>+
nnoremap <F8> <C-W>>


"{{{1 === CURSOR ===

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


"{{{1 === MOUSE ===

" use mouse to switch windows and move cursor
set ttymouse=xterm2
set mouse=n
nmap <silent> <leader>m set mouse=<CR>


"{{{1 === KEYBOARD ===

" ESCAPE & composed key timeouts
set notimeout timeoutlen=300
set ttimeout ttimeoutlen=100


"{{{1 === SCREEN / TMUX ===

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


"{{{1 === VIMDIFF ===

" NOTES
" find next/prev change ]c/[c
" obtain/put diff from/to other window: do/dp
" do a diff on existing vsplit: :diffthis
" refresh diffs: :diffupdate
" stop doing diff: :diffoff

if &diff
   "set t_Co=256
   "set background=dark
   "colorscheme peaksea
endif

"set diffopt=iwhite,icase
set diffopt=filler,context:9

" use fewer colors than normal vimdiff
" http://stackoverflow.com/questions/2019281/load-different-colorscheme-when-using-vimdiff
"" highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"" highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"" highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"" highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" use more intuitive colors than normal vimdiff
highlight DiffAdd    cterm=bold ctermfg=229 ctermbg=28 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=124 ctermbg=88 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=none ctermfg=11  ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=11  ctermbg=4  gui=none guifg=bg guibg=Red


"{{{1 === HUH? ===

" For when you forget to sudo.. Really Write the file.
" (but this causes a weird pause on all W's in command line)
"" cmap w!! w !sudo tee % >/dev/null

" do not interpret numbers with leading zeros as octal
" set nrformats=


"{{{1 === LOCAL ===

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }


"{{{1 === FUNCTIONS ===

function! Quiet()
   set nolist
   set nospell
   set nonumber
endfunction
nmap <silent> <leader>q :call Quiet()<CR>


"{{{1 === LARGE FILES ===

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


"{{{1 === OS DETECTION ===
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error
   if s:uname == "Linux"
      " do Linux stuff here
   endif
   if s:uname == "Darwin"
      " do Mac stuff here
      set mouse=
   endif
endif


"{{{1 === GVIM ===

if has('gui_running')
   " colors
   """color vo_dark
   hi Normal guibg=black guifg=yellow
   set bg=dark
   syn on
   " size
   set lines=50
   set columns=120
endif


"{{{1 === MACVIM ===

if has('gui_macvim')
   " colors
   hi Normal guibg=black guifg=white
   set guifont=Monaco:h14
   " GUI Option to remove the Toolbar (T)
   set guioptions-=T
   colorscheme shine
   " size
   set lines=32
   set columns=110
endif


"{{{1 === PATHOGEN ===
" see https://github.com/tpope/vim-pathogen
" see http://www.vim.org/scripts/script.php?script_id=2332
if filereadable(expand("~/.vim/autoload/pathogen.vim"))
   execute pathogen#infect()
endif


"{{{1 === EXPERIMENTS ===

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


"}}}1

" vim: fdm=marker fmr={{{,}}}

