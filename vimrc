" This file starts off FOLDED. Do zo to unfold a section or zR to unfold all.
" vim: fmr={{{,}}}
" vim: fdm=marker

" edit, then source it back in using >> :so %  or  :so $MYVIMRC

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"{{{1 === BASICS ===
"
" As the help says, 'Make vim behave in a more useful way'.
" 'nocompatible' must be on the first uncommented line
" note - setting or resetting 'compatible' will overwrite 'formatoptions'
set nocompatible
set encoding=utf-8


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

" nice tricks
" gg = go to top of file
" '' = go to previous cursor location

" <leader> key defaults to backslash, I use it for my custom keystrokes
let mapleader="\\"
"" TO SWAP \ AND , DO THIS >> let mapleader=","
"" TO SWAP \ AND , DO THIS >> noremap \ ,
let maplocalleader="\\"


"{{{1 === VISUAL MODE ===

" v = visual mode by char
" V = visual mode by line
" <C-v> = visual mode by block
" gv = re-select last visual mode selection

" see colorscheme


"{{{1 === OPERATOR PENDING MODE ===

" d_ = delete _something_
" c_ = change _semething_
" y_ = yank _something_

" =_ >> fix indention on _something_


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

" Use backups - http://stackoverflow.com/a/15317146
if !isdirectory(expand('~/.vim/backup/', 1))
    silent call mkdir(expand('~/.vim/backup', 1), 'p')
endif
set backup
set writebackup
set backupdir=~/.vim/backup//


"{{{1 === EMBEDDED MODE LINES ===

set modeline


"{{{1 === INDENTATION ===

" =_ >> manually indent _something_ (operator pending mode, also works in visual block mode)
" examples: =i{ >> indent inside block, =a{ >> indent a block

" Four different indentation rules, in this order:
" indentexpr, cindent, smartindent, autoindent

" (1) indentexpr
set indentexpr=

