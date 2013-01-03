"
" Buffer deletion functions
"
function DeleteBuffers(buffers)
	echo a:buffers
	for bnum in a:buffers
		if bufname(bnum) =~? 'NERD_tree'
			NERDTreeClose
		else
			execute 'bdelete' bnum
		endif
	endfor
	redraw!	
endfunction

function DeleteAllBuffersOutsideCurrentTab()
	let l:buffers = range(1, bufnr('$'))
	let l:exclude = tabpagebuflist(tabpagenr())
	call DeleteBuffers(filter(l:buffers, 'bufloaded(v:val) && index(l:exclude, v:val) < 0'))
endfunction

function DeleteAllBuffersButCurrent()
	let l:buffers = range(1, bufnr('$'))
	call DeleteBuffers(filter(l:buffers, 'bufloaded(v:val) && v:val != bufnr("%")'))
endfunction

command! DeleteAllBuffers call DeleteBuffers(range(1, bufnr('$')))
command! DeleteAllButCurrent call DeleteAllBuffersButCurrent()
command! DeleteAllButCurrentTab call DeleteAllBuffersOutsideCurrentTab()

