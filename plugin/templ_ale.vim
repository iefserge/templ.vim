" templ_ale.vim - Configure ALE to work with Templ LSP
if exists('g:loaded_templ_ale')
  finish
endif
let g:loaded_templ_ale = 1

function! TemplFindRoot(buffer) abort
    let l:root = ale#path#FindNearestFile(a:buffer, 'go.mod')
    return fnamemodify(l:root, ':h')
endfunction

function! TemplFmt(buffer) abort
    return {
    \   'command': $GOPATH . '/bin/templ fmt %t',
    \   'read_temporary_file': 1,
    \}
endfunction

if exists('g:loaded_ale')
  call ale#linter#Define('templ', {
  \   'name': 'templ',
  \   'lsp': 'stdio',
  \   'executable': $GOPATH . '/bin/templ',
  \   'command': '%e lsp',
  \   'project_root': function('TemplFindRoot'),
  \})

  call ale#fix#registry#Add('templfmt', 'TemplFmt', ['templ'], 'templ fmt')
endif
