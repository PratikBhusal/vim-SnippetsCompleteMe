" Start Plugin Guard {{{ ----------------------------------------------------
if (exists('g:scm_on') && g:scm_on == 0) || &compatible
    finish
endif

let g:scm_on = '0.5.0'
let s:keepcpo = &cpoptions
set cpoptions&vim
" Start Plugin Guard }}} ----------------------------------------------------

" Options {{{ ------------------------------------------------------------------
let g:scm_default_map = get(g:, 'scm_default_map', 1)

let g:scm_max_sorted_items = get(g:, 'scm_max_sorted_items', 25)

let g:scm_force_sorted_list = get(g:, 'scm_force_sorted_list', 0)

let g:scm_expand_on_confirm = get(g:, 'scm_expand_on_confirm', 0)

let g:scm_expand_on_enter = get(g:, 'scm_expand_on_enter', 0)
" Options }}} ------------------------------------------------------------------

" Make it work like omni and user-defined completion {{{ -----------------------
if g:scm_expand_on_confirm
    inoremap <silent> <plug>scm_confirm <C-R>=(
        \ exists('b:scm_on') && b:scm_on == 1 && pumvisible()
            \ ? UltiSnips#ExpandSnippet()
            \ : ( pumvisible()
                \ ?  "\<c-y>" : '') )<Cr>
endif

" TODO: Bandage setup. Eventually get it working with <cr> <2017-08-26> "
if g:scm_expand_on_enter
    function! s:ctrl_choice()
        return "\<cr>"
    endfunction

    inoremap <silent> <plug>scm_enter <C-R>=(
        \ exists('b:scm_on') && b:scm_on == 1 && pumvisible()
            \ ? UltiSnips#ExpandSnippet()
            \ : ( pumvisible()
                \ ?  "\<c-y>" : <sid>ctrl_choice() ) )<Cr>
endif
" Make it work like omni and user-defined completion }}} -----------------------

" Default Mappings {{{ ---------------------------------------------------------
if g:scm_default_map
    if has('autocmd')
        if exists('+omnifunc')
            autocmd Filetype *
                \   if &omnifunc == '' |
                \           setlocal omnifunc=snippetscompleteme#main |
                \   endif
        endif
        if exists('+completefunc')
            autocmd Filetype *
                \   if &completefunc == '' |
                \           setlocal completefunc=snippetscompleteme#main |
                \   endif
        endif
    endif

    if g:scm_expand_on_confirm
        imap <silent> <c-y> <plug>scm_confirm
    endif

    " TODO: Bandage setup. Eventually get it working with <cr> <2017-08-26> "
    if g:scm_expand_on_enter
        imap <silent> <cr> <plug>scm_enter
    endif
endif
" Default Mappings }}} ---------------------------------------------------------

" End Plugin Guard {{{ ---------------------------------------------------------
let &cpoptions = s:keepcpo
unlet s:keepcpo
" End Plugin Guard }}} ---------------------------------------------------------

" vim: set expandtab softtabstop=4 shiftwidth=4 foldmethod=marker:
