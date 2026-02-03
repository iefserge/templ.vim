" templ_goto.vim - Go to templ definitions from Go files with vim-go
if exists('g:loaded_templ_goto')
  finish
endif
let g:loaded_templ_goto = 1

let s:templ_func_name = ''
let s:templ_search_func = ''

function! s:PositionTemplCursor(timer)
  keepjumps normal! gg
  let l:pattern = '^templ ' . s:templ_search_func . '('
  keepjumps call search(l:pattern, 'cW')
  keepjumps normal! ^w
endfunction

function! s:RedirectToTempl()
  let l:currentFile = expand('%:p')
  let l:match = matchlist(l:currentFile, '\v^(.*)_templ\.go$')
  if empty(l:match)
    return
  endif
  if empty(s:templ_func_name)
    return
  endif

  let l:templFile = l:match[1] . '.templ'
  let s:templ_search_func = s:templ_func_name
  let s:templ_func_name = ''

  if filereadable(l:templFile)
    execute "normal! \<C-O>"
    normal! m'
    keepjumps execute 'edit ' . fnameescape(l:templFile)
    keepjumps setlocal filetype=templ
    " Any way to improve this to avoid timer?
    call timer_start(1, function('s:PositionTemplCursor'))
  endif
endfunction

function! TemplGoToDefinition()
  let s:templ_func_name = expand('<cword>')
  GoDef
endfunction

" When entering *_templ.go files, open *.templ instead.
" But only if we captured function name from GoToDefinition call.
augroup templ_goto
  autocmd!
  autocmd BufEnter *_templ.go call s:RedirectToTempl()
augroup END