" (2) C-style indentation
" Note that top-level functions must have { in the first column.
set cindent
" see :help cinoptions for a complete list of rules.
set cinoptions=(1s,m1,li

" (3) smartindent = Do smart autoindenting when starting a new line (not as good as cindent).
" When 'cindent' is on, setting 'smartindent' has no effect.

" personal preference - under no circumstances should you auto-indent
set nocindent
set nosmartindent

" (4) autoindent = Copy indent from current line when starting a new line.
set noautoindent

" textwidth = right margin for wrapping for normal input and 'gq' reformatting.
set textwidth=0


"{{{1 === FORMAT OPTIONS ===

" to see current settings >>> :set formatoptions?
" for list of options >>> :help fo-table
set formatoptions+=c   " auto-wrap comments
set formatoptions+=r   " insert comment leader on CR
set formatoptions-=o   " insert comment leader on O or o line insert
set formatoptions+=q   " format using gq

" see http://stackoverflow.com/a/23326474/542630
" formatoptions is overwritten by a C file plugin loaded after .vimrc.
augroup Format-Options
    autocmd!
    autocmd BufEnter * setlocal formatoptions+=crq formatoptions-=o
augroup END

" press \p to set (or unset) paste mode (which squelches the options above)
nmap <silent> <leader>P :set paste!<CR>


"{{{1 === FILE TYPES ===

" non-standard file types
"au BufRead,BufNewFile *.t set filetype=perl
au BufRead,BufNewFile *.ino set filetype=cpp   " arduino CPP

syntax enable
set synmaxcol=0


"{{{1 === COLORS ===

" color numbers >> http://upload.wikimedia.org/wikipedia/commons/9/95/Xterm_color_chart.png
" convert to RGB >> http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
set t_Co=256

" see :help group-name
" see :help hl-normal (and friends)

" GENERAL COLORS
highlight Normal           ctermfg=none         ctermbg=none       cterm=none
highlight NonText          ctermfg=238          ctermbg=none       cterm=none   " EOL marker, ~ at EOF
highlight SpecialKey       ctermfg=darkblue     ctermbg=none       cterm=none   " list keys: tabs, trailing spaces

" CURRENT POSITION
highlight Cursor           ctermfg=black        ctermbg=white      cterm=reverse
highlight LineNr           ctermfg=244          ctermbg=235        cterm=none
highlight CursorLineNr     ctermfg=yellow       ctermbg=234        cterm=bold
highlight CursorLine       ctermfg=none         ctermbg=234        cterm=none   " see: set cursorline
highlight CursorColumn     ctermfg=none         ctermbg=234        cterm=none   " see: set cursorcolumn

" MORE POSITION
highlight Visual           ctermfg=none         ctermbg=darkgray   cterm=none
highlight MatchParen       ctermfg=none         ctermbg=darkcyan   cterm=none
highlight ColorColumn                           ctermbg=22         guibg=darkgreen

" TABS
highlight TabLineSel       ctermfg=white        ctermbg=34         cterm=bold
highlight TabLine          ctermfg=lightgray    ctermbg=22         cterm=none
highlight TabLineFill      ctermfg=lightgreen   ctermbg=22         cterm=none
highlight Title            ctermfg=darkcyan     ctermbg=none       cterm=none   " num splits in tab, title on :set all

" STATUS BAR
highlight StatusLine       ctermfg=white        ctermbg=245        cterm=bold
highlight User1            ctermfg=black        ctermbg=245        cterm=bold    " stuff within %1* and %0*
highlight StatusLineNC     ctermfg=lightgray    ctermbg=238        cterm=none
highlight ModeMsg          ctermfg=black        ctermbg=cyan       cterm=bold    " mode, like --INSERT--

" SCREEN AREAS
highlight VertSplit        ctermfg=237          ctermbg=238        cterm=none

" FOLDING
highlight Folded           ctermfg=blue         ctermbg=none       cterm=none

" SPELLING
highlight SpellBad         ctermfg=none         ctermbg=none       cterm=underline
highlight SpellCap         ctermfg=none         ctermbg=none       cterm=underline
highlight SpellRare        ctermfg=none         ctermbg=none       cterm=underline
highlight SpellLocal       ctermfg=none         ctermbg=none       cterm=underline

" VIMDIFF
highlight DiffAdd          ctermfg=229          ctermbg=28         cterm=bold
highlight DiffDelete       ctermfg=124          ctermbg=88         cterm=bold
highlight DiffChange       ctermfg=11           ctermbg=17         cterm=none
highlight DiffText         ctermfg=11           ctermbg=4          cterm=bold

" SEARCH
highlight Search           ctermfg=yellow       ctermbg=darkblue   cterm=bold
highlight IncSearch        ctermfg=white        ctermbg=cyan       cterm=bold

" ATTENTION GETTERS
highlight ErrorMsg         ctermfg=white        ctermbg=red        cterm=none
highlight WarningMsg       ctermfg=white        ctermbg=red        cterm=none
highlight Question         ctermfg=yellow       ctermbg=none       cterm=none

" OTHER SCREENS, like :set all
highlight MoreMsg          ctermfg=121          ctermbg=none       cterm=bold    " MORE prompt

" SYNTAX HIGHLIGHTING
highlight Comment          ctermfg=darkcyan     ctermbg=none       cterm=none
highlight Constant         ctermfg=magenta      ctermbg=none       cterm=none
highlight String           ctermfg=magenta      ctermbg=none       cterm=none
highlight Character        ctermfg=magenta      ctermbg=none       cterm=none
highlight Number           ctermfg=magenta      ctermbg=none       cterm=none
highlight Boolean          ctermfg=magenta      ctermbg=none       cterm=none
highlight Float            ctermfg=magenta      ctermbg=none       cterm=none
highlight Identifier       ctermfg=green        ctermbg=none       cterm=none
highlight Function         ctermfg=green        ctermbg=none       cterm=none
highlight Statement        ctermfg=yellow       ctermbg=none       cterm=none
highlight Conditional      ctermfg=yellow       ctermbg=none       cterm=none
highlight Repeat           ctermfg=yellow       ctermbg=none       cterm=none
highlight Label            ctermfg=yellow       ctermbg=none       cterm=none
highlight Operator         ctermfg=yellow       ctermbg=none       cterm=none
highlight Keyword          ctermfg=yellow       ctermbg=none       cterm=none
highlight Exception        ctermfg=yellow       ctermbg=none       cterm=none
highlight PreProc          ctermfg=white        ctermbg=none       cterm=bold
highlight Include          ctermfg=white        ctermbg=none       cterm=bold
highlight Define           ctermfg=white        ctermbg=none       cterm=bold
highlight Macro            ctermfg=white        ctermbg=none       cterm=bold
highlight PreCondit        ctermfg=white        ctermbg=none       cterm=bold
highlight Type             ctermfg=lightgreen   ctermbg=none       cterm=none
highlight StorageClass     ctermfg=lightgreen   ctermbg=none       cterm=none
highlight Structure        ctermfg=lightgreen   ctermbg=none       cterm=none
highlight Typedef          ctermfg=lightgreen   ctermbg=none       cterm=none
highlight Special          ctermfg=224          ctermbg=none       cterm=none
highlight SpecialChar      ctermfg=224          ctermbg=none       cterm=none
highlight Tag              ctermfg=224          ctermbg=none       cterm=none
highlight Delimiter        ctermfg=224          ctermbg=none       cterm=none
highlight SpecialComment   ctermfg=224          ctermbg=none       cterm=none
highlight Debug            ctermfg=224          ctermbg=none       cterm=none
highlight Underlined       ctermfg=81           ctermbg=none       cterm=underline
highlight Ignore           ctermfg=0            ctermbg=none       cterm=none
highlight Error            ctermfg=15           ctermbg=9          cterm=reverse
highlight Todo             ctermfg=0            ctermbg=11         cterm=standout

" FILE TYPES
highlight Directory        ctermfg=lightblue    ctermbg=none       cterm=none

" POP-UP MENUS
"highlight WildMenu
"highlight Pmenu
"highlight PmenuSel
"highlight PmenuSbar
"highlight PmenuThumb


"{{{1 === FOLDING ===

" zo = fold open one
" zc = fold close one
" zr = fold reduce one level
" zR = fold reduce all levels
" zm = fold more one level
" zM = fold more all levels

if has('folding')
   set foldenable
   set foldmethod=manual
   set foldmarker={{{,}}}
endif


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

" search suffixes:
" g = global (many per line)
" c = confirm
" n = no (just show count, do not replace)
" e = suppress errors

set incsearch
set hlsearch

" unhighlight the last search pattern on Enter
nn <silent> <cr> :nohlsearch<cr><cr>

" ignore case... unless we type an uppercase in the search
" or use \c or \C to force case insensitive or sensitive
set ignorecase
set smartcase

set nogdefault  " (do not) assume global '/g' option when searching

" \/ will clear highlighted search
nnoremap <silent> <leader>/ :nohlsearch<CR>

" from NORMAL or VISUAL mode
" make & repeat the last search/replace/flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" nice tricks:
" find repeated words >> /\v<(\w+)\_s+\1>
" :&& = repeat same search, same replace, same flags (nice to use from VISUAL MODE)
" g& = :%&& = :%s//~/& = repeat same search, same replace, same flags, for ALL lines
" :%s/\d\+/\=submatch(0)-1/g = add one to every number
" :s/\v(<man>|<dog>)/\={"foo":"bar","bar":"foo"}[submatch(1)]/g = swap 'foo' and 'bar'


"{{{1 === TAB COMPLETION ===

" TAB completion:
" match as much as you can, show options, pressing RIGHT will navigate a list
set wildmenu
set wildmode=longest,list


"{{{1 === SPELLING ===

" NOTES
" navigate to next/prev spelling error >> [s / ]s
" for spell-checker suggestions >> z=
" from insert mode >> <C-x><C-s> for spelling autocompletion
" same thing, but scan backwards from cursor >> <C-x>s

" add word to spellcheck file >> zg
" remove word from spellcheck file >> zw
" undo add/remove >> zug

nmap <silent> <leader>s :set spell!<CR>
nnoremap <leader>S ea<C-X><C-S>
set spelllang=en   " or en_us
set spell

" add project spellfile >> setlocal spellfile+=~/work/myjargon.utf-8.add


"{{{1 === LINE NUMBERS ===

nmap <silent> <leader># :set number!<CR>
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

" textwidth is used by 'gq' to wrap paragraphs
" also used when entering text manually, so set to 0
set textwidth=0

" show tabs and trailing spaces
nmap <silent> <leader>l :set list!<CR>
set list listchars=tab:>-,trail:·,precedes:<,extends:>,eol:«
"set listchars= eol:\|
"set listchars=eol:·

" The listchars option uses:
"  - the "NonText" highlighting group for "eol", "extends" and "precedes"
"  - the "SpecialKey" highlighting group for "nbsp", "tab" and "trail"
" See ":help 'listchars'".
" see colorscheme


"{{{1 === BUFFERS ===
map <leader>c :bp<bar>sp<bar>bn<bar>bd<CR>
map <leader>n :bnext!<cr>
map <leader>p :bprevious!<cr>


"{{{1 === SCREEN LAYOUT ===

" show status line on bottom (0=never, 1=when >1 windows, 2=always)
set laststatus=2
" show character under cursor (%b\ 0x%B), line (%l), column (%c), percentage (%P)
" 1 filename[HLP][+][RO]  (sep)  10%(cut here) line=6565,col=24 ASCII=32,0x20
set statusline=%n:%f\ %h%m%r%=(%l,%v)\ %P\ %<%14(%1*ASCII=%03b\,0x%02B%0*%)
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

" function keys: F9=prev, F10=next
nnoremap <F9>  gT
nnoremap <F10> gt

" ALSO - see crazy custom tabline functions
" http://www.theworldofstuff.com/linux/vimrc.txt

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
set nocursorline         " highlight current line
set nocursorcolumn       " highlight current column

" highlight where lines extend past 80 characters
call matchadd('ColorColumn', '\%82v', 100)


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
"   * is the system select (X11 'primary')
"   = is the 'expression register', drops into command mode to take an expression
"   % contains the current filename
"   # contains that alternate filename
"   . contains the last inserted text
"   : contains the last ex command
"   / contains the last search pattern

" from command mode:
" <C-r>x = insert contents of register x
" :let @x = "foo" - write to a register
" :reg 0a         - show specific registers
" :reg            - show all registers
" :dis            - show all registers
" :put x          - put contents of register x below the current line
" :%s//\=@0/g     - use register 0 (yank register) as replacement text

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
if has('mouse')
   set ttymouse=xterm2
   set mouse=n
   nmap <silent> <leader>m :set mouse=<CR>
endif


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
   "colorscheme alanporter1
endif

"set diffopt=iwhite,icase
set diffopt=filler,context:9

" use fewer colors than normal vimdiff
" http://stackoverflow.com/questions/2019281/load-different-colorscheme-when-using-vimdiff
"" highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"" highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"" highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"" highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red



"{{{1 === VIMGREP ===

" search >> :vimgrep pattern filenames
" puts results in the quickfix list, to view >> :copen


"{{{1 === CTAGS ===

" install package: exuberant-ctags
" push to definition of tag >> <C-]> or :tag {keyword} or Ctrl-LeftClick
" pop to previous tag position >> <C-t> or Ctrl-RightClick

" for a menu of multiple matches >> g<C-]> or :tjump {keyword}
" after-the-fact, to get the menu >> :tselect
" to go to other matches >> :tnext, :tprev, :tfirst, :tlast

" open the definition in a new split >> <C-w><C-]>
" open the definition in a new vertical split >> map <something> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" open the definition in a new tab >> map <something> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" to re-gen tags after every write >>
" :autocmd BufWritePost * call system("ctags -R")


"{{{1 === JUMP LIST ===

" go back through the jump list >> <C-o>
" go forward through the jump list >> <C-i>
" show the jump list >> :jumps


"{{{1 === MAKE / QUICK FIX LIST / LOCATION LIST ===

" to make and jump to first error >> :make
" to make without moving >> :make!

" go back through the quick fix list >> :cnext
" go forward through the quick fix list >> :cprev
" also >> :cfirst, :clast, :cnfile, :cpfile, :cc N, :copen, :cclose
" to clear >> :cex[]

" location list is like quick list... except:
" - location list is per-window, quick fix list is global
" - use :lmake, :lgrep, :lvimdiff
" - location list commands use l instead of c

" run some other command with :make >> :setlocal makeprg=blah\ blah\ %
" tell vim how to parse errors >> :setlocal errorformat=...
" similarly, :grep can be changed with grepprg and grepformat


"{{{1 === QUICK NAVIGATION ===

" navigate to next/prev spelling error >> [s / ]s

" stolen from https://github.com/tpope/vim-unimpaired/

" buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" argument list
nnoremap <silent> [a :previous<CR>
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>

" quixfix list
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>

" location list
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>

" tags
nnoremap <silent> [t :tprevious<CR>
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [T :tfirst<CR>
nnoremap <silent> ]T :tlast<CR>


"{{{1 === AUTOCOMPLETE ===

" <C-n>      Generic keywords
" <C-x><C-n> Current buffer keywords
" <C-x><C-i> Included file keywords
" <C-x><C-]> tags file keywords
" <C-x><C-k> Dictionary lookup
" <C-x><C-l> Whole line completion
" <C-x><C-f> Filename completion
" <C-x><C-o> Omni-completion

" define which categories are used for "generic" complete
set complete=.,w,b,u,t,i


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
  " eventignore+=FileType (no syntax highlighting etc assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
  augroup END
endif


"{{{1 === MULTIPLE FILES ===

" to work with many files >> :args **/*.txt
" to allow navigating away from files without closing >> :hidden
" to search/replace across all files >> :argdo %s/foo/bar/ge


"{{{1 === OS DETECTION ===
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error
   if s:uname == "Linux"
      " do Linux stuff here
   endif
   if s:uname == "Darwin"
      " do Mac stuff here
      " Apple vim is compiled without 'clipboard' support (see vim --version).
      " http://vim.wikia.com/wiki/In_line_copy_and_paste_to_system_clipboard
      " Support copy-to-system-clipboard using control-C in visual block mode.
      vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
      " and control-V in normal mode (NOTE: covers up block-visual key sequence).
      " DISABLED: nmap <C-v> :call setreg("\"",system("pbpaste"))<CR>p
   endif
endif


"{{{1 === GVIM ===

if has('gui_running')
   set lines=45 columns=120
   set bg=dark
   highlight Normal      guifg=lightgray guibg=black
   highlight Cursor      guifg=orange    guibg=black      gui=reverse
   highlight CursorLine                  guibg=#101010
endif


"{{{1 === MACVIM ===

if has('gui_macvim')
   " colors
   """ hi Normal guibg=black guifg=white
   set guifont=Monaco:h14
   " GUI Option to remove the Toolbar (T)
   """ set guioptions-=T
   ""OK colorscheme darkblue
   ""OK colorscheme desert
   colorscheme evening
   " size
   """ set lines=32
   """ set columns=110
endif


"{{{1 === PLUGINS ===

filetype plugin on

" check theese out:
" "matchit", a built-in vim plugin - match keyword pairs (if/endif)
" "surround" by Tim Pope - changes surrounding quotes or brackets


"{{{1 === PLUGIN:PATHOGEN ===

" see https://github.com/tpope/vim-pathogen
" see http://www.vim.org/scripts/script.php?script_id=2332
if filereadable(expand("~/.vim/autoload/pathogen.vim"))
   execute pathogen#infect()
endif


"{{{1 === PLUGIN:NERDTREE ===

" see https://github.com/scrooloose/nerdtree
if isdirectory(expand("~/.vim/bundle/nerdtree"))
    autocmd StdinReadPre * let s:std_in=1
    "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    map <leader>t :NERDTreeToggle<CR>
endif


"{{{1 === PLUGIN:AIRLINE ===

if isdirectory(expand("~/.vim/bundle/vim-airline"))
    " at run-time >> :AirlineTheme understated
    let g:airline_theme = 'light'
    " other nice themes: bubblegum understated
    set laststatus=2
    set noshowmode
    let g:airline#extensions#tabline#enabled = 1
endif


"{{{1 === PLUGIN:TAGBAR ===

" see http://majutsushi.github.io/tagbar/
if isdirectory(expand("~/.vim/bundle/tagbar"))
    map <leader>T :TagbarToggle<CR>
endif


"{{{1 === SPECIAL FILE TYPES ===

" MARKDOWN
" use https://github.com/plasticboy/vim-markdown
" no need for this >> au BufNewFile,BufRead *.md,*.markdown setlocal filetype=mkd
let g:vim_markdown_folding_disabled=1


"{{{1 === VIMWIKI ===

" let g:vimwiki_list = [{ 'path': '~/vimwiki/', 'path_html': '~/vimwiki_html/', 'syntax': 'markdown', 'ext': '.md', 'css_file': 'style.css', 'custom_wiki2html': '/home/alan/opt/vimwiki_md2html/misaka_md2html.py', 'auto_export': 1 }]
let g:vimwiki_list = [{ 'path': '~/vimwiki/', 'path_html': '~/vimwiki/html/', 'syntax': 'markdown', 'ext': '.wiki', 'css_file': 'style.css', 'custom_wiki2html': 'vimwiki-to-html.sh', 'auto_export': 1 }]


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

" speed
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems

" redraw
nmap <silent> <leader>r :redraw!<CR>

" nice personal vimrc files
" https://github.com/jdavis/dotfiles/blob/master/.vimrc


"}}}1

