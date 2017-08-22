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

if !exists('g:scm_expand_on_confirm')
  let g:scm_expand_on_confirm = 0
endif
" Options }}} ------------------------------------------------------------------

" Functions {{{ ----------------------------------------------------------------
if g:scm_expand_on_confirm
    function! s:confirm_choice()
        return "\<cr>"
    endfunction
endif
" Functions }}} ----------------------------------------------------------------

" Make it work like omni and user-defined completion {{{ -----------------------
if g:scm_default_map
    inoremap <silent> <C-x><C-s> <C-R>=(snippetscompleteme#main() == 0 ? ''
        \ : UltiSnips#ExpandSnippet())<CR>
    if g:scm_expand_on_confirm
        inoremap <silent> <c-y> <C-R>=(pumvisible() ? UltiSnips#ExpandSnippet()
            \ : <sid>confirm_choice())<CR>
    endif
endif

if g:scm_move_with_ctrl_s
    inoremap <expr> <silent> <C-s> pumvisible() ?  "\<C-n>" : "\<C-s>"
endif
" Make it work like omni and user-defined completion }}} -----------------------
