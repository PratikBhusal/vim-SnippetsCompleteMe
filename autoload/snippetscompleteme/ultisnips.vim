function! snippetscompleteme#ultisnips#get_list(...)
    " Initilize List. Add previous entries if a parameter was included
    if !exists('a:1') && type('a:1') != 3
        let l:list = []
    else
        let l:list = a:1
    endif

    " Check for any avaliable snippets
    let l:snippets = UltiSnips#SnippetsInCurrentScope()
    if empty(l:snippets)
        return l:list
    endif

    " Add the snippet to the completion menu
    for l:snip in keys(l:snippets)
        let l:description = get(l:snippets, l:snip)
        call add(l:list, {
            \ 'word' : l:snip,
            \ 'menu' : '[US] ' . l:description,
        \ })
    endfor

    " Sort and call the completion menu
    if g:scm_sort_snippet_list
        let l:list = sort(l:list)
    endif

    return l:list
endfunction

" vim: set expandtab softtabstop=4 shiftwidth=4 foldmethod=marker:
