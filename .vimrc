set nocompatible
filetype off

call pathogen#helptags() 
call pathogen#infect() 

filetype on
filetype plugin on
filetype plugin indent on

let mapleader = ","

set co=80
set lines=24
set nu
syn on
set ofu=syntaxcomplete#Complete
set autoread
set autowrite
set nobackup
set nowritebackup
set showmatch
set inc
set hlsearch
set showmode
set foldmethod=indent
set foldlevel=99
set completeopt+=longest,menuone,preview

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"set autoindenting for programming
set ai

"Always display status line
set laststatus=2 

set statusline=%F    "Full path to the file
set statusline+=\ -\        "Separator 
set statusline+=%-4{fugitive#statusline()}  "If using git, show 
                                            "branch being used 
					    "in status line.
set statusline+=%=    "Switch to the right side
set statusline+=%l    "Current line
set statusline+=/    " Separator
set statusline+=%L    "Total lines
"
"
"%{fugitive#statusline()}

"set dictionary+=/usr/share/dict/words

"------------------------------------------
"Some Python settings:
"
autocmd FileType python set omnifunc=pythoncomplete#Complete

autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(
"This will allow you to check the syn­tax ofy­our entire file by typing :make. you can the get a list of errors with :clist and move between the errors with :cn and :cp.
"
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"

autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

let g:pydiction_location="~/.vim/bundle/pydiction/complete-dict"

"let g:pyflakes_use_quickfix=0

let g:pep8_map='<leader>8'

let g:SuperTabDefaultCompletionType="context"

" Execute file being edited with <Command> + e:
map <buffer> <D-e> :w\|!/opt/local/bin/env python % <CR>


" Add the virtualenv's site-packages to vim path

python << EOF

import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	sys.path.insert(0,project_base_dir)
	activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF


"
" Refactoring using ropevim
"
nmap <leader>rj :RopeGotoDefinition<CR>
nmap <leader>rr :RopeRename<CR>


"
" Execute py tests
"
nmap <silent><leader>ptf <Esc>:Pytest file<CR>
nmap <silent><leader>ptc <Esc>:Pytest class<CR>
nmap <silent><leader>ptm <Esc>:Pytest method<CR>

"
" Cycle through test errors
"

nmap <silent><leader>ptn <Esc>:Pytest next<CR>
nmap <silent><leader>ptp <Esc>:Pytest previous<CR>
nmap <silent><leader>pte <Esc>:Pytest error<CR>



"------------------------------------------

map <D-F11> :NERDTreeToggle <CR>
map <C-P> :make %<CR>
map <D-F3> <ESC>:set guifont=*<CR>
map <buffer> K : execute "!xterm -e 'pydoc " . expand("<cword>") . "'"<CR>
nmap <leader>a <Esc>:Ack!
"
" Taglist variables
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0
" Shorter commands to toggle Taglist display
nnoremap TT :TlistToggle<CR>
map <D-F12> :TlistToggle<CR>
" Various Taglist diplay config:
let Tlist_Use_Left_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1



" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':

let g:tex_flavor='latex'
"Ctrl+vi direction keys[hjkl] for window movement
let g:miniBufExplMapWindowNavVim=1
"Ctrl+ arrow keys for window movement
let g:miniBufExplMapWindowNavArrows=1
"<C-Tab> and <C-S-Tab> to move between buffers
let g:miniBufExplMapCTabSwitchBufs=1

let g:miniBufExplMapModSelTarget=1
let g:miniBufExplSplitBelow=1
let g:miniBufExplVSplit=15

"Gundo Toggle
map <leader>g :GundoToggle<CR>

"Open miniBufExpl
map <leader>b :MiniBufExplorer<CR>
"close miniBufExpl
map <leader>c :CMiniBufExplorer<CR>
"update miniBufExpl
map <leader>u :UMiniBufExplorer<CR>


"cd to current working directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" edit vimrc file
nmap <leader>v :tabedit $MYVIMRC<CR>

"If you forget to sudo before calling vim use the following to be
"able to write the file.
cmap w!! %!sudo tee > /dev/null %

" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
	    set lines=24
            "colorscheme eclipse 
            "colorscheme  desert
            "colorscheme twilight
            colorscheme zenburn

            set guifont=Inconsolata-dz:h18
            "set guifont=Courier:h18
            set guicursor=n-v-c:block-Cursor
            highlight Cursor guifg=yellow guibg=blue
    else
	    if &term =~ "xterm"
              if has("terminfo")
		         set t_Co=8
		         set t_Sf=3%p1%dm
		         set t_Sb=4%p1%dm
	          else
		         set t_Co=8
		         set t_Sf=3%dm
		         set t_Sb=4%dm
              endif
        endif
    endif
" }
"
"
" Source the vimrc file after saving it

if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif
