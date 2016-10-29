let installed_vim_plug = 0

if !filereadable(g:vim_config_directory . '/autoload/plug.vim')
  echo "Installing vim-plug.."
  echo ""
  silent execute
    \ '!curl -sfLo ' . g:vim_config_directory . '/autoload/plug.vim' . ' --create-dirs' .
    \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  let installed_vim_plug=1
endif

filetype off
call plug#begin('~/.vim/plugged')

" Coloring
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'

" Plugins for syntax and completion
Plug 'cakebaker/scss-syntax.vim',      { 'for': 'scss' }
Plug 'ebfe/vim-racer',                 { 'for': 'rust' }
Plug 'wting/rust.vim',                 { 'for': 'rust' }
Plug 'fatih/vim-go',                   { 'for': 'go' }
Plug 'peterhoeg/vim-qml',              { 'for': 'qml' }
Plug 'tpope/vim-markdown',             { 'for': 'markdown' }
Plug 'vim-scripts/gcov.vim',           { 'for': 'gcov' }
Plug 'vim-scripts/swig-syntax',        { 'for': 'swig' }
Plug 'hashivim/vim-terraform',         { 'for': 'terraform' }
Plug 'tpope/vim-rails',                { 'for': 'ruby' }
Plug 'tpope/vim-bundler',              { 'for': 'ruby' }
Plug 'kchmck/vim-coffee-script',       { 'for': 'coffee' }
Plug 'mxw/vim-jsx',                    { 'for': 'javascript.jsx' }
Plug 'solarnz/thrift.vim',             { 'for': 'thrift' }

Plug 'kana/vim-textobj-user' |
\ Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }

Plug 'powerman/vim-plugin-AnsiEsc',    { 'on': 'AnsiEsc' }

" Additional character info (e.g., html entity, unicode name)
Plug 'tpope/vim-characterize'

if !exists("vimpager")
  " In-place rename file for a buffer (like :saveas, but deletes old file)
  Plug 'vim-scripts/Rename'

  " Dim inactive panes
  Plug 'blueyed/vim-diminactive'

  " Auto ':set paste' when pasting
  Plug 'ConradIrwin/vim-bracketed-paste'

  " Code/markup commenting shortcuts
  Plug 'scrooloose/nerdcommenter'

  " Table-based manipulations
  Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

  " Text object for function arguments (a, and i,)
  Plug 'PeterRincker/vim-argumentative'

  " Git support
  Plug 'tpope/vim-fugitive'

  " Repeat plugin commands with .
  Plug 'tpope/vim-repeat'

  " Manipulate surroundings
  Plug 'tpope/vim-surround'

  " Fuzzy matching and searching for all the things
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " Autocomplete on type
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

if installed_vim_plug == 1
  echo "Installing plugins..."
  echo ""
  PlugInstall
endif

call plug#end()

" Better matching for HTML tags
runtime! macros/matchit.vim
