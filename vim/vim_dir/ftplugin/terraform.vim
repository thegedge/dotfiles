set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

"
" tf files, forked from the tf.vim syntax file
"
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match

if !exists("main_syntax")
  let main_syntax = 'terraform'
endif

" Types
syn match   tfNumber   "\<-\?\d\+\>"
syn match   tfFloat    "\<-\?\(\d+\)\?\.\d\+\>"
syn keyword tfBoolean  true false

" Operators
syn match tfOperator  "[-+*/%]" contained

" Identifiers
syn match tfIdentifier "[a-zA-Z0-9-_.]\+"

" Function names
syn keyword tfFunctions  element concat file format formatlist contained
syn keyword tfFunctions  join length lookup replace split contained
syn keyword tfFunctions  keys values contained

syn keyword tfKeywords     resource module provider provisioner
syn keyword tfKeywords     variable output

syn keyword tfInterpOnlyKeywords  var path count self contained

" SpecialChar
syn match tfSpecialChar "\\[abcfnrtyv\\'\"]" contained
syn match tfSpecialChar "\\x[0-9a-fA-F]\{2}" contained
syn match tfSpecialCharEsc "\[\+" contained

" Comments
syn keyword  tfTodo TODO Todo todo  contained
syn keyword  tfTodo XXX xxx  contained

syn region tfComment  start="//" end="$"  contains=tfTodo
syn region tfComment  start="#" end="$"  contains=tfTodo
syn region tfComment  start="/\*" end="\*/"  contains=tfTodo

" String
syn region tfString matchgroup=None start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=tfInterpolation

" Parents
syn region tfParent matchgroup=Delimiter start="\[" end="\]" contains=ALLBUT,tfInterpOnlyKeywords
syn region tfParent matchgroup=Delimiter start="{" end="}" contains=ALLBUT,tfInterpOnlyKeywords
syn region tfParent matchgroup=Delimiter start="(" end=")" contains=ALLBUT,tfIdentifier

syn region tfInterpolation matchgroup=Delimiter start="\${" end="}" contains=ALLBUT,tfIdentifier,tfComment

syn match tfParentError "[)}\]]"

" Define the default highlighting
hi def link tfComment             Comment
hi def link tfString              String
hi def link tfNumber              Number
hi def link tfFloat               Float
hi def link tfBoolean             Boolean
hi def link tfIdentifier          Identifier
hi def link tfFunctions           Function
hi def link tfLabel               Label
hi def link tfSpecialChar         SpecialChar
hi def link tfSpecialCharEsc      SpecialChar
hi def link tfKeywords            Keyword
hi def link tfInterpOnlyKeywords  Keyword
hi def link tfParentError	      Error
hi def link tfTodo                Todo
hi def link tfOperator            Operator

let b:current_syntax = "terraform"
if main_syntax == "terraform"
  unlet main_syntax
endif
