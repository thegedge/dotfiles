"---------------------------------------------------------------------
" Status Line
"--------------------------------------------------------------------
function! FugitiveLine()
  let out = ''
  let has_fugitive = (exists('g:loaded_fugitive') && g:loaded_fugitive == 1)
  if l:has_fugitive
    let out = " \u2442 " . fugitive#head() . ' '
  endif
  return out
endfunction

function! CharDescription()
  let c = matchstr(getline('.')[col('.') - 1:-1], '.')
  let nr = (c ==# "\n" ? 0 : char2nr(c))

  let has_characterize = (exists('g:loaded_characterize') && g:loaded_characterize == 1)
  if l:has_characterize
    let out = '<' . characterize#description(nr, 'unknown')
    let entity = characterize#html_entity(nr)
    if !empty(entity)
      let out .= ', ' . entity
    endif
    let out .= '> ' . printf('U+%04X', nr)
  else
    let out = printf('U+%04X', nr)
  endif

  return out
endfunction

let &statusline=""
"let &statusline.="%2*\ \ %t\ \ "                             " tail of the filename
let &statusline.="%1*\ \ %{strlen(&fenc)?&fenc:'none'}"      " file encoding
let &statusline.="\ \u00B7\ %{&ff}"                          " file format
let &statusline.="\ \u00B7\ %{strlen(&ft)?&ft:'<unknown>'}"  " file type
let &statusline.="%h"                                        " help file flag
let &statusline.="%m"                                        " modified flag
let &statusline.="%r"                                        " read only flag
let &statusline.="\ \ "
let &statusline.="%0*%{FugitiveLine()}"                      " git branch
let &statusline.="%="                                        " left/right separator
let &statusline.="%{CharDescription()}\ "                    " char under cursor
let &statusline.="%4*\ l\ %1*%5l/%-5L\ "                     " cursor line/total lines
let &statusline.="%5*\ c\ %2*%3c-%-3v\ "                     " cursor column/virtual column
let &statusline.="%3*\ \ %P\ \ "                             " percent through file

hi User1 term=bold,reverse cterm=bold,reverse ctermfg=235 ctermbg=253
hi User2 term=bold,reverse cterm=bold,reverse ctermfg=234 ctermbg=253
hi User3 term=bold,reverse cterm=bold,reverse ctermfg=233 ctermbg=253
hi User4 term=bold,reverse cterm=bold,reverse ctermfg=235 ctermbg=241
hi User5 term=bold,reverse cterm=bold,reverse ctermfg=234 ctermbg=241

