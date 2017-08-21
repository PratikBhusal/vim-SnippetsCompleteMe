function! snippetscompleteme#get_ultisnips_list(...)
    " Initilize List. Add previous entries if a parameter was included
    if !exists('a:1')
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

function! snippetscompleteme#main()
    " Locate the start of the word
    let l:start = col('.') - 1
    " TODO: Profile to see if continuous getline calls or if a single variable
    " declaration is more efficient <17-08-20>
    while l:start > 0 && getline('.')[l:start - 1] =~ '\a'
        let l:start -= 1
    endwhile
    let l:start = l:start + 1

    " Initilize snippet container
    " TODO: Add support for more snippet plugins? <17-08-20>
    let l:options = []
    if !exists(':UltiSnipsEdit')
        echohl ErrorMsg | echom "Snippets plugin not found" | echohl None
        return ''
    else
        let l:options = snippetscompleteme#get_ultisnips_list()
    endif

    " TODO: If an evantually created option is enabled, let <cr> close menu and
    " expand the snippet <17-08-20>
    call complete(l:start, l:options)

    return ''
endfunction
