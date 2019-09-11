if !filereadable($HOME. "/.vim/autoload/plug.vim")
  echo "Installing vim-plug..."
  echo ""
  silent execute
    \ '!curl -sfLo ~/.vim/autoload/plug.vim' . ' --create-dirs' .
    \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

filetype off
call plug#begin('~/.vim/plugged')

" Coloring
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'

" Plugins for syntax
Plug 'cakebaker/scss-syntax.vim',        { 'for': 'scss' }
Plug 'rust-lang/rust.vim',               { 'for': 'rust' }
Plug 'fatih/vim-go',                     { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'peterhoeg/vim-qml',                { 'for': 'qml' }
Plug 'tpope/vim-markdown',               { 'for': 'markdown' }
Plug 'vim-scripts/gcov.vim',             { 'for': 'gcov' }
Plug 'vim-scripts/swig-syntax',          { 'for': 'swig' }
Plug 'hashivim/vim-terraform',           { 'for': 'terraform' }
Plug 'tpope/vim-rails',                  { 'for': 'ruby' }
Plug 'tpope/vim-bundler',                { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby',                { 'for': 'ruby' }
Plug 'kchmck/vim-coffee-script',         { 'for': 'coffee' }
Plug 'mxw/vim-jsx',                      { 'for': 'javascript.jsx' }
Plug 'solarnz/thrift.vim',               { 'for': 'thrift' }
Plug 'google/vim-jsonnet',               { 'for': 'jsonnet' }
Plug 'chrisbra/csv.vim',                 { 'for': 'csv' }
Plug 'cespare/vim-toml',                 { 'for': 'toml' }
Plug 'jparise/vim-graphql',              { 'for': 'graphql' }
Plug 'nelstrom/vim-textobj-rubyblock',   { 'for': 'ruby' }
Plug 'mustache/vim-mustache-handlebars', { 'for': ['html.mustache', 'html.handlebars'] }
Plug 'pest-parser/pest.vim',             { 'for': 'pest' }

Plug 'kana/vim-textobj-user'
Plug 'powerman/vim-plugin-AnsiEsc',      { 'on': 'AnsiEsc' }

if !exists("vimpager")
  " Language server support
  Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

	" Additional character info (e.g., html entity, unicode name)
	Plug 'tpope/vim-characterize'

	" Movements for indent levels
	Plug 'jeetsukumaran/vim-indentwise'

	" A git gutter to show lines added/removed/modified
	Plug 'airblade/vim-gitgutter'

  " Emphasizes the focused window by making it bigger
  Plug 'roman/golden-ratio'

  " UNIX operations, such as :Move (for rename) and :Remove (for delete)
  Plug 'tpope/vim-eunuch'

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

	" Add "end" structures to "start" structures
	Plug 'tpope/vim-endwise'

  " Git support
  Plug 'tpope/vim-fugitive' |
  \ Plug 'tpope/vim-rhubarb'

  " Repeat plugin commands with .
  Plug 'tpope/vim-repeat'

  " Manipulate surroundings
  Plug 'tpope/vim-surround'

  " Fuzzy matching and searching for all the things
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
  Plug 'junegunn/fzf.vim'

  " Async linting
  "Plug 'w0rp/ale'

  " Function to put quickfix list in fzf
	Plug 'fszymanski/fzf-quickfix'

  " Autocomplete on type
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " Show function signature and inline doc.
  Plug 'Shougo/echodoc.vim'

  " Update environment when switching to a shadowenv directory
  Plug 'Shopify/shadowenv.vim'
endif

call plug#end()

" Better matching for HTML tags
runtime! macros/matchit.vim
