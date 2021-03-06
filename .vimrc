" Plugin setup and other initialization {{{
set nocompatible   " use vim defaults, not vi defaults
if !exists("vimpager")
  let mapleader=" "  " space bar for leader
endif

" Source a file from ~/.vim
function! VimDirSource(name)
  let pluginrc = $HOME . "/.vim/" . a:name
  if filereadable(pluginrc)
    exec "source " . pluginrc
  else
    echom "Could not find source: " . pluginrc
  endif
endfunction

call VimDirSource("plugins.vimrc")

filetype plugin on

" ------------------------------------------------------------------------- }}}

" Neovim config {{{

if filereadable($PYENV_ROOT . '/versions/neovim3/bin/python')
  let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'
end

" ------------------------------------------------------------------------- }}}

" Syntax coloring {{{

" Manually set true color
if $COLORTERM == "truecolor"
  set termguicolors
endif

colorscheme desert
if &t_Co >= 256 || has("gui_running")
  let g:gruvbox_italic = 0
  let g:gruvbox_contrast_dark = "hard"
  let g:gruvbox_contrast_light = "medium"
  let g:gruvbox_invert_tabline = 1
  try
    colorscheme gruvbox
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
  endtry
endif

if &t_Co > 1
  syntax enable
endif

" Enhance some common highlights
if has("autocmd")
  augroup enhance_syntax
    autocmd!
    au VimEnter * highlight Comment cterm=italic gui=italic
  augroup END
endif

" ------------------------------------------------------------------------- }}}

" Basic configuration {{{
set nowrap                " no line wrapping
set showmatch             " show matching brackets
set mouse=                " disable mouse
set hidden                " buffers are hidden instead of closed
set showtabline=2         " always show tab bar at top
set laststatus=2          " always show status line
set history=1000          " remember more commands
set autowrite             " write on :next, :prev, :!, etc
set undolevels=1000       " max number of changes to remember
set visualbell            " no beeps
set noerrorbells          " no beeps
set confirm               " confirm changes before closing buffers
set splitright            " vertical splits on the right
set autoindent            " automatic indentation
set background=dark
set synmaxcol=500         " max cols to search for syntax highlighting
set number                " show line numbers in the gutter
set norelativenumber      " relative line number offsets in the gutter
set nospell               " default to no spell checking
set concealcursor=""      " show concealed characters on the cursor line

" always show sign column for one thing
if has('nvim')
  set signcolumn=yes:1
elseif !exists("vimpager")
  set signcolumn=yes
endif

" Don't show a preview of the doc information
set completeopt-=preview
set complete=.,w,b,i,t

" Autocompletion when typing commands shows options above instead of inline
set wildmenu
set wildmode=full

" Use ripgrep for grep command
set grepprg=rg\ --vimgrep

" Files to ignore when expanding wildcards
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,.DS_Store
if filereadable($HOME . "/.gitignore_global")
  for line in readfile($HOME . "/.gitignore_global")
    if line =~ '^#' | con | endif
    if line == ''   | con | endif
    if line =~ '^!' | con | endif
    exec "set wildignore+=" . substitute(line, '\v([ ()])', '\\\1', "g")
  endfor
endif

" Whitespace behaviour
set expandtab        " expand tabs by default
set tabstop=2        " number of spaces a <Tab> character equals
set softtabstop=2    " number of spaces a <Tab> character equals (insert mode)
set shiftwidth=2     " number of spaces to use for indenting
set smartindent      " smart autoindent on new lines
set smarttab         " smart <Tab> behaviour at start of line
set copyindent       " copy indent structure when making new lines
set backspace=indent,eol,start

" Non-printable characters
set nolist           " don't show non-printable characters
let &listchars="eol:\u00B7,tab:\u25B9\ "

" Fill characters
let &fillchars="vert:\uFF5C,fold:\u254C"

" Dictionary for CTRL+P and CTRL+N auto-completion
set dictionary=~/.ispell_english,/usr/share/dict/words
set keywordprg=dict

" So :find looks in the current directory tree
set path+=./**

" Backups, swaps, and temps
set nobackup
set noswapfile
set directory=/var/tmp,/tmp

" Set title in terminal window
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
if &term == "screen"
  set t_ts=k
  set t_fs=\
endif
if &term == "screen" || &term =~? "^xterm"
  set title
endif

" Status line
call VimDirSource("statusline.vimrc")

" ------------------------------------------------------------------------- }}}

" Search {{{
set incsearch      " show matches as typing
set ignorecase     " ignore case when searching
set smartcase      " ignore case only if search pattern completely lowercase
set hlsearch       " highlight search terms
set magic          " how backslashes are interpreted in searches

" Remove highlight from searches (normal mode)
nmap <silent> <Leader>/ :nohlsearch<CR>

" n/N will move to the next/previous result and center line on screen
nnoremap n nzz
nnoremap N Nzz

" ------------------------------------------------------------------------- }}}

" Folds {{{
set foldlevel=100         " 'disable' folding at first
set foldopen-=block       " don't open folds for things like {

" Space increases fold level, if possible, otherwise behaves as normal
nnoremap <silent> <Leader><Space> @=(foldlevel('.') ? 'za' : "\<Space>")<CR>
nnoremap + zr    " + reduces fold level across buffer
nnoremap - zm    " - increases fold level across buffer

" ------------------------------------------------------------------------- }}}

" Views {{{
set viewdir=~/.vim/view
set viewoptions=folds,cursor

augroup Views
  au!
  autocmd BufWinLeave * if expand("%") != "" | silent! mkview | endif
  autocmd BufWinEnter * if expand("%") != "" | silent! loadview | endif
augroup END

" ------------------------------------------------------------------------- }}}

" ctags {{{
" autocmd BufWritePost * call jobstart(['ctags', '-R'])

" ------------------------------------------------------------------------- }}}

" Filetype specifics {{{
if has("autocmd")
  augroup ignore_whitespace_errors
    autocmd!
    au filetype diff hi clear ExtraWhitespace
    au filetype git hi clear ExtraWhitespace
    au filetype man hi clear ExtraWhitespace
  augroup END
endif

" ------------------------------------------------------------------------- }}}

" Windows and tabs {{{
set winminwidth=0   " Windows can have zero width
set winminheight=0  " Windows can have zero height

" Leader-based window commands
nmap <Leader><Left>  :wincmd h<CR>
nmap <Leader><Down>  :wincmd j<CR>
nmap <Leader><Up>    :wincmd k<CR>
nmap <Leader><Right> :wincmd l<CR>
nmap <Leader>_       :wincmd _<CR>
nmap <Leader>\|      :wincmd \|<CR>
nmap <Leader>=       :wincmd =<CR>

" Tab commands with leader keys
nmap <Leader>+       :tabnew<CR>
nmap <Leader>-       :tabc<CR>
nmap <Leader>>       :tabn<CR>
nmap <Leader><       :tabp<CR>

" Close location list if there's nothing in there
augroup LocationList
  au!
  autocmd BufWritePost * if get(getloclist(0, {"size": 0}), "size") == 0 | silent! lcl | endif
augroup END

" ------------------------------------------------------------------------- }}}

" Miscellanous key mappings and such {{{

" Highlight extra whitespace at the end of a line
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\v\s+$/

" Color column at 80 characters for soft limit, 100+ for hard limit
let columns = '81,101,'.join(range(121, 500), ',')
let &colorcolumn = columns

" Improve source code indenting
" TODO: tweak me for various formats
set cinoptions=(0,l1,g0,U1,Ws,m1

" Remap a lot of movement commands to not add to the jump list
" TODO find a way to maybe keep them, but compact similar commands into one
nnoremap { :keepj normal! {<CR>
nnoremap } :keepj normal! }<CR>

" up/down movement is always screen-based, rather than line based (e.g., when
" wrapping enabled)
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" typing a semi-colon starts command (normal mode)
nnoremap ; :

" Always jump to line + column with marks
nnoremap ' `

" Q reflows paragraph (normal and visual mode)
nnoremap Q gwap
vnoremap Q gq

" Reloads a file
nnoremap <C-E> :edit<CR>

" Toggle background between dark/light
nnoremap <F5> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Remapping for next/previous file (normal mode)
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

" Simpify working with my vimrc files
nnoremap <Leader>ev :edit ~/.vimrc<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>ep :exec 'edit' $HOME . "/.vim/plugins.vimrc"<CR>
" ------------------------------------------------------------------------- }}}

" FZF {{{

nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>ff :call fzf#run(fzf#wrap('files', { 'source': 'files', 'down': '40%' }, 1))<CR>
nnoremap <Leader>fg :Rg <C-R><C-W><CR>
vnoremap <Leader>fg y:Rg <C-R>"<CR>
nnoremap <Leader>fm :Marks<CR>
nnoremap <Leader>fq :call fzf_quickfix#run()<CR>
nnoremap <Leader>ft :Tags!<CR>

" ------------------------------------------------------------------------- }}}

" Plugin config {{{

" vim-fugitive
noremap gb :Gbrowse!<CR>gv:Gbrowse<CR>

" git-gutter
autocmd BufWritePost * GitGutter

" Language servers for various languages
let g:LanguageClient_serverCommands = {
\ 'python': ['/usr/local/bin/pyls'],
\ 'ruby': ['solargraph', 'stdio'],
\ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
\ 'sh': ['bash-language-server', 'start'],
\ }

let g:LanguageClient_hoverPreview = 'Always'
let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_useVirtualText = 0

augroup LanguageClient_config
  au!

  autocmd User LanguageClientStarted nnoremap set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
  autocmd User LanguageClientStarted nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  autocmd User LanguageClientStarted nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  autocmd User LanguageClientStarted nnoremap <silent> <C-]> :call LanguageClient#textDocument_definition()<CR>
  autocmd User LanguageClientStarted nnoremap <silent> <Leader>R :call LanguageClient#textDocument_rename()<CR>
  autocmd User LanguageClientStarted nnoremap <silent> <Leader>gc :call LanguageClient#contextMenu()<CR>
  autocmd User LanguageClientStarted nnoremap <silent> <Leader>gr :call LanguageClient#textDocument_references()<CR>
  autocmd User LanguageClientStarted nnoremap <silent> <Leader>gQ :call LanguageClient#textDocument_formatting()<CR>

  autocmd User LanguageClientStopped set formatexpr=
  autocmd User LanguageClientStopped nunmap K
  autocmd User LanguageClientStopped nunmap gd
  autocmd User LanguageClientStopped nunmap <C-]>
  autocmd User LanguageClientStopped nunmap <Leader>R
  autocmd User LanguageClientStopped nunmap <Leader>gc
  autocmd User LanguageClientStopped nunmap <Leader>gr
  autocmd User LanguageClientStopped nunmap <Leader>gQ
augroup END

" Not a fan of rustfmt defaults. Need to figure out a configuration that I do like.
let g:rustfmt_autosave = 0

" vim-markdown
let g:markdown_syntax_conceal = 0
let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'sh', 'vim']

" netrw preview in vertical splits, equal size, wide list style
let g:netrw_preview = 0
let g:netrw_winsize = 0
let g:netrw_liststyle = 3

" Syntastic defaults to passive mode
let g:syntastic_mode_map = {'mode': 'passive'}

" vim-go use goimports by default
let g:go_fmt_command = 'goimports'

" vim-diminactive should turn off syntax on inactive buffers
let g:diminactive_use_syntax = 1
let g:diminactive_enable_focus = 0

" Indent guides
let g:indentLine_first_char = '.'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_char_list = ['|', '.', '¦', '.', '┆', '.', '┊', '.']
let g:indentLine_fileTypeExclude = ['help', 'man']

" Deoplete config
let g:deoplete#enable_at_startup = 1

if !exists("vimpager")
  call deoplete#custom#option('ignore_sources', {'_': ['dictionary']})
  call deoplete#custom#source('_',  'max_menu_width', 0)
end

" Don't have a passthrough for vimpager
let g:vimpager_passthrough = 0

" Ale (asynchronous linting engine)
let g:ale_completion_enabled = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_rust_cargo_default_feature_behavior = 'all'

" TODO these are good for dark mode, maybe not for light mode
hi ALEError cterm=none gui=none ctermbg=124 guibg=#792022
hi ALEWarning cterm=none gui=none ctermbg=136 guibg=#593c03

" Don't require different indent levels in between lines when jumping between equal indents
let g:indentwise_equal_indent_skips_contiguous = 0

" Indent blocks assigned to variables one level more than the level of the variable
let g:ruby_indent_assignment_style = 'variable'

" Prefer :Remove over :Delete tpope/eunuch plugin because it interferes with
" my :DeleteAllBuffers flow.
autocmd VimEnter * silent! delc Delete

" ------------------------------------------------------------------------- }}}
