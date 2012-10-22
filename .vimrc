"---------------------------------------------------------------------
" Gedge's .vimrc
"---------------------------------------------------------------------
set nocompatible " use vim defaults, not vi defaults

" Map leader key to comma
let mapleader= ","

" Load plugins
call pathogen#infect('plugins')

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
set list             " show non-printable characters
set listchars=eol:·,tab:▹\ 

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

"---------------------------------------------------------------------
" Search
"---------------------------------------------------------------------
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
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

nnoremap + zr             " + reduces fold level across buffer
nnoremap - zm             " - increases fold level across buffer

"---------------------------------------------------------------------
" NERDTree configuration
"---------------------------------------------------------------------
let g:nerdtree_tabs_open_on_console_startup=1 " nerdtree/tab plugin always opens in console
let NERDTreeShowHidden=1                      " always show hidden files
let NERDTreeIgnore=['\.git$', '\.svn', '\.sass-cache$', '\.bundle$', '\.DS_Store$', 'tmp$', 'vendor$', 'log$', 'doc$', '\.o$', 'CMakeFiles$', 'CMakeCache.txt$', '\.cmake$']

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

" Window commands with leader key
nmap <leader><Left>  :wincmd h<CR>  " move cursor to window to left of current
nmap <leader><Down>  :wincmd j<CR>  " move cursor to window below the current
nmap <leader><Up>    :wincmd k<CR>  " move cursor to window above the current
nmap <leader><Right> :wincmd l<CR>  " move cursor to window to right of current
nmap <leader>+       :wincmd +<CR>  " increase window height
nmap <leader>-       :wincmd -<CR>  " decrease window height
nmap <leader>_       :wincmd _<CR>  " maximize window height
nmap <leader>>       :wincmd ><CR>  " increase window width 
nmap <leader><       :wincmd <<CR>  " decrease window width
nmap <leader>\|      :wincmd \|<CR> " maximize window width

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

