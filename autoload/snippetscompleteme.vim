autocmd CompleteDone * let b:scm_on = 0

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
    let l:options = []
    " TODO: Add support for more snippet plugins and learn how to extract
    " snippets? <17-08-20>
    if !exists(':UltiSnipsEdit')
        echohl ErrorMsg | echom "Snippets plugin not found" | echohl None
        return -1
    else
        let l:options = snippetscompleteme#ultisnips#get_list()
    endif

    " If there is only one avaliable snippet, automatically expand it
    if len(l:options) == 1
        return 1
    endif

    " TODO: If possible, implement a feature that lets <cr> close the menu and
    " expand the snippet. Will have to check for plugin compatibiliy <17-08-20>
    call complete(l:start, l:options)
    let b:scm_on = 1

    return 0
endfunction

" vim: set expandtab softtabstop=4 shiftwidth=4 foldmethod=marker:
