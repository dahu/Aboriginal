" User Completion for Abbreviations
" Barry Arthur, Jan 06 2012

function! AbbrList(word)
  let abbrs = ''
  redir =>abbrs
  silent! exe "iabbr ".a:word
  redir END
  if abbrs =~ '^\_s*No abbreviation found$'
    return []
  else
    return map(map(split(abbrs, '\n'), 'substitute(v:val, "^i  ", "", "")'), 'split(v:val)')
  endif
endfunction

function! CompleteAbbrevs(findstart, base)
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
    let res = AbbrList(a:base)
    return map(res, 'v:val[0]')
  endif
endfun
set completefunc=CompleteAbbrevs
