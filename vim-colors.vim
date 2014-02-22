
let g:colors_name = "ap1"

syntax reset
set bg=dark

" GENERAL COLORS
highlight Normal           ctermfg=none         ctermbg=none       cterm=none
highlight NonText          ctermfg=238          ctermbg=none       cterm=none   " EOL marker, ~ at EOF
highlight SpecialKey       ctermfg=darkblue     ctermbg=none       cterm=none   " list keys: tabs, trailing spaces

" CURRENT POSITION
highlight CursorLine       ctermfg=none         ctermbg=234        cterm=none   " highlight bg color of current line
highlight CursorColumn     ctermfg=none         ctermbg=none       cterm=BOLD
highlight Cursor           ctermfg=black        ctermbg=white      cterm=reverse
highlight LineNr           ctermfg=243          ctermbg=235        cterm=none
highlight CursorLineNr     ctermfg=235          ctermbg=243        cterm=none   " MacVIM only ?

" MORE POSITION
highlight Visual           ctermfg=none         ctermbg=darkgray   cterm=none
highlight MatchParen       ctermfg=none         ctermbg=darkcyan   cterm=none

" TABS
highlight TabLineSel       ctermfg=yellow       ctermbg=34         cterm=bold
highlight TabLine          ctermfg=white        ctermbg=22         cterm=none
highlight TabLineFill      ctermfg=lightgreen   ctermbg=22         cterm=none

" STATUS BAR
highlight StatusLine       ctermfg=white        ctermbg=darkgray   cterm=none
highlight StatusLineNC     ctermfg=yellow       ctermbg=238        cterm=none
highlight ModeMsg          ctermfg=black        ctermbg=cyan       cterm=BOLD    " mode, like --INSERT--

" SCREEN AREAS
highlight VertSplit        ctermfg=237          ctermbg=238        cterm=none
" highlight ColorColumn  " highlight a column, like 80 or a right margin

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
highlight Title            ctermfg=225          ctermbg=none       cterm=bold   " title from :set all
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



