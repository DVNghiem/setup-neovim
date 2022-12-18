let g:coc_global_extensions = [
	  \ 'coc-go',
	  \ 'coc-tsserver',
	  \ 'coc-html',
	  \ 'coc-css',
	\
	  \ 'coc-yaml',
	  \ 'coc-json',
	  \ 'coc-vimlsp',
	  \ 'coc-emmet',
	  \ 'coc-tag',
	  \ ]

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
	execute 'H ' . expand('<cword>')
  else
	call CocActionAsync('doHover')
  endif
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap <silent> gd <Plug>(coc-definition)
hi! CocErrorSign guifg=#d97084
hi! CocWarningSign guifg=#e9cb87
hi! CocInfoSign guifg=#d0d2d2
hi! CocHintSign guifg=#6face4

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
							  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
