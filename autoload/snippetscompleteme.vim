augroup reset_scm "{{{
    autocmd!
    autocmd CompleteDone * let b:scm_on = 0
augroup end
"}}}

function! snippetscompleteme#main(findstart, base)
    if a:findstart " {{{
        " Locate the start of the word
        let l:start = col('.') - 1
        " TODO: Profile to see if continuous getline calls or if a single variable
        " declaration is more time efficient <17-08-20>
        while l:start > 0 && getline('.')[l:start - 1] =~# '\a'
            let l:start -= 1
        endwhile

        " TODO: Add support for more snippet plugins and learn how to extract
        " snippets? <17-08-20>
        if !exists(':UltiSnipsEdit')
            echohl ErrorMsg | echom 'Snippets plugin not found' | echohl None
            let b:scm_on = 0
            return -3
        endif
        let s:options = snippetscompleteme#ultisnips#get_list()

        if len(s:options) == 1
            let l:line = getline('.')[l:start : len( getline('.') ) - 1]

            if l:line ==#  s:options[0]['word']
                let b:scm_on = 0
                call UltiSnips#ExpandSnippet()
            else
                let b:scm_on = 1
                call complete(l:start+1, s:options)
            endif

            return -3
        endif


        return l:start
    " }}}
    else " {{{
        " TODO: Add support for more snippet plugins and learn how to extract
        " snippets? <17-08-20>
        if !exists(':UltiSnipsEdit')
            return []
        endif

        " If there is only one avaliable snippet, automatically expand it
        " TODO: If possible, implement a feature that lets <cr> close the menu and
        " expand the snippet. Will have to check for plugin compatibiliy <17-08-20>
        let b:scm_on = 1
        return s:options
    endif
    " }}}
endfunction

" vim: set expandtab softtabstop=4 shiftwidth=4 foldmethod=marker:
