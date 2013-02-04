"---------------------------------------------------------------------
" Gedge's .vimrc
"---------------------------------------------------------------------
set nocompatible " use vim defaults, not vi defaults

" Map leader key to comma
let mapleader= ","

" Load plugins
call pathogen#infect()

"---------------------------------------------------------------------
" Syntax coloring
"---------------------------------------------------------------------

if &t_Co >= 256 || has("gui_running")
	colorscheme molokai 
	set cursorline
elseif &t_Co > 1
	colorscheme desert
endif

if &t_Co > 1
	syntax enable
endif

" Enable filetype-specific indenting and plugins
filetype plugin indent on

"---------------------------------------------------------------------
" Basic configuration
"---------------------------------------------------------------------
set nowrap           " no line wrapping
set ruler            " ruler
set number           " line numbering
set autoindent       " automatic indentation
set showmatch        " show matching brackets
set mouse=a          " enable mouse
set pastetoggle=<F2> " F2 for paste mode
set hidden           " buffers are hidden instead of closed
set showtabline=2    " always show tab bar at top
set laststatus=2    " always show status line
set history=1000    " remember more commands
set autowrite       " write on make/shell commands
set undolevels=1000 " max number of changes to remember
set visualbell      " no beeps
set noerrorbells    " no beeps
set confirm         " confirm changes before closing buffers

" Files to ignore when expanding wildcards
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o

" Whitespace behaviour
set noexpandtab      " I like <Tab>s more than spaces
set tabstop=4        " number of spaces a <Tab> character equals
set softtabstop=4    " number of spaces a <Tab> character equals (insert mode)
set shiftwidth=4     " number of spaces to use for indenting
set smartindent      " smart autoindent on new lines
set smarttab         " smart <Tab> behaviour at start of line 
set copyindent       " copy indent structure when making new lines
set backspace=indent,eol,start

" Non-printable characters
set nolist           " don't show non-printable characters
let &listchars="eol:\u00B7,tab:\u25B9\ "

" Fill characters
let &fillchars="vert:\u2577,fold:\u254C"

" Dictionary for CTRL+P and CTRL+N auto-completion
set dictionary=~/.ispell_english,/usr/share/dict/words
set complete=.,w,k
set keywordprg=dict

" Backups, swaps, and temps
set nobackup
set directory=~/.vim/tmp,/var/tmp,/tmp

" Remember cursor position for files
set viminfo='10,\"100,:20,%,n~/.vim/.viminfo
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 

" Set title in terminal window
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
if &term == "screen"
	set t_ts=k
	set t_fs=\
endif
if &term == "screen" || &term =~? "^xterm"
	set title
endif

"---------------------------------------------------------------------
" Status Line
"--------------------------------------------------------------------
function FugitiveLine()
	let has_fugitive = (exists('g:loaded_fugitive') && g:loaded_fugitive == 1)
	let out = (l:has_fugitive ? fugitive#head() : '')
	if !empty(out)
		let out = " \u2442 " . out . ' '
	endif
	return out
endfunction

function CharDescription()
	let c = matchstr(getline('.')[col('.') - 1:-1], '.')
	let nr = (c ==# "\n" ? 0 : char2nr(c))

	let out = '<' . characterize#description(nr, 'unknown')
	let entity = characterize#html_entity(nr)
	if !empty(entity)
		let out .= ', ' . entity
	endif
	let out .= '> ' . printf('U+%04X', nr)

	return out
endfunction

let &statusline=""
"let &statusline.="%2*\ \ %t\ \ "                                    " tail of the filename
let &statusline.="%1*\ \ %{strlen(&fenc)?&fenc:'none'}"             " file encoding
let &statusline.="\ \u00B7\ %{&ff}"                                 " file format
let &statusline.="\ \u00B7\ %{strlen(&ft)?&ft:'<unknown>'}"         " file type
let &statusline.="%h"                                               " help file flag
let &statusline.="%m"                                               " modified flag
let &statusline.="%r"                                               " read only flag
let &statusline.="\ \ "
let &statusline.="%0*%{FugitiveLine()}"                             " git branch
let &statusline.="%="                                               " left/right separator
let &statusline.="%{CharDescription()}\ "                           " char under cursor 
let &statusline.="%4*\ l\ %1*%5l/%-5L\ "                            " cursor line/total lines
let &statusline.="%5*\ c\ %2*%3c-%-3v\ "                            " cursor column/cursor virtual column
let &statusline.="%3*\ \ %P\ \ "                                    " percent through file

hi User1 term=bold,reverse cterm=bold,reverse ctermfg=235 ctermbg=253
hi User2 term=bold,reverse cterm=bold,reverse ctermfg=234 ctermbg=253
hi User3 term=bold,reverse cterm=bold,reverse ctermfg=233 ctermbg=253
hi User4 term=bold,reverse cterm=bold,reverse ctermfg=235 ctermbg=241
hi User5 term=bold,reverse cterm=bold,reverse ctermfg=234 ctermbg=241

"---------------------------------------------------------------------
" Search
"--------------------------------------------------------------------
set incsearch      " show matches as typing
set ignorecase     " ignore case when searching
set smartcase      " ignore case only if search pattern completely lowercase
set hlsearch       " highlight search terms
set magic            " how backslashes are interpreted in searches

" Remove highlight from searches (normal mode)
nmap <silent> <leader>/ :nohlsearch<CR>

" n/N will move to the next/previous result and center line on screen
nnoremap n nzz
nnoremap N Nzz

"---------------------------------------------------------------------
" Folds
"---------------------------------------------------------------------
set foldmethod=indent     " folding on indentation
set foldlevel=100         " 'disable' folding at first

" Space increases fold level, if possible, otherwise behaves as normal
nnoremap <silent> <Space> @=(foldlevel('.') ? 'za' : "\<Space>")<CR>
vnoremap <Space> zf

nnoremap + zr             " + reduces fold level across buffer
nnoremap - zm             " - increases fold level across buffer

"---------------------------------------------------------------------
" NERDTree configuration
"---------------------------------------------------------------------
let g:nerdtree_tabs_open_on_console_startup=1 " nerdtree/tab plugin always opens in console
let NERDTreeShowHidden=1                      " always show hidden files
let NERDTreeIgnore=['\.git$', '\.svn', '\.sass-cache$', '\.bundle$', '\.DS_Store$', 'tmp$', 'vendor$', '\.log$', 'doc$', '\.o$', 'CMakeFiles$', 'CMakeCache.txt$', '\.cmake$']

" CTRL+Y To toggle NERDTree
nmap <silent> <C-Y>     :NERDTreeMirrorToggle<CR>

" Close vim if NERDTree is only buffer left open
if has("autocmd")
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif

"---------------------------------------------------------------------
" Filetype specifics
"---------------------------------------------------------------------
if has("autocmd")
	augroup myfiletypes
		" Clear old autocmds in group
		autocmd!
	augroup END
endif

"---------------------------------------------------------------------
" Windows and tabs
"---------------------------------------------------------------------
set winminwidth=0   " Windows can have zero width
set winminheight=0  " Windows can have zero height

" Window switching commands with leader+arrow keys
nmap <leader><Left>  :wincmd h<CR>
nmap <leader><Down>  :wincmd j<CR>
nmap <leader><Up>    :wincmd k<CR>
nmap <leader><Right> :wincmd l<CR>

" Maximize window height
nmap <leader>_       :wincmd _<CR>

" Maximize window width
nmap <leader>\|      :wincmd \|<CR>

" Tab commands with leader keys
nmap <leader>+       :tabn<CR>
nmap <leader>-       :tabc<CR>
nmap <leader>>       :tabn<CR>
nmap <leader><       :tabp<CR>

"---------------------------------------------------------------------
" Miscellanouse key mappings and such
"---------------------------------------------------------------------
autocmd FileType java set makeprg=javac\ $*\ %

" typing a semi-colon starts command (normal mode)
nnoremap ; :

" Q reflows paragraph (normal and visual mode)
nnoremap Q gqap
vnoremap Q gq

" Tab toggles hidden characters (normal mode)
nnoremap <Tab> :set list!<CR>

" Remapping for next/previous file (normal mode)
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

"---------------------------------------------------------------------
" Other plugin config
"---------------------------------------------------------------------

" Session.vim configuration
let g:session_autoload='yes'
let g:session_autosave='yes'
let g:session_default_to_last=1

" Syntastic defaults to passive mode
let g:syntastic_mode_map = {'mode': 'passive'}

