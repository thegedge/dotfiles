"---------------------------------------------------------------------
" Gedge's .vimrc
"---------------------------------------------------------------------
set nocompatible

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

"---------------------------------------------------------------------
" Basic configuration
"---------------------------------------------------------------------

set nowrap           " no line wrapping
set tabstop=4
set shiftwidth=4
set softtabstop=4
set ruler            " ruler
set number           " line numbering
set autoindent
set showmatch        " show matching brackets
set mouse=a          " enable mouse
set pastetoggle=<F2> " F2 for paste mode
set hidden           " buffers are hidden instead of closed

" Tabs
set showtabline=2    " always show tab line


" Windows
set winminwidth=0
set winminheight=0

" Search
set incsearch      " show matches as typing
set ignorecase     " ignore case when searching
set smartcase      " ignore case only if search pattern completely lowercase
set hlsearch       " highlight search terms

" Dictionary for CTRL+P and CTRL+N auto-completion
set dictionary=~/.ispell_english,/usr/share/dict/words
set complete=.,w,k
set keywordprg=dict

" Other stuff
set mat=5          " bracket blinking
set laststatus=2   " always show status line
set history=1000   " remember more stuff
set autowrite      " write on make/shell commands
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set visualbell     " no beeps
set noerrorbells   " no beeps
set nobackup       " no backup files (still swaps though)
set confirm        " confirm changes before closing buffers

" Backup and temporary file directories
set backup
set backupdir=~/.vim/backups
set directory=~/.vim/tmp

" Close vim if NERDTree is only buffer left open
if has("autocmd")
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif

" Remember cursor position for files
set viminfo='10,\"100,:20,%,n~/.vim/.viminfo
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 

" Enable filetype-specific indenting and plugins
filetype plugin indent on

"---------------------------------------------------------------------
" Key mappings and such
"---------------------------------------------------------------------

" typing a semi-colon starts command
nnoremap ; :

" remap Q to reflow paragraph (normal)
nnoremap Q gqap

" Remove highlight from searches
nmap <silent> <leader>/ :nohlsearch<CR>

" remap Q to reflow paragraph (visual)
vnoremap Q gq

" Remapping for next/previous file
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

" Window commands with leader key
nmap <leader><Left>  :wincmd h<CR>
nmap <leader><Down>  :wincmd j<CR>
nmap <leader><Up>    :wincmd k<CR>
nmap <leader><Right> :wincmd l<CR>
nmap <leader>+       :wincmd +<CR>
nmap <leader>-       :wincmd -<CR>
nmap <leader>_       :wincmd _<CR>
nmap <leader>>       :wincmd ><CR>
nmap <leader><       :wincmd <<CR>
nmap <leader>\|      :wincmd \|<CR>

"---------------------------------------------------------------------
" NERDTree configuration
"---------------------------------------------------------------------
"
" CTRL+Y To toggle NERDTree
nmap <silent> <C-Y>     :NERDTreeMirrorToggle<CR>
nmap <silent> <leader>Y :NERDTreeMirrorToggle<CR>

let g:nerdtree_tabs_open_on_console_startup=1 " nerdtree/tab plugin always opens in console
let NERDTreeShowHidden=1                      " always show hidden files
let NERDTreeIgnore=['\.git$', '\.sass-cache$', '\.bundle$', '\.DS_Store$', 'tmp$', 'vendor$', 'log$', 'doc$']

"---------------------------------------------------------------------
" Filetype specifics
"---------------------------------------------------------------------
" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

if has("autocmd")
	augroup myfiletypes
		" Clear old autocmds in group
		autocmd!

		" Auto indenting and tab widths
		autocmd FileType ruby,eruby,yaml,haml,scss,javascript :setlocal sw=2 sts=2 ts=2 et ai
		autocmd FileType python :setlocal sw=4 sts=4 ts=4 et ai
	augroup END
endif

"---------------------------------------------------------------------
" Programming stuff
"---------------------------------------------------------------------
autocmd FileType java set makeprg=javac\ $*\ %

set complete=.,w,b,u,t,i  " completion (key = TAB in insert mode)
set foldmethod=indent     " folding on indentation
set foldlevel=100         " 'disable' folding at first

function! TabCompletion()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\<Tab>"
    else
        if &omnifunc != ''
            return "\<C-X>\<C-O>"
        elseif &dictionary != ''
            return "\<C-K>"
        else
            return "\<C-N>"
        endif
    endif
endfunction

inoremap <Tab> <C-R>=TabCompletion()<cr>

"---------------------------------------------------------------------
" Session.vim configuration
"---------------------------------------------------------------------
let g:session_autoload='yes'
let g:session_autosave='yes'
let g:session_default_to_last=1


