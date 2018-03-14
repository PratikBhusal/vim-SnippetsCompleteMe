function! snippetscompleteme#ultisnips#get_list(...)
    " Initilize List. Add previous entries if a parameter was included
    let l:list = (exists('a:1') && type('a:1') == 3) ? a:1 : []

    " Check for any avaliable snippets
    let l:snippets = UltiSnips#SnippetsInCurrentScope()
    if empty(l:snippets)
        return l:list
    endif

    " Add the snippet to the completion menu
    for l:snip in keys(l:snippets)
        " get(l:snippets, l:snip) is the snippet description
        call add(l:list, {
            \ 'word' : l:snip,
            \ 'menu' : '[US] ' . get(l:snippets, l:snip),
        \ })
    endfor

    " Sort and call the completion menu
    if (len(l:list) <= g:scm_max_sorted_items) || g:scm_force_sorted_list
        let l:list = sort(l:list)
    endif

    return l:list
endfunction

" vim: set expandtab softtabstop=4 shiftwidth=4 foldmethod=marker:
