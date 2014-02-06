
" This file starts off FOLDED. Do zo to unfold a section or zR to unfold all.
" vim: fmr={{{,}}}
" vim: fdm=marker

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"{{{1 === CURSOR MOVEMENT ===

" to move cursor up/down to DISPLAY lines (on long wrapped lines) >> gj/gk
" to move cursor to beginning/end of DISPLAY lines >> g0/g$

" swap REAL vs DISPLAY line up/down motions:
"" nnoremap k gk
"" nnoremap gk k
"" nnoremap j gj
"" nnoremap gj j

" train yourself not to use the arrow keys (temporary)
"" noremap <Up>    <Nop>
"" noremap <Down>  <Nop>
"" noremap <Left>  <Nop>
"" noremap <Right> <Nop>

" w = next word, b = back a word (use W/B for WORDS)
" ALSO, e = end of word, ge = end of previous word

" f = find char, ; = find again
" F = backwards find char, , = backwards find again
" t = search "unTil" before char, T = search backwards "unTil"

" <leader> key defaults to backslash, I use it for my custom keystrokes
let mapleader="\\"
"" TO SWAP \ AND , DO THIS >> let mapleader=","
"" TO SWAP \ AND , DO THIS >> noremap \ ,


"{{{1 === VISUAL MODE ===

" v = visual mode by char
" V = visual mode by line
" <C-v> = visual mode by block


"{{{1 === OPERATOR PENDING MODE ===

" d_ = delete _something_
" c_ = change _semething_
" y_ = yank _something_


"{{{1 === MARKS ===

" mx = set mark x
" 'x = go to line of mark x
" `x = go to mark x

" special marks:
" `` = position before the last jump within current file
" `. = location of last change (g; will go back through changes, g, will go forward)
" `^ = location of last insertion (gi will continue inserting here)
" `[ = start of last change or yank
" `] = end of last change or yank
" `< = start of last visual selection
" `> = end of last visual selection


"{{{1 === COMMAND MODE ===

" NOTES about the "command-line window", a multi-line version of command line:
" This is often seen when we mis-type :q as q: .
" From normal mode, q: pulls up the "command-line window" with history of ex commands.
" From normal mode, q/ pulls up the "command-line window" with history of searches.
" From command mode, <C-f> expands the current command line into a window.

" history of ex commands
set history=200

" map %% to 'directory of current file', normally done using %:h
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


"{{{1 === TEXT OBJECTS ===

" delimited (block) text object = a delimited piece of text, like xml tag, string, stuff in parens, etc
"    ) = parens, } = curly braces, ] = square brackets, > = angle brackets
"    b = braces (parens), B = curly braces, "    ] = square brackets, > = angle brackets, t = xml tags,
"    ' = single quotes, " = double quotes, ` = backticks
" language (non-block) text object
"    w = word, W = WORD, s = sentence, p = paragraph

" use text objects in visual mode to select a block
" use text objects in operator pending mode to operate on a block

" i_ = INSIDE a text object, where _ is one of >> ) } ] > ` ' " t b B
" a_ = AROUND a text object
" usually, you CHANGE INSIDE and DELETE AROUND


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

" zo = fold open one
" zc = fold close one
" zr = fold reduce one level
" zR = fold reduce all levels
" zm = fold more one level
" zM = fold more all levels

set foldenable
set foldmethod=manual
set foldmarker={{{,}}}
highlight Folded      ctermfg=blue  ctermbg=none


"{{{1 === SEARCH ===

" special search codes:
" \C = force case-sensitive search
" \c = force case-insensitive search
" \m = use vim's default "magic" search (ALMOST regex)
" \M = use vi's older "nomagic" search
" \v = very magic search (very regex, all punctuation except _ have special meaning)
" \V = very nomagic search, or "verbatim" search (only \ has special meaning)
" \x = hex character
" \zs \ze = define submatch (find quoted string, match just the string)

set incsearch
set hlsearch
highlight search    ctermfg=yellow ctermbg=darkblue cterm=bold
highlight incsearch ctermfg=white  ctermbg=cyan cterm=bold

" ignore case... unless we type an uppercase in the search
" or use \c or \C to force case insensitive or sensitive
set ignorecase
set smartcase

set nogdefault  " (do not) assume global '/g' option when searching

" \/ will clear highlighted search
nnoremap <silent> <leader>/ :nohlsearch<CR>


" nice trick: find repeated words /\v<(\w+)\_s+\1>


"{{{1 === TAB COMPLETION ===

" TAB completion:
" match as much as you can, show options, pressing RIGHT will navigate a list
set wildmenu
set wildmode=longest,list


"{{{1 === SPELLING ===

" NOTES
" for spell-checker suggestions, do z=

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
" move between matching pairs >> %

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
set ruler


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
nnoremap <C-Left>  <C-W>h<C-W>_
nnoremap <C-Down>  <C-W>j<C-W>_
nnoremap <C-Up>    <C-W>k<C-W>_
nnoremap <C-Right> <C-W>l<C-W>_

" Quicker window movement with control h/j/k/l.
nnoremap <C-h> <C-w>h<C-W>_
nnoremap <C-j> <C-w>j<C-W>_
nnoremap <C-k> <C-w>k<C-W>_
nnoremap <C-l> <C-w>l<C-W>_

" function keys: F3=equal, F4=max
nnoremap <F3> <C-W>=
nnoremap <F4> <C-W>_

" function keys: F5=left, F6=less, F7=more, F8=right
nnoremap <F5> <C-W><
nnoremap <F6> <C-W>-
nnoremap <F7> <C-W>+
nnoremap <F8> <C-W>>


"{{{1 === SCREEN TABS ===

" gt = go to next tab ("go tab")
" gT = go to previous tab
" {N}gt = go to tab {N}
" <C-w>T = break current window out to a new tab
" :tabnew {filename} = tab edit {filename}
" vim -p file1 file2 = open in tabs

:hi TabLine     ctermfg=white       ctermbg=22      cterm=none
:hi TabLineSel  ctermfg=yellow      ctermbg=34      cterm=bold
:hi TabLineFill ctermfg=lightgreen  ctermbg=22      cterm=none
:hi Title       ctermfg=cyan

" function keys: F9=prev, F10=next
nnoremap <F9>  gT
nnoremap <F10> gt

" ALSO - see crazy custom tabline functions
" http://www.theworldofstuff.com/linux/vimrc.txt
" http://stackoverflow.com/questions/7238113/customising-the-colours-of-vims-tab-bar
" http://vim.wikia.com/index.php?title=Show_tab_number_in_your_tab_line&oldid=29439 (GUI only)


"{{{1 === CURSOR APPEARANCE ===

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

"{{{1 === COPY/PASTE AND REGISTERS ===

" from normal mode:
" "xd = delete into register x
" "xy = yank from register x
" "xp = paste from register x
" use lowercase letters to REPLACE register contents
" use uppercase letters to APPEND register contents

" from insert mode:
" <C-r>x = insert contents of register x

" some registers of interest:
"   0 contains last YANK (not affected by x, (d)elete or (c)hange)
"   + is the system clipboard
"   * is the system select (X11 "primary")
"   = is the "expression register", drops into command mode to take an expression
"   % contains the current filename
"   # contains that alternate filename
"   . contains the last inserted text
"   : contains the last ex command
"   / contains the last search pattern

" from command mode:
" :let @x = "foo" - write to a register
" :reg 0a         - show specific registers
" :reg            - show all registers
" :dis            - show all registers
" :put x          - put contents of register x below the current line

" When appending to a register, put a line break before the appended text.
set cpoptions+=>

" gp and gP paste, but leave the cursor at the other end


"{{{1 === MACROS ===

" start recording macro x >> qx
" use lowercase letters to REPLACE register contents
" use uppercase letters to APPEND register contents
" end recording macro >> q

" in normal mode >> @x
" in visual mode >> '<,'>normal @x  (runs macro once for each selected line)
" to see macro contents >> :reg x
" to run a macro on all files >> :argdo normal @x


"{{{1 === MOUSE ===

" use mouse to switch windows and move cursor
set ttymouse=xterm2
set mouse=n
nmap <silent> <leader>m :set mouse=<CR>


"{{{1 === KEYBOARD ===

" ESCAPE & composed key timeouts
set notimeout timeoutlen=300
set ttimeout ttimeoutlen=100


"{{{1 === SCREEN / TMUX ===

"DOESNTWORK  " Fix home and end keybindings for screen, particularly on Mac.
"DOESNTWORK  " (For some reason this fixes the arrow keys too. huh?.
"DOESNTWORK  map  [F $
"DOESNTWORK  imap [F $
"DOESNTWORK  map  [H g0
"DOESNTWORK  imap [H g0


" see http://tmux.cvs.sourceforge.net/viewvc/tmux/tmux/FAQ
if &term == "screen"
   set t_kN=[6;*~
   set t_kP=[5;*~
   " see also "ttyfast"
endif


"{{{1 === VIMDIFF ===

" NOTES
" find next/prev change ]c/[c
" obtain/put diff from/to other window >> do/dp
" do a diff on existing vsplit >> :diffthis
" refresh diffs >> :diffupdate
" stop doing diff >> :diffoff
" neat trick >> :newtab file1, :vsp file2, :windo diffthis
" shorter >> :newtab file1, :vert diffsplit file2 (or :diffsplit file2 for horizontal split)

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


"{{{1 === HUH? WILD STUFF ===

" For when you forget to sudo.. Really Write the file.
" (Note mapping w!! causes a weird pause on all :w's)
cmap W! w !sudo tee % >/dev/null
" From command mode, do >> :w !sudo tee % > /dev/null

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


"{{{1 === PLUGINS ===

" "matchit", a built-in vim plugin - match keyword pairs (if/endif)
" "surround" by Tim Pope - changes surrounding quotes or brackets


"{{{1 === PLUGIN:PATHOGEN ===

" see https://github.com/tpope/vim-pathogen
" see http://www.vim.org/scripts/script.php?script_id=2332
if filereadable(expand("~/.vim/autoload/pathogen.vim"))
   execute pathogen#infect()
endif


"{{{1 === FOR FURTHER STUDY ===

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

" vim >> jumplist, changelist, vimgrep

"}}}1

