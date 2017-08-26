" Start PLugin Guard {{{ ----------------------------------------------------
if (exists("g:scm_on") && g:scm_on == 0) || &cp
    finish
endif

let g:scm_on = "0.4.0"
let s:keepcpo = &cpo
set cpo&vim
" Start Plugin Guard }}} ----------------------------------------------------

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

if !exists('g:scm_expand_on_enter')
    let g:scm_expand_on_enter = 0
endif
" Options }}} ------------------------------------------------------------------

" Make it work like omni and user-defined completion {{{ -----------------------
inoremap <silent> <plug>scm_init <C-R>=(snippetscompleteme#main() == 1
    \ ? UltiSnips#ExpandSnippet()
    \ : '')<CR>

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

if g:scm_move_with_ctrl_s
    inoremap <expr> <silent> <plug>scm_next
        \ exists('b:scm_on') && b:scm_on == 1 && pumvisible()
            \ ?  "\<C-n>" : "\<C-s>"
endif
" Make it work like omni and user-defined completion }}} -----------------------

" Default Mappings {{{ ---------------------------------------------------------
if g:scm_default_map
    imap <silent> <C-x><C-s> <plug>scm_init

    if g:scm_expand_on_confirm
        imap <silent> <c-y> <plug>scm_confirm
    endif

    " TODO: Bandage setup. Eventually get it working with <cr> <2017-08-26> "
    if g:scm_expand_on_enter
        imap <silent> <c-cr> <plug>scm_enter
    endif

    if g:scm_move_with_ctrl_s
        imap <silent> <c-s> <plug>scm_next
    endif
endif
" Default Mappings }}} ---------------------------------------------------------

" End Plugin Guard {{{ ---------------------------------------------------------
let &cpo = s:keepcpo
unlet s:keepcpo
" End Plugin Guard }}} ---------------------------------------------------------

" vim: set expandtab softtabstop=4 shiftwidth=4 foldmethod=marker:
