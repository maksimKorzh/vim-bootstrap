" Load Bootstrap 5 snippets 
let s:snippets = json_decode(join(readfile(expand('<sfile>:p:h') . '/snippets.json'), "\n"))

" Insert Bootstrap code snippet
function! s:bootstrap(command)
   " Calculate indentation
  let indentation = indent('.') + 1

 " Insert new line
  if line('$') > 1 || getline(1) != ''
    call append(line('.'), "")
    call cursor(line('.')+1, 1)
  endif

  " Insert code snippet
  for line in s:snippets[a:command]
    execute "normal! i" . repeat(" ", indentation) . "\<ESC>"
    execute "normal! i" . line . "\<CR>"
  endfor

  " Clean up
  normal! dd$
endfunction

" Specify snippet's keys as user defined commands
for [key, val] in items(s:snippets)
  execute "command! " . key . " call s:bootstrap('" . key . "')"
endfor

" Help message
" echo "Type :BsIndex to insert Bootstrap starter template"

" This command helps to enclose HTML code block into quotes
" '<,'>s/"/\\"/g|'<,'>s/$/",/|'<,'>s/^/    "/
