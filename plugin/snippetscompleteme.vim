" Options {{{ ------------------------------------------------------------------
if !exists('g:scm_default_map')
  let g:scm_default_map = 1
endif

if !exists('g:scm_sort_snippet_list')
  let g:scm_sort_snippet_list = 1
endif

if !exists('g:scm_move_with_ctrl_s')
  let g:scm_move_with_ctrl_s = 0
endif
" Options }}} ------------------------------------------------------------------

" Make it work like omni and user-defined completion {{{ -----------------------
if g:scm_default_map
    inoremap <silent> <C-x><C-s> <C-r>=snippetscompleteme#main()<CR>
endif

if g:scm_move_with_ctrl_s
    inoremap <expr> <silent> <C-s> pumvisible() ?  "\<C-n>" : "\<C-s>"
endif
" Make it work like omni and user-defined completion }}} -----------------------









