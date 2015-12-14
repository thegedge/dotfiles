if exists('b:did_indent') && b:did_indent
  " be kind. allow users to override this. Does it work?
  finish
endif

setlocal indentexpr=scss_indent#GetIndent(v:lnum)

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
