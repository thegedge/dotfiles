"
" Buffer deletion functions
"
function! s:GetHiddenBuffers()
    let l:tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(l:tpbl, tabpagebuflist(v:val))')
    return filter(range(1, bufnr('$')), 'bufexists(v:val) && index(l:tpbl, v:val)==-1')
endfunction

function! s:DeleteBuffers(buffers)
	for bnum in a:buffers
		if bufexists(bnum) && bufname(bnum) !~? 'NERD_tree'
			execute 'bdelete' bnum
		endif
	endfor
endfunction

command! DeleteAllBuffers call s:DeleteBuffers(range(1, bufnr('$')))
command! DeleteHiddenBuffers call s:DeleteBuffers(s:GetHiddenBuffers())

